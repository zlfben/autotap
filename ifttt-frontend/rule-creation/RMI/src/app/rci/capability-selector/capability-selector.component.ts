import {Component} from '@angular/core';
import {ActivatedRoute} from '@angular/router';
import {Location} from '@angular/common';
import {UserDataService, Device, Capability, Channel} from '../../user-data.service';

@Component({
  selector: 'app-capability-selector',
  templateUrl: './capability-selector.component.html',
  styleUrls: ['./capability-selector.component.css']
})
export class CapabilitySelectorComponent {

  public selectedDeviceID: number;
  public selectedChannelID: number;
  public selectedDevice: Device;
  public selectableCapabilities: Capability[];

  constructor(public userDataService: UserDataService, private router: ActivatedRoute,
              public _location: Location) 
  {
    this.router.params.subscribe(params => {
      this.selectedDeviceID = Number(params["device_id"]);
      this.selectedChannelID = Number(params["channel_id"]);
    });
    this.selectedDevice = this.userDataService.selectedDevice;
    this.userDataService.getCapabilitiesForDevice(
                          (this.userDataService.currentObjectType == "trigger"), 
                          this.userDataService.isCurrentObjectEvent, 
                          this.selectedDeviceID, 
                          this.selectedChannelID
                        )
                        .subscribe(
                          data => { this.selectableCapabilities = data['caps']; }
                        );
  }
}