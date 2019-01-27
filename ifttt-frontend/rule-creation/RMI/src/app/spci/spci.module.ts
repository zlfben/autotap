import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { RouterModule, Routes } from '@angular/router';
import { MatSelectModule } from '@angular/material/select';
import { MatSliderModule } from '@angular/material/slider';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

import { SpcibaseComponent } from './spcibase/spcibase.component';
import { UserDataService } from '../user-data.service';
import { SpCreatorComponent } from './sp-creator/sp-creator.component';
import { SpCreator1Component } from './sp-creator/sp-creator1/sp-creator1.component';
import { SpCreator2Component } from './sp-creator/sp-creator2/sp-creator2.component';
import { Sp2ChoiceComponent } from './sp-creator/sp2-choice/sp2-choice.component';
import { SpCreator3Component } from './sp-creator/sp-creator3/sp-creator3.component';
import { ChannelSelectorComponent } from './channel-selector/channel-selector.component';
import { CapabilitySelectorComponent } from './capability-selector/capability-selector.component';
import { ParameterConfigurationComponent } from './parameter-configuration/parameter-configuration.component';
import { SharedModule } from '../shared.module'
import { DeviceSelectorComponent } from './device-selector/device-selector.component';

const routes: Routes = [
  {
    path: 'createSp',
    component: SpcibaseComponent,
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
        path: 'sp1',
        component: SpCreator1Component
      },
      {
        path: 'sp2',
        component: SpCreator2Component
      },
      {
        path: 'sp2choice',
        component: Sp2ChoiceComponent
      },
      {
        path: 'sp3',
        component: SpCreator3Component
      },
      {
        path: '',
        component: SpCreatorComponent
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
    SpcibaseComponent, SpCreatorComponent, Sp2ChoiceComponent,
    SpCreator1Component, SpCreator2Component, SpCreator3Component, 
    ChannelSelectorComponent,
    DeviceSelectorComponent, CapabilitySelectorComponent, 
    ParameterConfigurationComponent
  ],
  providers: [UserDataService],
  exports: [RouterModule]
})
export class SpciModule { }
