import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { CapabilitySelectorComponent } from './capability-selector.component';

describe('CapabilitySelectorComponent', () => {
  let component: CapabilitySelectorComponent;
  let fixture: ComponentFixture<CapabilitySelectorComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ CapabilitySelectorComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CapabilitySelectorComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
