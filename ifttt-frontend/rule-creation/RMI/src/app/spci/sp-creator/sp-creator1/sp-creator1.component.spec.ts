import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { SpCreator1Component } from './sp-creator1.component';

describe('SpCreator1Component', () => {
  let component: SpCreator1Component;
  let fixture: ComponentFixture<SpCreator1Component>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ SpCreator1Component ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SpCreator1Component);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
