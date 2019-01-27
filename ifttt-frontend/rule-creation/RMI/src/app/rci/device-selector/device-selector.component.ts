import { Component} from '@angular/core';
import { Location } from '@angular/common';
import { ActivatedRoute } from '@angular/router';
import { UserDataService, Device } from '../../user-data.service';

@Component({
  selector: 'app-device-selector',
  templateUrl: './device-selector.component.html',
  styleUrls: ['./device-selector.component.css']
})
export class DeviceSelectorComponent {

  public selectedChannelID: number;
  public selectableDevices: Device[];

  constructor(private userDataService: UserDataService, private router: ActivatedRoute, public _location: Location) {
    this.router.params.subscribe(params => {
      this.selectedChannelID = params["channel_id"];
    });
    this.userDataService.getDevicesForChannel((this.userDataService.currentObjectType == "trigger"), 
                                               this.userDataService.isCurrentObjectEvent, 
                                               this.selectedChannelID)
                        .subscribe(
                          data => { this.selectableDevices = data["devs"]; }
                        );
  }
}
