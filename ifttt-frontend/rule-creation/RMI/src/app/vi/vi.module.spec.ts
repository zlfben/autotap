import { ViModule } from './vi.module';

describe('ViModule', () => {
  let viModule: ViModule;

  beforeEach(() => {
    viModule = new ViModule();
  });

  it('should create an instance', () => {
    expect(viModule).toBeTruthy();
  });
});
