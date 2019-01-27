import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { CommonModule } from '@angular/common';
import { MatListModule } from '@angular/material/list';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatSliderModule } from '@angular/material/slider';

import { SpmibaseComponent } from './spmibase/spmibase.component';

const routes: Routes = [
  {
    path: ':hashed_id/:task_id/sp',
    component: SpmibaseComponent
  }
]

@NgModule({
  imports: [
    RouterModule.forChild(routes),
    CommonModule,
    MatSliderModule, MatListModule, MatButtonModule, MatIconModule
  ],
  declarations: [
    SpmibaseComponent
  ],
  exports: [
    RouterModule
  ]
})
export class SpmiModule { }
