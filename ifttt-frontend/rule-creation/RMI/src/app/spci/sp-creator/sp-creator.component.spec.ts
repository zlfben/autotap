import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { SpCreatorComponent } from './sp-creator.component';

describe('SpCreatorComponent', () => {
  let component: SpCreatorComponent;
  let fixture: ComponentFixture<SpCreatorComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ SpCreatorComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SpCreatorComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
