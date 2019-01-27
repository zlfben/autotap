import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { VipageComponent } from './vipage.component';

describe('VipageComponent', () => {
  let component: VipageComponent;
  let fixture: ComponentFixture<VipageComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ VipageComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(VipageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
