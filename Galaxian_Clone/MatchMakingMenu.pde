class MatchMakingMenu extends GUI {
  private final String SERVER_IP = "192.168.0.132";
  private final int SERVER_PORT = 9000;
  
  PApplet context;
  InGame game;
  int counter;
  
  MatchMakingMenu(PApplet _context, InGame _game) {
    context = _context;
    game = _game;
  }
  
  @Override
  void step() {
    if(player1.b) {
      if(p2Conn != null)
        p2Conn.stop();
      state = 0;
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
    setPosition(12,15);
    printg("Linking." + (counter / 40 > 0 ? "." : "") + (counter / 80 > 0 ? "." : ""));
    counter = (++counter) % 120;
  }
  
  void pollForNewMatch() {
    Client server = new Client(context, SERVER_IP, SERVER_PORT);
    p2Conn = synack(server);
  }
  
  Client synack(Client server) {
    while(server.available() == 0);
    byte[] bytes = server.readBytes();
    int delegatePort = Integer.parseInt(new String(bytes).trim());
    server.write(delegatePort);
    
    return new RemotePlayer(context, SERVER_IP, delegatePort);
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
