import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { Sp2ChoiceComponent } from './sp2-choice.component';

describe('Sp2ChoiceComponent', () => {
  let component: Sp2ChoiceComponent;
  let fixture: ComponentFixture<Sp2ChoiceComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ Sp2ChoiceComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(Sp2ChoiceComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
