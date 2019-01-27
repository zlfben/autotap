import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { SpmibaseComponent } from './spmibase.component';

describe('SpmibaseComponent', () => {
  let component: SpmibaseComponent;
  let fixture: ComponentFixture<SpmibaseComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ SpmibaseComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SpmibaseComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
