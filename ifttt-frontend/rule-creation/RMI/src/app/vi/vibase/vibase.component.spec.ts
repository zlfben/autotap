import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { VibaseComponent } from './vibase.component';

describe('VibaseComponent', () => {
  let component: VibaseComponent;
  let fixture: ComponentFixture<VibaseComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ VibaseComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(VibaseComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
