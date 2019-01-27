import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';

import { UserDataService, Sp1, Sp2, Sp3 } from '../../user-data.service';

export interface SpUIRepresentation {
  words: string[]; // e.g. IF, AND, THEN
  icons: string[]; // the string name of the icons
  descriptions: string[]; // the descriptions for each of the icons
}

@Component({
  selector: 'spmi-spmibase',
  templateUrl: './spmibase.component.html',
  styleUrls: ['./spmibase.component.css']
})
export class SpmibaseComponent implements OnInit {

  public SPS: SpUIRepresentation[];
  public spids: number[];
  private unparsedSps: any[];

  constructor(public userDataService: UserDataService, private route: Router, private router: ActivatedRoute) {
    //get the csrf cookie
    this.userDataService.getCsrfCookie().subscribe(data => {
      this.router.params.subscribe(params => {
        // then get hashed_id and task_id from router params
        if (!this.userDataService.user_id) {
          this.userDataService.mode = "sp";
          this.userDataService.hashed_id = params["hashed_id"];
          this.userDataService.task_id = params["task_id"];
        }
      });
      this.spids = [];
      this.userDataService.currentlyStagedSp1 = null;
      this.userDataService.currentlyStagedSp2 = null;
      this.userDataService.currentlyStagedSp3 = null;
      // get userid and user's sps
      this.userDataService.getSps(this.userDataService.hashed_id)
                          .subscribe(
                            data => {
                              this.unparsedSps = data["sps"];
                              if (data["userid"]) {this.userDataService.user_id = data["userid"];}
                              var i: number;
                              if (this.unparsedSps) {
                                for (i = 0; i < this.unparsedSps.length; i++) {
                                  this.spids[i] = this.unparsedSps[i].id;
                                }
                                this.parseSps();
                              }
                            }
                          )});
  }

  //parse rules into displayable form for list
  private parseSps() {
    const sps = this.unparsedSps;
    this.SPS = sps.map((sp => {
      const words = [];
      const descriptions = [];
      const icons = [];

      // if Sp1
      if (sp.thisState) {
        descriptions.push(sp.thisState[0].text);
        icons.push(sp.thisState[0].channel.icon);
        for (let i = 0; i < sp.thatState.length; i++) {
          words.push("and");
          icons.push(sp.thatState[i].channel.icon);
          descriptions.push(sp.thatState[i].text);
        }
        words.push("should");
        descriptions.push(sp.compatibility ? "always" : "never");
        icons.push(sp.compatibility ? "done" : "not_interested");
        words.push("occur together");
      }
      // if Sp2
      else if (sp.stateClause) {
        descriptions.push(sp.stateClause[0].text);
        icons.push(sp.stateClause[0].channel.icon);
        words.push("should");
        descriptions.push(sp.compatibility ? "always" : "never");
        icons.push(sp.compatibility ? "done" : "not_interested");
        if (sp.time) {
          words.push("happen for"); 
          icons.push("access_time"); 
          var description = "more than ";
          if (sp.time.hours > 0) {description += (sp.time.hours + "h ");}
          if (sp.time.minutes > 0) {description += (sp.time.minutes + "m ");}
          if (sp.time.seconds > 0) {description += (sp.time.seconds + "s ");}
          descriptions.push(description);
        } else {words.push("happen");}
        for (let i = 0; i < sp.alsoClauses.length; i++) {
          if (i == 0) {
            if (words[words.length-1] == "happen") {words[words.length-1] += " while";}
            else {words.push("while")}
          }
          else {words.push("and");}
          icons.push(sp.alsoClauses[i].channel.icon);
          descriptions.push(sp.alsoClauses[i].text);
        }
      }
      // if Sp3
      else if (sp.triggerClause) {
        descriptions.push(sp.triggerClause[0].text);
        icons.push(sp.triggerClause[0].channel.icon);
        words.push("should");
        descriptions.push(sp.compatibility ? "always" : "never");
        icons.push(sp.compatibility ? "done" : "not_interested");
        words.push("happen");
        if (!sp.afterTime) {
          for (let i = 0; i < sp.otherClauses.length; i++) {
            if (i == 0) {words[words.length-1] += " while";}
            else {words.push("and");}
            icons.push(sp.otherClauses[i].channel.icon);
            descriptions.push(sp.otherClauses[i].text);
          }
        } else {
          var description = "within ";
          icons.push("access_time"); 
          if (sp.afterTime.hours > 0) {description += (sp.afterTime.hours + "h ");}
          if (sp.afterTime.minutes > 0) {description += (sp.afterTime.minutes + "m ");}
          if (sp.afterTime.seconds > 0) {description += (sp.afterTime.seconds + "s ");}
          descriptions.push(description);
          words.push("after");
          icons.push(sp.otherClauses[0].channel.icon);
          descriptions.push(sp.otherClauses[0].text);

        }
        words.push("");
      }

      const spRep: SpUIRepresentation = {
        words: words,
        icons: icons,
        descriptions: descriptions
      };
      return spRep;
    }));
  }
  
  ngOnInit() {
    this.userDataService.getCsrfCookie().subscribe();
  }

  gotoCreateSp() {
    this.userDataService.compatibilityPhrase = '';
    this.route.navigate(["/createSp"]);
  }

  editSp(index: number) {
    //prepare values in userdataservice for editing
    if (this.unparsedSps[index].thisState) {
      this.userDataService.editingSpID = this.spids[index];
      this.userDataService.editing = true;
      this.userDataService.stopLoadingEdit = false;
      this.route.navigate(["/createSp/sp1"]);
    } else if (this.unparsedSps[index].stateClause) {
      this.userDataService.editingSpID = this.spids[index];
      this.userDataService.editing = true;
      this.userDataService.stopLoadingEdit = false;
      this.route.navigate(["/createSp/sp2"]);
    } else {
      this.userDataService.editingSpID = this.spids[index];
      this.userDataService.editing = true;
      this.userDataService.stopLoadingEdit = false;
      this.route.navigate(["/createSp/sp3"]);
    }
  }

  deleteSp(spid) {
    if(confirm("Are you sure you want to delete this sp?")){
      this.userDataService.deleteSp(spid).subscribe(
        data => {
          this.unparsedSps = data["sps"];
          var i: number;
          for (i = 0; i < this.unparsedSps.length; i++) {
            this.spids[i] = this.unparsedSps[i].id;
          }
          this.parseSps();
        }
      );
    }
  }
}
