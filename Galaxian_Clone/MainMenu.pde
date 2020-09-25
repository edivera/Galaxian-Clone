class MainMenu extends GUI  {
  
  private int debouncer = 0;
  
  InGame game;
  int cursor;
  int options;
  int difficulty;
  
  
  MainMenu(InGame _game) {
    game = _game;
    cursor = 0;
    options = 3;
    difficulty = 1;
  }
  
  
  @Override
  void step() {
    if(debouncer != 0) {
      debouncer--;
      return;
    }
    if(player1.up) { cursor = (cursor - 1) % options; debouncer = 10; }
    else if(player1.down) { cursor = (cursor + 1) % options; debouncer = 10; }
    else if(player1.start) {
      switch(cursor) {
        case 0: game.newGame(cursor, difficulty); break;
        case 1:
          if(onlineName != null) {
            mmm.pollForNewMatch();
          }
          else {
            state += 1;
          }
        case 2:
          km.nextState = state;
        default: break;
      }
      state += cursor + 1;
      debouncer = 20;
    }
  }
  @Override
  void display() {
    //stats
    setColor(#C02B0E);
    setPosition(1, 2); printg("1UP");
    setPosition(7, 2); printg("2UP");
    setPosition(12, 2); printg("HI-SCORE");
    setPosition(22, 2); printg("NAME:");
    setColor(white);
    setPosition(28, 2); printg(onlineName);
    setPosition(1, 3); printScore(player1HS);
    setPosition(7, 3); printScore(player2HS);
    setColor(#0C5CD7);
    setPosition(14, 3); printScore(highScore);
    
    setColor(white);
    if(cursor == 0) {
      setColor(yellow);
    }
    setPosition(9,15);
    printg("Single Player");
    setColor(white);
    if(cursor == 1) {
      setColor(yellow);
    }
    setPosition(10,17);
    printg("Online Coop");
    setColor(white);
    if(cursor == 2) {
      setColor(yellow);
    }
    setPosition(11,19);
    printg("Set Name");
  }
  
  //helper functions to display
  private void printScore(int score) {
    if(score == 0) { printg("   00"); }
    else if(score < 100) { printg("   %d", score); }
    else if(score < 1000) { printg("  %d", score); }
    else if(score < 10000) { printg(" %d", score); }
    else if(score < 100000) { printg("%d", score); }
  }
}
