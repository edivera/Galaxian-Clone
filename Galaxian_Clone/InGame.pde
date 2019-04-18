class InGame extends GUI {
  
  //game
  EnemyCollection enemies;
  SpaceShip ss1; Laser l1;      
  SpaceShip ss2; Laser l2;
  int lives; Laser livesSprite;  //lives number and life sprite
  int stage; Laser stageSprite;  //stage number and flag sprite
  int stageState, stageCounter;  //state of the state (0 for beginning, 1 for middle, 2 for end). stageCounter for beginning and end
  boolean gameOver, stageClear;  //game over and stage clear flags
  boolean paused1, paused2;
  boolean pushed1, pushed2;
  
  
  InGame() {
    //stage sprites
    livesSprite = new Laser(0, 23);
    stageSprite = new Laser(0, 18);
    livesSprite.frames = new PImage[1];
    stageSprite.frames = new PImage[1];
    livesSprite.frames[0] = loadImage("lives.png");
    stageSprite.frames[0] = loadImage("stage.png");
    livesSprite.w = livesSprite.frames[0].width;
    stageSprite.w = stageSprite.frames[0].width;
    livesSprite.h = livesSprite.frames[0].height;
    stageSprite.h = stageSprite.frames[0].height;
    livesSprite.currentFrame = 0;
    stageSprite.currentFrame = 0;
  }
  
  
  void newGame(int players, int diff) {
    //player setup
    player1HS = 0;
    player2HS = 0;
    player1.setDefaultKeyMapping();
    l1 = new Laser(128, 211);
    ss1 = new SpaceShip(112, 208, player1, l1);
    if(players == 2) {
      player1.setKeyMapping('A', 'W', 'D', 'S', 'F', 'G', 'R', 'T');
      player2.setKeyMapping(LEFT, UP, RIGHT, DOWN, ALT, CONTROL, SHIFT, ENTER);
      ss1.x = 96;
      l1.x = 112;
      l2 = new Laser(145, 211);
      ss2 = new SpaceShip(129, 208, player2, l2);
    }
    else {
      ss2 = null;
      l2 = null;
    }
    
    //setup game
    lives = 3;
    stage = 1;
    enemies = new EnemyCollection((players == 1) ? 3 + diff : 3 + 2 * diff);
    paused1 = false; pushed1 = false;
    paused2 = false; pushed2 = false;
    stageState = 0; stageCounter = 180;
    gameOver = false; stageClear = false;
  }
  void step() {
    switch(stageState) {
      case 0: state0(); break;
      case 1: state1(); break;
      case 2: state2(); break;
      default: break;
    }
  }
  void display() {
    enemies.display();
    ss1.display();
    l1.display();
    if(ss2 != null) {
      ss2.display();
      l2.display();
    }
    
    //stats
    setColor(#C02B0E);
    setPosition(1, 2); printg("1UP");
    setPosition(7, 2); printg("2UP");
    setPosition(12, 2); printg("HI-SCORE");
    setColor(white);
    setPosition(1, 3); printScore(player1HS);
    setPosition(7, 3); printScore(player2HS);
    setColor(#0C5CD7);
    setPosition(14, 3); printScore(highScore);
    printLives();
    printStage();
    
    //center message
    switch(stageState) {
      case 0: printCenterMessage("ready"); break;
      case 1: if(paused1 || paused2) { printCenterMessage("paused"); } break;
      case 2: printCenterMessage((gameOver) ? "game over" : ""); break;
      default: break;
    }
  }
  
  //helper functions to step
  private void state0() {
    if(stageCounter-- == 0) {
      //reload counter, reset controllers
      stageCounter = 180;
      stageState = 1;
      player1.clear();
      player2.clear();
    }
  }
  private void state1() {
    //check for pause from any player
    if(player1.start && !pushed1 && !paused2) {
      paused1 = !paused1;
      pushed1 = true;
    }
    else if(!player1.start && pushed1) {
      pushed1 = false;
    }
    if(ss2 != null) {
      if(player2.start && !pushed2 && !paused1) {
        paused2 = !paused2;
        pushed2 = true;
      }
      else if(!player2.start && pushed2) {
        pushed2 = false;
      }
    }
    
    //if paused, no need to step
    if(paused1 || paused2) {
      return;
    }
    
    //actual stepping after checking for collisions
    player1HS += enemies.checkCollision(l1);
    if(l2 != null) { 
      player2HS += enemies.checkCollision(l2);
    }
    //highscore
    highScore = (player1HS > highScore) ? player1HS : highScore;
    if(l2 != null && player2HS > player1HS) {
      highScore = (player2HS > highScore) ? player2HS : highScore;
    }
    //stepping
    enemies.step();
    l1.step(); ss1.step();
    if(l2 != null) { 
      l2.step(); ss2.step();
    }
    
    //check for win and lose
    if(enemies.checkWin()) {
      stageClear = true;
      stageState = 2;
    }
    if(enemies.checkLose()) {
      lives = lives - 1;
      if(lives < 0) {
        gameOver = true;
      }
      stageState = 2;
    }
  }
  private void state2() {
    if(stageClear) {
      //allow for more player movement
      l1.step(); ss1.step();
      if(l2 != null) { 
        l2.step(); ss2.step();
      }
      //decrement counter to count up to 3 seconds
      if(stageCounter-- == 0) {
        //reload counter and create new enemies, change states
        stageCounter = 180;
        enemies = new EnemyCollection(enemies.diff + 2);
        stageClear = false;
        stageState = 0; stage++;
      }
    }
    else if(gameOver) {
      //decrement counter to count up to 3 seconds
      if(stageCounter-- == 0) {
        //reload counter and create new enemies, change states
        stageCounter = 180;
        state = 0;
        player1.setDefaultKeyMapping();
      }
    }
    else {
      if(stageCounter-- == 0) {
        stageCounter = 180;
        enemies.reposition();
        stageState = 0;
      }
    }
    
  }
  //helper functions to display
  private void printScore(int score) {
    if(score == 0) { printg("   00"); }
    else if(score < 100) { printg("   %d", score); }
    else if(score < 1000) { printg("  %d", score); }
    else if(score < 10000) { printg(" %d", score); }
    else if(score < 100000) { printg("%d", score); }
  }
  private void printLives() {
    for(int i = 0; i < lives; i++) {
      livesSprite.x = 169 + 8 * i;
      livesSprite.display();
    }
  }
  private void printStage() {
    if(stage < 6) {
      for(int i = 0; i < stage; i++) {
        stageSprite.x = 201 + i * 8;
        stageSprite.display();
      }
    }
    else {
      stageSprite.x = 201;
      stageSprite.display();
      setPosition(26, 3);
      setColor(white);
      if(stage < 10) {
        printg("0%d", stage);
      }
      else {
        printg("%d", stage);
      }
    }
  }
  private void printCenterMessage(String message) {
    if(message.length() == 0) {
      return;
    }
    
    setPosition(16 - message.length() / 2, 21);
    setColor(white);
    printg(message);
  }
  
}
