import { NgModule }            from '@angular/core';
import { CommonModule }        from '@angular/common';
import { SafeHtmlPipe }         from './safe-html.pipe';

@NgModule({
  imports:      [ CommonModule ],
  declarations: [ SafeHtmlPipe ],
  exports:      [ SafeHtmlPipe ]
})
export class SharedModule { }