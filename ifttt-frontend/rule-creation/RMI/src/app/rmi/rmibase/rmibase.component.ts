import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';

import { UserDataService, Rule } from '../../user-data.service';

export interface RuleUIRepresentation {
  words: string[]; // e.g. IF, AND, THEN
  icons: string[]; // the string name of the icons
  descriptions: string[]; // the descriptions for each of the icons
}

@Component({
  selector: 'rmi-rmibase',
  templateUrl: './rmibase.component.html',
  styleUrls: ['./rmibase.component.css']
})
export class RmibaseComponent implements OnInit {

  public RULES: RuleUIRepresentation[];
  public ruleids: number[];
  private unparsedRules: Rule[];

  constructor(public userDataService: UserDataService, private route: Router, private router: ActivatedRoute) {
    //get the csrf cookie
    this.userDataService.getCsrfCookie().subscribe(data => {
      this.router.params.subscribe(params => {
        // then get hashed_id and task_id from router params
        if (!this.userDataService.user_id) {
          this.userDataService.mode = "rules";
          this.userDataService.hashed_id = params["hashed_id"];
          this.userDataService.task_id = params["task_id"];
        } 
        // get userid and user's rules
        this.userDataService.getRules(this.userDataService.hashed_id)
                        .subscribe(
                          data => {
                            this.unparsedRules = data["rules"];
                            if (data["userid"]) {this.userDataService.user_id = data["userid"];}
                            if (this.unparsedRules) {
                              var i: number;
                              for (i = 0; i < this.unparsedRules.length; i++) {
                                this.ruleids[i] = this.unparsedRules[i].id;
                              }
                              this.parseRules();
                            }
                          }
                        );
    })});
    this.ruleids = [];
    
  }
  
  //parse rules into displayable form for list
  private parseRules() {
    const rules = this.unparsedRules;
    this.RULES = rules.map((rule => {
      const words = [];
      const descriptions = [];
      const icons = [];

      // add the if clause stuff
      for (let i = 0; i < rule.ifClause.length; i++) {
        let clause = rule.ifClause[i];
        words.push(i == 0 ? "If" : (i > 1 ? "and" : "while"));
        icons.push(clause.channel.icon);
        const description = clause.text;
        descriptions.push(description);
      }

      // add the then clause
      words.push("then");
      const description = rule.thenClause[0].text;
      descriptions.push(description);
      icons.push(rule.thenClause[0].channel.icon);

      // add the priority clause (not currently a feature but Abhi wrote it)
      if (rule.priority) {
        words.push('PRIORITY');
        const priority_description = `${rule.priority}`;
        icons.push('timer');
        descriptions.push(priority_description);
      }

      const ruleRep: RuleUIRepresentation = {
        words: words,
        icons: icons,
        descriptions: descriptions
      };
      return ruleRep;
    }));
  }
  

  ngOnInit() {
  }

  gotoCreate() {
    delete this.userDataService.currentlyStagedRule;
    localStorage['currentlyStagedRuleIndex'] = -1;
    this.route.navigate(["/create"]);
  }

  editRule(index: number) {
    //prepare values in userdataservice for editing
    this.userDataService.editingRuleID = this.ruleids[index];
    this.userDataService.editing = true;
    this.userDataService.stopLoadingEdit = false;
    this.route.navigate(["/create/"]);
  }

  deleteRule(index: number) {
    if(confirm("Are you sure you want to delete this rule?")){
      this.userDataService.deleteRule(index).subscribe(
        data => {
          //reload rules after delete
          this.unparsedRules = data["rules"];
          var i: number;
          for (i = 0; i < this.unparsedRules.length; i++) {
            this.ruleids[i] = this.unparsedRules[i].id;
          }
          this.parseRules();
        }
      );
    }
  }
}
