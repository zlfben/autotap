import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { DeviceSelectorComponent } from './device-selector.component';

describe('DeviceSelectorComponent', () => {
  let component: DeviceSelectorComponent;
  let fixture: ComponentFixture<DeviceSelectorComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ DeviceSelectorComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DeviceSelectorComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
