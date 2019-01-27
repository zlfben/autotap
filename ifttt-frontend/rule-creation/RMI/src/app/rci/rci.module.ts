import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { RouterModule, Routes } from '@angular/router';
import { MatSelectModule } from '@angular/material/select';
import { MatSliderModule } from '@angular/material/slider';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

import { RcibaseComponent } from './rcibase/rcibase.component';
import { UserDataService } from '../user-data.service';
import { RuleCreatorComponent } from './rule-creator/rule-creator.component';
import { ChannelSelectorComponent } from './channel-selector/channel-selector.component';
import { CapabilitySelectorComponent } from './capability-selector/capability-selector.component';
import { ParameterConfigurationComponent } from './parameter-configuration/parameter-configuration.component';
import { SharedModule } from '../shared.module'
import { DeviceSelectorComponent } from './device-selector/device-selector.component';

const routes: Routes = [
  {
    path: 'create',
    component: RcibaseComponent,
    children: [
      {
        path: 'configureParameters/:channel_id/:device_id/:capability_id',
        component: ParameterConfigurationComponent
      },
      {
        path: 'selectCapability/:channel_id/:device_id',
        component: CapabilitySelectorComponent
      },
      {
        path: 'selectDevice/:channel_id',
        component: DeviceSelectorComponent
      },
      {
        path: 'selectChannel',
        component: ChannelSelectorComponent
      },
      {
        path: '',
        component: RuleCreatorComponent
      }
    ]
  }
]

@NgModule({
  imports: [
    RouterModule.forChild(routes),
    CommonModule, FormsModule, SharedModule,
    MatSelectModule, MatSliderModule, MatButtonModule, MatIconModule,
    BrowserAnimationsModule
  ],
  declarations: [
    RcibaseComponent, RuleCreatorComponent, ChannelSelectorComponent,
    DeviceSelectorComponent, CapabilitySelectorComponent, 
    ParameterConfigurationComponent
  ],
  providers: [UserDataService],
  exports: [RouterModule]
})
export class RciModule { }
