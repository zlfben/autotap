import {Component, OnInit, Pipe, PipeTransform } from '@angular/core';
import {Router} from '@angular/router';
import {Location} from '@angular/common';
import {DomSanitizer} from '@angular/platform-browser';

import {UserDataService} from '../../../user-data.service';

@Component({
  selector: 'app-sp2-choice',
  templateUrl: './sp2-choice.component.html',
  styleUrls: ['./sp2-choice.component.css']
})
export class Sp2ChoiceComponent implements OnInit {

  constructor(public userDataService: UserDataService, private sanitizer: DomSanitizer, 
              private router: Router, public _location: Location) {
    // on creation, stage a rule to be created
    this.userDataService.compatibilityPhrase = '';
    this.userDataService.editing = false;
    this.userDataService.editingSpID = 0;
    this.userDataService.hideSp2Time = false;
    this.userDataService.hideSp2Also = false;
  }

  ngOnInit() {
    delete this.userDataService.currentlyStagedSp1;
    delete this.userDataService.currentlyStagedSp2;
    delete this.userDataService.currentlyStagedSp3;
  }

  goToCreateSp2(hideSp2Time: boolean, hideSp2Also: boolean) {
    this.userDataService.hideSp2Time = hideSp2Time;
    this.userDataService.hideSp2Also = hideSp2Also;
    this.userDataService.gotoCreateSp(2);
  }

  goToSpci() {
    this.router.navigate(["/createSp"]);
  }

}
