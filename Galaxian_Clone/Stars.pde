class Stars extends AnimatedObject{
  
  color col;
  boolean toggle;
  int timeOffset;
  
  
  Stars() {
    frames = new PImage[1];
    frames[0] = loadImage("star.png");
    col = color(random(255), random(255), random(255));
    frames[0].pixels[0] = col;
    currentFrame = 0;
    timeOffset = (int)random(19);
    x = y = 0;
    w = h = 1;
  }
  
  
  @Override
  void step() {
    if(frameCount % 20 == timeOffset) {
      frames[0].pixels[0] = (toggle) ? col : black;
      toggle = !toggle;
    }
    if(frameCount % 2 == 0) {
      y = (y + 1) % 240;
    }
  }
  void spread(Stars[] stars) {
    int s = 0;
    for(int i = 0; i < 6; i++) {
      for(int j = 0; j < 6; j++) {
        stars[s].x = (int)random(42) + j * 42;
        stars[s].y = (int)random(40) + i * 40;
        s++;
      }
    }
  }
  
}
