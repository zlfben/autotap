import { Component, OnInit } from '@angular/core';
import {UserDataService} from '../../user-data.service';

@Component({
  selector: 'app-rcibase',
  templateUrl: './rcibase.component.html',
  styleUrls: ['./rcibase.component.css']
})
export class RcibaseComponent implements OnInit {

  constructor(public userDataService: UserDataService) { }

  ngOnInit() {
  }

}
