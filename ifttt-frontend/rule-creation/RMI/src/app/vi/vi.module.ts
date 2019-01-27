import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Routes } from '@angular/router';
import { VibaseComponent } from './vibase/vibase.component';
import { MatListModule } from '@angular/material/list';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatSliderModule } from '@angular/material/slider';
import { MatSelectModule } from '@angular/material/select';
import { VipageComponent } from './vipage/vipage.component';

const routes: Routes = [
  {
    path: ':hashed_id/:task_id',
    component: VibaseComponent
  },
  {
    path: ':hashed_id/:task_id/verify',
    component: VipageComponent
  }
]

@NgModule({
  imports: [
    RouterModule.forChild(routes),
    CommonModule,
    MatSliderModule, MatListModule, MatButtonModule, MatIconModule, MatSelectModule
  ],
  declarations: [VibaseComponent, VipageComponent],
  exports: [
    RouterModule
  ]
})
export class ViModule { }
