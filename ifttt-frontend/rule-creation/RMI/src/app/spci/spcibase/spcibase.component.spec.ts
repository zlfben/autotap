import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { SpcibaseComponent } from './spcibase.component';

describe('SpcibaseComponent', () => {
  let component: SpcibaseComponent;
  let fixture: ComponentFixture<SpcibaseComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ SpcibaseComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SpcibaseComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
