import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { RmibaseComponent } from './rmibase.component';

describe('RmibaseComponent', () => {
  let component: RmibaseComponent;
  let fixture: ComponentFixture<RmibaseComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ RmibaseComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(RmibaseComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
