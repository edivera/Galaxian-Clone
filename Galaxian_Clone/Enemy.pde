class Enemy extends AnimatedObject {
  
  int direction;  //0: left, 1: down, 2: right
  boolean queen;  //to distinguish between enemies
  
  
  Enemy(String sprite, int _x, int _y, int col) {
    x = _x;
    y = _y;
    currentFrame = col % 3;  //wave motion across columns
    if(sprite.equals("queenenemy")) {
      frames = new PImage[1];
      frames[0] = loadImage("queenenemy0.png");
      currentFrame = 0;
      queen = true;
    }
    else {
      frames = new PImage[3];
      for(int i = 0; i < 3; i++) {
        frames[i] = loadImage(sprite + i + ".png");
      }
    }
    w = frames[0].width;
    h = frames[0].height;
    direction = 0;
  }
  
  
  @Override
  void step() {
    switch(direction) {
      case 0: x -= 1; break;
      case 1: y += 6; break;
      case 2: x += 1; break;
      default: break;
    }
    if(!queen) {
      currentFrame = (currentFrame + 1) % 3;
    }
  }
  
}
