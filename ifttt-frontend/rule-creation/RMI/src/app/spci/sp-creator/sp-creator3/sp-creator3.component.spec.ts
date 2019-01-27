import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { SpCreator3Component } from './sp-creator3.component';

describe('SpCreatorComponent', () => {
  let component: SpCreator3Component;
  let fixture: ComponentFixture<SpCreator3Component>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ SpCreator3Component ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SpCreator3Component);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
