import {Component, OnInit, Pipe, PipeTransform } from '@angular/core';
import {Router} from '@angular/router';
import {Location} from '@angular/common';
import {DomSanitizer} from '@angular/platform-browser';

import {UserDataService} from '../../../user-data.service';

@Component({
  selector: 'app-sp-creator1',
  templateUrl: './sp-creator1.component.html',
  styleUrls: ['./sp-creator1.component.css']
})
export class SpCreator1Component implements OnInit {

  constructor(public userDataService: UserDataService, private sanitizer: DomSanitizer, 
              private router: Router, public _location: Location) {
    // on creation, stage a rule to be created
    if (userDataService.editingSpID && userDataService.stopLoadingEdit == false) {
      this.getEditSp1();
    }
    this.userDataService.stopLoadingEdit = true;
    userDataService.stageSp1();
    userDataService.currentSpType = 1;
  }

  ngOnInit() {
  }

  goToCreateSp() {
    this.userDataService.currentlyStagedSp1 = null;
    this.router.navigate(["/createSp/"]);
  }

  getEditSp1() {
    this.userDataService.getFullSp(this.userDataService.editingSpID, 1);
  }

  public changeCompatibility(compatibility: string) {
    this.userDataService.compatibilityPhrase = compatibility;
  }

  public finishSp() {
    if (this.userDataService.compatibilityPhrase == 'always') {this.userDataService.currentlyStagedSp1.compatibility = true;}
    if (this.userDataService.compatibilityPhrase == 'never') {this.userDataService.currentlyStagedSp1.compatibility = false;}
    if (this.userDataService.stagedSpIsValid(1)) {
      this.userDataService.finishSp(1);
    }
    else {
      alert("Please create a valid safety property (needs at least two clauses).")
    }
  }

}
