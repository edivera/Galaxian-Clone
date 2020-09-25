class KeyboardMenu extends GUI {
  private char[] enKeyboard = {
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 
    'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 
    'U', 'V', 'W', 'X', 'Y', 'Z', '-', ':', '.', ' ',
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ' '
  };
  
  private color[] colors = new color[41];
  private int debouncer = 10;
  
  int nextState;
  int cursor = 0;
  
  KeyboardMenu() {
    for(int i = 0; i < 40; i++) {
      colors[i] = white;
    }
    colors[cursor] = yellow;
  }
  
  @Override
  void step() {
    if(debouncer != 0) {
      debouncer--;
      return;
    }
    if(onlineName == null) {
      onlineName = "";
    }
    String prevName = onlineName;
    int prevCursor = cursor;
    
    if(player1.up) { cursor = (cursor + 40) % 50; }
    else if(player1.down) { cursor = (cursor + 10) % 50; }
    else if(player1.left) { cursor = (cursor - 1) % 41; }
    else if(player1.right) { cursor = (cursor + 1) % 41; }
    else if(player1.start || player1.a) {
      if(cursor == 40 && onlineName.length() > 0) {
        state = nextState;
        saveData();
        if(nextState == 1) {
          mmm.pollForNewMatch();
        }
      }
      else {
        if(onlineName.length() < 3) {
          onlineName += enKeyboard[cursor];
        }
        else {
          prevName += '*';
        }
      }
    }
    else if(player1.b) {
      if(onlineName.length() > 0) {
        onlineName = onlineName.substring(0, onlineName.length() - 1);
      }
    }
    
    if(prevName.length() != onlineName.length() || prevCursor != cursor) {
      debouncer = 10;
      if(cursor > 39) {
        cursor = 40;
      }
      colors[prevCursor] = white;
      colors[cursor] = yellow;
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
    
    int startX = 2;
    int startY = 10;
    int spreadX = 3;
    int spreadY = 2;
    
    for(int i = 0; i < 4; i++) {
      for(int j = 0; j < 10; j++) {
        int idx = i * 10 + j;
        char c = enKeyboard[idx];
        color col = colors[idx];
        setPosition(startX + spreadX * j, startY + spreadY * i);
        setColor(col);
        printg("" + c);
      }
    }
    setPosition(2, 18);
    setColor((cursor == 40) ? yellow : white);
    printg("END");
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
