import {Component, OnInit, Pipe, PipeTransform } from '@angular/core';
import {Router} from '@angular/router';
import {Location} from '@angular/common';
import {DomSanitizer} from '@angular/platform-browser';

import { UserDataService, Time } from '../../../user-data.service';

@Component({
  selector: 'app-sp-creator3',
  templateUrl: './sp-creator3.component.html',
  styleUrls: ['./sp-creator3.component.css']
})
export class SpCreator3Component implements OnInit {

  public compatibilityPhrase: String;
  public comparator: String | null = null;
  public comparatorNumber: number;
  public comparators: String[];

  constructor(public userDataService: UserDataService, private sanitizer: DomSanitizer, 
              private router: Router, public _location: Location) {
    // on creation, stage a rule to be created
    if (userDataService.editingSpID && userDataService.stopLoadingEdit == false) {
      this.getEditSp3();
    }
    this.userDataService.stopLoadingEdit = true;
    userDataService.stageSp3();
    userDataService.currentSpType = 3;
    if (userDataService.currentlyStagedSp3.afterTime) {userDataService.hasAfterTime = true; this.userDataService.whileOrAfter = false}
    else {userDataService.hasAfterTime = false; this.userDataService.whileOrAfter = true;}
  }

  ngOnInit() {
  }

  gotoSpClauseCreate(objectType: string, spClauseType: string, index: number) {
    this.userDataService.whileOrAfter = true;
    this.userDataService.gotoSpChannelSelector(objectType, spClauseType, index);
  }

  goToCreateSp() {
    this.userDataService.currentlyStagedSp3 = null;
    this.router.navigate(["/createSp/"]);
  }

  getEditSp3() {
    this.userDataService.getFullSp(this.userDataService.editingSpID, 3);
  }

  public addTimeAfter() {
    this.userDataService.hasAfterTime = true;
    this.userDataService.whileOrAfter = false;
    this.userDataService.currentlyStagedSp3.afterTime = {"hours":0, "minutes":0, "seconds":0}
  }

  public removeTimeAfter() {
    this.userDataService.hasAfterTime = false;
    this.userDataService.currentlyStagedSp3.afterTime = null;
  }

  public changeCompatibility(compatibility: string) {
    this.userDataService.compatibilityPhrase = compatibility;
  }

  public finishSp() {
    if (this.userDataService.compatibilityPhrase == 'always') {this.userDataService.currentlyStagedSp3.compatibility = true;}
    if (this.userDataService.compatibilityPhrase == 'never') {this.userDataService.currentlyStagedSp3.compatibility = false;}
    if (this.userDataService.stagedSpIsValid(3)) {
      this.userDataService.finishSp(3);
    }
    else {
      alert("Make sure all non-optional clauses have been chosen")
    }
  }

}
