class RemotePlayer extends Client {
  
  RemotePlayer(PApplet context, String host, int port) {
    super(context, host, port);
  }
  
  @Override
  public void run() {
    super.run();
    while(!game.gameOver) {
      while(available() == 0);
      byte[] bytes = readBytes();
      String message = new String(bytes).trim();
      decodeMessage(message);
    }
  }
  
  private void decodeMessage(String message) {
    String[] split = message.split(" ");
    switch(split[0]) {
      case "READY":
        game.stageState = 0; break;
      case "NAME":
        player2.name = split[1]; break;
      case "PRESS":
        player2.toggleKey(parseInt(split[1]), true); break;
      case "RELEASE":
        player2.toggleKey(parseInt(split[1]), false); break;
      case "SERVER":
        serverMessage(split[1]); break;
      default:
        println("default message: " + message); break;
    }
  }
  
  private void serverMessage(String op) {
    switch(op) {
      case "LEFT":
        game.player1OnTheLeft = true; break;
      case "RIGHT":
        game.player1OnTheLeft = false; break;
      case "READY":
        write("READY"); break;
      default:
        println("default op: " + op); break;
    }
  }
  
}
