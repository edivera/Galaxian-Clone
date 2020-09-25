class SpaceShip extends AnimatedObject {
  
  Controller player;
  Laser laser;
  GUI context;
  
  
  SpaceShip(GUI _context, int _x, int _y, Controller _player, Laser _laser) {
    context = _context;
    x = _x;
    y = _y;
    player = _player;
    laser = _laser;
    frames = new PImage[6];
    for(int i = 0; i < 6; i++) {
      String fileName = "spaceship" + i + ".png";
      frames[i] = loadImage(fileName);
    }
    currentFrame = 0;
    w = frames[0].width;
    h = frames[0].height;
  }
  
  
  @Override
  void step() {
    if(laser.state == 0) {
      if(player.left && !player.right && x > 0) { laser.x--; }
      if(player.right && !player.left && x < 224) { laser.x++; }
    }
    if(player.left && !player.right && x > 0) { x--; }
    if(player.right && !player.left && x < 224) { x++; }
    if((player.a || player.b) && laser.state == 0) {
      laser.state = 1;
      currentFrame = 1;
    }
    if(laser.state == 2) {
      laser.reset(x + 16, y + 3);
      currentFrame = 0;
    }
  }
  
  void display() {
    float pixelW = 1.0 * width / 256;
    float pixelH = 1.0 * height / 240;
    super.display();
    context.setColor(player.controllerNumber == 1 ? blue : red);
    context.printSpriteText(player.name, (x + w / 2 + 2) * pixelW , (y + h - 4) * pixelH);
  }
  
}
