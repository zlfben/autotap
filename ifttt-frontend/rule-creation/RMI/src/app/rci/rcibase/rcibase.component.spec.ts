import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { RcibaseComponent } from './rcibase.component';

describe('RcibaseComponent', () => {
  let component: RcibaseComponent;
  let fixture: ComponentFixture<RcibaseComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ RcibaseComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(RcibaseComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
