import processing.net.*;

/**********************************/
/* Simple Colors */
final color white  = #FFFFFF;
final color yellow = #FFFF00;
final color orange = #FFDF00;
final color red    = #FF0000;
final color purple = #FF00FF;
final color blue   = #0000FF;
final color green  = #00FF00;
final color black  = #000000;
/**********************************/

//background and stars
Stars[] stars;

//controllers
Controller player1;
Controller player2;

//game
GUI[] guiSM;  //state machine, made out of guis
InGame game;  //in game state
MainMenu mm;  //in main menu state
MatchMakingMenu mmm;  //match with another player
KeyboardMenu km;  //enter your name
int state=0;  //state = 0 first

//stats
int highScore;
int player1HS;
int player2HS;

//netplay
String onlineName;
boolean online;  //essentially multiplayer
Client p2Conn;

void setup() {
  size(960, 960);
  surface.setResizable(true);
  
  //background and stars
  stars = new Stars[36];
  for(int i = 0; i < 36; i++) {
    stars[i] = new Stars();
  }
  stars[0].spread(stars);
  
  //controllers
  player1 = new Controller(1);
  
  //load persistent data
  loadPersistentData();
  
  //game
  game = new InGame();
  mm = new MainMenu(game);
  mmm = new MatchMakingMenu(this, game);
  km = new KeyboardMenu();
  guiSM = new GUI[]{mm, game, mmm, km};
  
  //stats
  highScore = 0;
  player1HS = 0;
  player2HS = 0;
}

void draw() {
  background(black);
  for(Stars s : stars){
    s.display();
    s.step();
  }
  guiSM[state].display();
  guiSM[state].step();
}

void keyPressed() {
  player1.toggleKey(keyCode, true);
  if(online) {
    p2Conn.write("" + keyCode + " " + true);
  }
}

void keyReleased() {
  player1.toggleKey(keyCode, false);
  if(online) {
    p2Conn.write("" + keyCode + " " + false);
  }
}
