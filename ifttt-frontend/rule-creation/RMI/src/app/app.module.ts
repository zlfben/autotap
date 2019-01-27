import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { RouterModule, Routes} from '@angular/router';
import { MatInputModule } from '@angular/material';
import { MatSliderModule } from '@angular/material/slider';

import { RmiModule } from './rmi/rmi.module';
import { RciModule } from './rci/rci.module';
import { SpmiModule } from './spmi/spmi.module';
import { SpciModule } from './spci/spci.module';
import { ViModule } from './vi/vi.module'
import { SharedModule } from './shared.module';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

import { AppComponent } from './app.component';

import { HttpClientModule, HttpClientXsrfModule, HTTP_INTERCEPTORS } from '@angular/common/http';

import { XsrfInterceptor } from './xsrf.interceptor';

const routes: Routes = [
  {
    path: '',
    component: AppComponent,
  },
]

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule, RmiModule, RciModule, SpmiModule, SpciModule, ViModule, 
    SharedModule, BrowserAnimationsModule,
    RouterModule.forRoot(routes, {enableTracing: false}),
    MatInputModule, MatSliderModule,
    HttpClientModule,
    HttpClientXsrfModule.withOptions({
      cookieName: 'csrftoken',
      headerName: 'X-CSRFToken'
    }),
  ],
  providers: [
    { provide: HTTP_INTERCEPTORS, useClass: XsrfInterceptor, multi: true }
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
