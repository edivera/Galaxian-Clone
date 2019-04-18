class Controller {
  
  //input variables
  int arrowPad;  //left, up, right, down
  boolean left, up, right, down;
  boolean a, b, select, start;
  
  //key mapping
  int leftKey, upKey, rightKey, downKey;
  int aKey, bKey, selectKey, startKey;
  
  
  Controller() {
    this(LEFT, UP, RIGHT, DOWN, 'Z', 'X', ' ', '\n');
  }
  Controller(int _left, int _up, int _right, int _down, int _a, int _b, int _select, int _start) {
    leftKey = _left;
    upKey = _up;
    rightKey = _right;
    downKey = _down;
    aKey = _a;
    bKey = _b;
    selectKey = _select;
    startKey = _start;
  }
  
  
  //setters
  public void setKeyTo(String keyName, int ascii) {
    keyName = keyName.toLowerCase();
    switch(keyName) {
      case "left": leftKey = ascii; break;
      case "up": upKey = ascii; break;
      case "right": rightKey = ascii; break;
      case "down": downKey = ascii; break;
      case "a": aKey = ascii; break;
      case "b": bKey = ascii; break;
      case "select": selectKey = ascii; break;
      case "start": startKey = ascii; break;
      default:
        println("*** Error: Invalid keyName when mapping key. No changes were done ***");
        break;
    }
  }
  public void setKeyMapping(int _left, int _up, int _right, int _down, int _a, int _b, int _select, int _start) {
    leftKey = _left;
    upKey = _up;
    rightKey = _right;
    downKey = _down;
    aKey = _a;
    bKey = _b;
    selectKey = _select;
    startKey = _start;
  }
  public void setDefaultKeyMapping() {
    setKeyMapping(LEFT, UP, RIGHT, DOWN, 'Z', 'X', ' ', '\n');
  }
  
  //input processing
  public void toggleKey(int keyEvent, boolean value) {
    if(keyEvent == leftKey) { left = value; }
    else if(keyEvent == upKey) { up = value; }
    else if(keyEvent == rightKey) { right = value; }
    else if(keyEvent == downKey) { down = value; }
    else if(keyEvent == aKey) { a = value; }
    else if(keyEvent == bKey) { b = value; }
    else if(keyEvent == selectKey) { select = value; }
    else if(keyEvent == startKey) { start = value; }
    else { /*do nothing*/ }
    arrowPad = ((left) ? 1 : 0) + ((up) ? 2 : 0) + ((right) ? 4 : 0) + ((down) ? 8 : 0);
  }
  public void clear() {
    arrowPad = 0;
    left = up = right = down = false;
    a = b = select = start = false;
  }
}
