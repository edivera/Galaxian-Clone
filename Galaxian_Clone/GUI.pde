class GUI {
  
  final PImage characters = loadImage("Characters.png");
  int x, y;          //character location indeces
  color col = white; //color of the characters to be printed
  
  
  //setters
  final public void setColor(color _col) {
    col = _col;
  }
  final public void setPosition(int _x, int _y) {
    x = _x;
    y = _y;
  }
  
  //printing functions
  final public void printg(String message, float... variables) {
    //save x and y
    int saveX = x;
    int saveY = y;
    
    //print
    printG(message, variables);
    
    //restore x and y
    x = saveX;
    y = saveY;
  }
  final private void printG(String message, float... variables) {
    //parse and print
    int argument = 0;  //index for the arguments
    int length = message.length();
    for(int i = 0; i < length; i++) {
      if(message.charAt(i) == '%') {
        i++;
        printVariable(message.charAt(i), variables[argument++]);
      }
      else {
        x = (printer(message.charAt(i))) ? x + 1: x;
      }
    }
  }
  final private void printVariable(char type, float variable) {
    String toPrint = "";
    switch(type) {
      case 'c':
        toPrint += (char)variable;
        break;
      case 'd':
        toPrint += (int)variable;
        break;
      case 'f':
        toPrint += variable;
        break;
      default:
        println("*** Error on %type passed to printg: " + type + " is not a valid type ***");
    }
    printG(toPrint);
  }
  final private boolean printer(char c) {
    //pixel calculations
    float pixelW = 1.0 * width / 256;
    float pixelH = 1.0 * height / 240;
    float realX = x * 8 * pixelW + pixelW;  //index * charWidth * pixelWidth + spaceOffset
    float realY = y * 8 * pixelH + pixelH;  //index * charHeight * pixelHeight + spaceOffset
    if(x >= 32) {
      println("*** Warning: 32 horizontal characters exceeded ***");
    }
    else if(y >= 30) {
      println("*** Warning: 30 vertical characters exceeded ***");
    }
    
    //select character. Space by default
    boolean printable = true;
    int charX = 9;
    int charY = 2;
    if(Character.isLetter(c)) {
      int num = Character.toUpperCase(c) - 0x41;
      charX = num % 10;
      charY = num / 10;
    }
    else if(Character.isDigit(c)) {
      charX = c - 0x30;
      charY = 3;
    }
    else if(c == '-') { charX = 6; charY = 2; }
    else if(c == ':') { charX = 7; charY = 2; }
    else if(c == '.') { charX = 8; charY = 2; }
    else if(c == ' ') {}
    else {
      println("*** Error: Failed to print character '" + c + "' ***");
      printable = false;
    }
    
    for(int i = 0; i < 7; i++) {
      for(int j = 0; j < 7; j++) {
        if(characters.pixels[(charX * 10 + j) + (charY * 10 + i) * 100] != #010101) {
          fill(col);
          stroke(col);
          rect(realX + j * pixelW, realY + i * pixelH, pixelW, pixelH);
        }
      }
    }
    return printable;
  }
  
  //simulation functions. Override these
  void step() {}
  void display() {}
  
}
