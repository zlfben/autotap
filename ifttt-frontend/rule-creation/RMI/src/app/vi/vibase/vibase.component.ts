import { Component, OnInit, HostListener } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { DomSanitizer } from '@angular/platform-browser';
import { Url } from 'url';

@Component({
  selector: 'app-vibase',
  templateUrl: './vibase.component.html',
  styleUrls: ['./vibase.component.css']
})
export class VibaseComponent implements OnInit {

  constructor(private router: Router, private sanitizer: DomSanitizer, private activatedRoute: ActivatedRoute) { }

  innerWidth: number;
  innerHeight: number;
  iframeHeight: number;

  ngOnInit() {
    this.innerWidth = window.innerWidth;
    this.innerHeight = window.innerHeight;
    this.iframeHeight = window.innerHeight-100 > 100? window.innerHeight-100: 100;
  }

  spLocation() {
    var sp_url = this.router.url + '/sp'
    return this.sanitizer.bypassSecurityTrustResourceUrl(sp_url);
  }

  rLocation() {
    var r_url = this.router.url + '/rules'
    return this.sanitizer.bypassSecurityTrustResourceUrl(r_url);
  }

  getIFrameWidth() {
    return Math.floor(this.innerWidth/2.01);
  }

  gotoVerify() {
    this.router.navigate(["verify"], {relativeTo: this.activatedRoute});
  }

  @HostListener('window:resize', ['$event'])
  onResize(event) {
    this.innerWidth = window.innerWidth;
    this.innerHeight = window.innerHeight;
    this.iframeHeight = window.innerHeight-100 > 100? window.innerHeight-100: 100;
  }

}
