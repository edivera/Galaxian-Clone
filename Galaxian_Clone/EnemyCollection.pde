class EnemyCollection {
  
  Enemy[][] enemies;
  int diff;
  int x, y;
  int pdir, dir;  //0: left, 1: down, 2: right
  int killCount;
  //min left is 11
  
  EnemyCollection(int _diff) {
    diff = (_diff > 31) ? 31 : _diff;
    x = 29; y = 50;
    enemies = new Enemy[6][10];
    for(int j = 0; j < 10; j++) {
      enemies[0][j] = new Enemy("queenenemy", x + j * 21, y, j);
      enemies[1][j] = new Enemy("redenemy", x + j * 21, y + 14, j);
      enemies[2][j] = new Enemy("purpleenemy", x + j * 21, y + 28, j);
    }
    for(int i = 3; i < 6; i++) {
      for(int j = 0; j < 10; j++) {
        enemies[i][j] = new Enemy("greenenemy", x + j * 21, y + i * 14, j);
      }
    }
    pdir = dir = 0;
    killCount = 0;
  }
  
  
  int checkCollision(Laser l) {
    //check within bounds
    int xIdx = (l.x - x) / 21;
    int yIdx = (l.y - y) / 14;
    if(xIdx >= 0 && xIdx < 10 && yIdx >= 0 && yIdx < 6 && l.state == 1) {
      if((l.x - x) % 21 > 10) {
        return 0;
      }
      if(enemies[yIdx][xIdx] != null) {
        enemies[yIdx][xIdx] = null;
        l.state = 2;
        killCount++;
        if(yIdx == 0) { return 150; }
        if(yIdx == 1) { return 60; }
        if(yIdx == 2) { return 40; }
        else return 30;
      }
    }
    return 0;
  }
  boolean checkLose() {
    return findLowestY() >= 210;
  }
  boolean checkWin() {
    return killCount == 60;
  }
  void reposition() {
    x = 29; y = 50;
    for(int i = 0; i < 6; i++) {
      for(int j = 0; j < 10; j++) {
        if(enemies[i][j] != null) {
          enemies[i][j].x = x + j * 21;
          enemies[i][j].y = y + i * 14;
        }
      }
    }
  }
  void step() {
    if(frameCount % (60 / diff) != 0) {
      return;
    }
    
    //step group
    switch(dir) {
      case 0: x -= 1; break;
      case 1: y += 6; break;
      case 2: x += 1; break;
      default: break;
    }
    
    //change directions if changed
    if(dir != pdir) {
      for(int i = 0; i < 6; i++) {
        for(int j = 0; j < 10; j++) {
          if(enemies[i][j] != null) {
            enemies[i][j].direction = dir;
          }
        }
      }
      pdir = dir;
    }
    //step enemies that aren't null
    for(int i = 0; i < 6; i++) {
      for(int j = 0; j < 10; j++) {
        if(enemies[i][j] != null) {
          enemies[i][j].step();
        }
      }
    }
    
    //check for change in direcion
    if(x == 11 && dir == 0) { dir = 1; }
    else if(x == 11 && dir == 1) { dir = 2; }
    else if(x == 45 && dir == 2) { dir = 1; }
    else if(x == 45 && dir == 1) { dir = 0; }
  }
  void display() {
    for(int i = 0; i < 6; i++) {
      for(int j = 0; j < 10; j++) {
        if(enemies[i][j] != null) {
          enemies[i][j].display();
        }
      }
    }
  }
  
  //helper function to checkLose
  private int findLowestY() {
    for(int i = 5; i >= 0; i--) {
      for(int j = 0; j < 10; j++) {
        if(enemies[i][j] != null) {
          return enemies[i][j].y;
        }
      }
    }
    return 0;
  }
}
