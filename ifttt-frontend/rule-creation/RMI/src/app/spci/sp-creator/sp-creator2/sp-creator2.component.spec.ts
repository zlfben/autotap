import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { SpCreator2Component } from './sp-creator2.component';

describe('SpCreator2Component', () => {
  let component: SpCreator2Component;
  let fixture: ComponentFixture<SpCreator2Component>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ SpCreator2Component ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SpCreator2Component);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
