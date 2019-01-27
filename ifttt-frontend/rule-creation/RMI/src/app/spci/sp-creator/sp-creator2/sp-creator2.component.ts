import {Component, OnInit, Pipe, PipeTransform } from '@angular/core';
import {Router} from '@angular/router';
import {Location} from '@angular/common';
import {DomSanitizer} from '@angular/platform-browser';

import { UserDataService, Time } from '../../../user-data.service';

@Component({
  selector: 'app-sp-creator2',
  templateUrl: './sp-creator2.component.html',
  styleUrls: ['./sp-creator2.component.css']
})
export class SpCreator2Component implements OnInit {

  public comparators: String[];

  constructor(public userDataService: UserDataService, private sanitizer: DomSanitizer, 
              private router: Router, public _location: Location) {
    // on creation, stage a rule to be created
    if (userDataService.editingSpID && userDataService.stopLoadingEdit == false) {
      this.getEditSp2();
    }
    this.userDataService.stopLoadingEdit = true;
    userDataService.stageSp2();
    userDataService.currentSpType = 2;
    if (!userDataService.currentlyStagedSp2.comparator) {
      userDataService.currentlyStagedSp2.comparator = '>';
    }
  }

  ngOnInit() {
  }

  goToSp2Choice() {
    this.userDataService.currentlyStagedSp2 = null;
    this.router.navigate(["/createSp/sp2choice/"]);
  }

  getEditSp2() {
    this.userDataService.getFullSp(this.userDataService.editingSpID, 2);
  }

  public setTime() {
    this.userDataService.currentlyStagedSp2.time = {"hours":0, "minutes":0, "seconds":0}
  }

  public changeCompatibility(compatibility: string) {
    this.userDataService.compatibilityPhrase = compatibility;
  }

  public finishSp() {
    if (this.userDataService.currentlyStagedSp2.time == null) {this.userDataService.currentlyStagedSp2.time = {"hours":0,"minutes":0,"seconds":0};}
    if (this.userDataService.compatibilityPhrase == 'always') {this.userDataService.currentlyStagedSp2.compatibility = true;}
    if (this.userDataService.compatibilityPhrase == 'never') {this.userDataService.currentlyStagedSp2.compatibility = false;}
    if (this.userDataService.stagedSpIsValid(2)) {
      this.userDataService.finishSp(2);
    }
    else {
      alert("Make sure all non-optional clauses have been chosen.")
    }
  }

}
