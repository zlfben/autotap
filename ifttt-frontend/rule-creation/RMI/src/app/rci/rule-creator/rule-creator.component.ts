import {Component, OnInit, Pipe, PipeTransform } from '@angular/core';
import {Router} from '@angular/router';
import {Location} from '@angular/common';
import {DomSanitizer} from '@angular/platform-browser';

import {UserDataService} from '../../user-data.service';

@Component({
  selector: 'app-rule-creator',
  templateUrl: './rule-creator.component.html',
  styleUrls: ['./rule-creator.component.css']
})
export class RuleCreatorComponent implements OnInit {

  constructor(public userDataService: UserDataService, private sanitizer: DomSanitizer, 
              private router: Router, public _location: Location) {
    // on creation, stage a rule to be created
    if (userDataService.editingRuleID && userDataService.stopLoadingEdit == false) {
      this.getEditRule();
    }
    this.userDataService.stopLoadingEdit = true;
    userDataService.stageRule();
  }

  ngOnInit() {
  }

  goToRulesHome() {
    this.router.navigate([this.userDataService.hashed_id + "/" + this.userDataService.task_id + "/rules"]);
  }

  //to edit a rule, need to get all of its intricacies
  getEditRule() {
    this.userDataService.getFullRule(this.userDataService.editingRuleID);
  }

  public finishRule() {
    if (this.userDataService.stagedRuleIsValid()) {
      this.userDataService.finishRule();
    }
    else {
      alert("Please create a valid rule (needs at least one IF clause and one THEN clause).")
    }
  }

}
