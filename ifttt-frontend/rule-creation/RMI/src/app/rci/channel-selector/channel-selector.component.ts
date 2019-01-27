import { Component} from '@angular/core';
import {Location} from '@angular/common';
import { ActivatedRoute } from '@angular/router';
import { UserDataService, Channel } from '../../user-data.service';

@Component({
  selector: 'app-channel-selector',
  templateUrl: './channel-selector.component.html',
  styleUrls: ['./channel-selector.component.css']
})
export class ChannelSelectorComponent {

  public selectableChannels: Channel[];

  constructor(private userDataService: UserDataService, public _location: Location) {
    this.userDataService.getChannels(
          (this.userDataService.currentObjectType == "trigger"), 
          this.userDataService.isCurrentObjectEvent)
        .subscribe(data => {
                    this.selectableChannels = data["chans"];
                  });
  }
}
