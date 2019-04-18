class Laser extends AnimatedObject {
  
  int state;
  

  Laser(int _x, int _y) {
    x = _x;
    y = _y;
    frames = new PImage[1];
    frames[0] = loadImage("laser.png");
    currentFrame = 0;
    w = frames[0].width;
    h = frames[0].height;
    state = 0;
  }
  
  
  @Override
  void step() {
    if(state == 1) {
      y -= 4;
      if(y < 0) {
        state = 2;
      }
    }
  }
  void reset(int _x, int _y) {
    x = _x;
    y = _y;
    state = 0;
  }
  
}
