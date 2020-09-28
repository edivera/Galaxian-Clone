class MatchMakingMenu extends GUI {
  private final String SERVER_IP = "192.168.0.132";
  private final int SERVER_PORT = 9000;
  
  PApplet context;
  InGame game;
  
  MatchMakingMenu(PApplet _context, InGame _game) {
    context = _context;
    game = _game;
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
}
