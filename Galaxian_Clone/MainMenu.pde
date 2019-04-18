class MainMenu extends GUI  {
  
  InGame game;
  int players;
  int difficulty;
  boolean aPushed, bPushed;
  
  
  MainMenu(InGame _game) {
    game = _game;
    players = 1;
    difficulty = 1;
  }
  
  
  @Override
  void step() {
    if(player1.up && players == 2) { players = 1; }
    else if(player1.down && players == 1) { players = 2; }
    else if(player1.a && difficulty > 1 && !aPushed) { difficulty--; aPushed = true; }
    else if(player1.b && difficulty < 4 && !bPushed) { difficulty++; bPushed = true; }
    else if(player1.start) {
      game.newGame(players, difficulty);
      state = 1;
    }
    
    if(aPushed && !player1.a) { aPushed = false; }
    if(bPushed && !player1.b) { bPushed = false; }
  }
  @Override
  void display() {
    //stats
    setColor(#C02B0E);
    setPosition(1, 2); printg("1UP");
    setPosition(7, 2); printg("2UP");
    setPosition(12, 2); printg("HI-SCORE");
    setPosition(23, 2); printg("DIFF:");
    setColor(white);
    setPosition(29, 2); printg("%d", difficulty);
    setPosition(25, 3); printg("A B");
    setPosition(1, 3); printScore(player1HS);
    setPosition(7, 3); printScore(player2HS);
    setColor(#0C5CD7);
    setPosition(14, 3); printScore(highScore);
    
    if(players == 1) {
      setPosition(12,15);
      setColor(yellow);
      printg("1 Player");
      setPosition(12,17);
      setColor(white);
      printg("2 Players");
    }
    else {
      setPosition(12,15);
      setColor(white);
      printg("1 Player");
      setPosition(12,17);
      setColor(yellow);
      printg("2 Players");
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
}
