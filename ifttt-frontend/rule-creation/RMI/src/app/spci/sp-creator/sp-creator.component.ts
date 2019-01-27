import {Component, OnInit, Pipe, PipeTransform } from '@angular/core';
import {Router} from '@angular/router';
import {Location} from '@angular/common';
import {DomSanitizer} from '@angular/platform-browser';

import {UserDataService} from '../../user-data.service';

@Component({
  selector: 'app-sp-creator',
  templateUrl: './sp-creator.component.html',
  styleUrls: ['./sp-creator.component.css']
})
export class SpCreatorComponent implements OnInit {

  constructor(public userDataService: UserDataService, private sanitizer: DomSanitizer, 
              private router: Router, public _location: Location) {
    // on creation, stage a rule to be created
    this.userDataService.compatibilityPhrase = '';
    this.userDataService.editing = false;
    this.userDataService.editingSpID = 0;
  }

  ngOnInit() {
    delete this.userDataService.currentlyStagedSp1;
    delete this.userDataService.currentlyStagedSp2;
    delete this.userDataService.currentlyStagedSp3;
  }

  goToSp2Choice() {
    this.userDataService.currentlyStagedSp2 = null;
    this.router.navigate(["/createSp/sp2choice/"]);
  }

  goToSpmi() {
    this.router.navigate([this.userDataService.hashed_id + "/" + this.userDataService.task_id + "/sp"]);
  }

}
