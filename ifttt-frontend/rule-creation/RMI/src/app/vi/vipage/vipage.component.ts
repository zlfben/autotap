import { Component, OnInit } from '@angular/core';
import { UserDataService, Rule } from '../../user-data.service';
import { Router, ActivatedRoute } from '@angular/router';
import { RuleUIRepresentation } from '../../rmi/rmibase/rmibase.component'

export interface PatchedRuleUIRepresentation {
  words: string[]; // e.g. IF, AND, THEN
  icons: string[]; // the string name of the icons
  descriptions: string[]; // the descriptions for each of the icons
  actions: string[]; // descriptions of all possible patches
}

@Component({
  selector: 'app-vipage',
  templateUrl: './vipage.component.html',
  styleUrls: ['./vipage.component.css']
})
export class VipageComponent implements OnInit {

  private unparsedOrigRules: Rule[];
  private unparsedPatches: Rule[][];
  public ORIGRULES: RuleUIRepresentation[];
  public PATCHES: RuleUIRepresentation[][];
  public CURRENTPATCH: RuleUIRepresentation[];
  public currentIndex: number;
  public patchNum: number;

  constructor(public userDataService: UserDataService, private route: Router, private router: ActivatedRoute) {
  }

  ngOnInit() {
    this.userDataService.getCsrfCookie().subscribe(dataCookie => {
      this.router.params.subscribe(params => {
        // then get hashed_id and task_id from router params
        if (!this.userDataService.user_id) {
          this.userDataService.mode = "rules";
          this.userDataService.hashed_id = params["hashed_id"];
          this.userDataService.task_id = params["task_id"];
        }
        // get fix patches
        this.userDataService.verifyTask(this.userDataService.hashed_id)
                        .subscribe(
                          data => {
                            this.unparsedOrigRules = data['original'];
                            this.unparsedPatches = data['patches'];

                            if (this.unparsedOrigRules) {
                              this.parseRules()
                            }
                          }
                        );
    })});
  }

  //parse rules into displayable form for list
  private parseRules() {
    const origRules = this.unparsedOrigRules;
    const patches = this.unparsedPatches;

    this.ORIGRULES = origRules.map((rule => {
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

      const ruleRep: RuleUIRepresentation = {
        words: words,
        icons: icons,
        descriptions: descriptions
      };
      return ruleRep;
    }));

    this.PATCHES = patches.map(patch => {
      const patchRep = patch.map(rule => {
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

        const ruleRep: RuleUIRepresentation = {
          words: words,
          icons: icons,
          descriptions: descriptions
        };
        return ruleRep;
      });
      return patchRep;
    });

    this.patchNum = this.PATCHES.length;
    this.currentIndex = 0;
    this.CURRENTPATCH = this.PATCHES[this.currentIndex];
  }

  gotoPrev() {
    this.currentIndex = this.currentIndex==0 ? this.currentIndex : this.currentIndex-1;
    this.CURRENTPATCH = this.PATCHES[this.currentIndex];
  }

  gotoNext() {
    this.currentIndex = this.currentIndex+1<this.patchNum ? this.currentIndex+1 : this.currentIndex;
    this.CURRENTPATCH = this.PATCHES[this.currentIndex];
  }
}
