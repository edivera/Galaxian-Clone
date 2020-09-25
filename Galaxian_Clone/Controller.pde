class Controller {
  
  //input variables
  int arrowPad;  //left, up, right, down
  boolean left, up, right, down;
  boolean a, b, select, start;
  
  KeyMapping km;
  int controllerNumber;
  String name;
  
  
  Controller(int _controllerNumber) {
    this(null, _controllerNumber);
    setDefaultKeyMapping();
  }
  Controller(KeyMapping _km, int _controllerNumber) {
    controllerNumber = _controllerNumber;
    km = _km;
  }
  
  
  //setters
  public void setDefaultKeyMapping() {
    km = new KeyMapping(LEFT, UP, RIGHT, DOWN, 'Z', 'X', ' ', '\n');
  }
  
  //input processing
  public void toggleKey(int keyEvent, boolean value) {
    if(keyEvent == km.leftKey) { left = value; }
    else if(keyEvent == km.upKey) { up = value; }
    else if(keyEvent == km.rightKey) { right = value; }
    else if(keyEvent == km.downKey) { down = value; }
    else if(keyEvent == km.aKey) { a = value; }
    else if(keyEvent == km.bKey) { b = value; }
    else if(keyEvent == km.selectKey) { select = value; }
    else if(keyEvent == km.startKey) { start = value; }
    else { /*do nothing*/ }
    arrowPad = ((left) ? 1 : 0) + ((up) ? 2 : 0) + ((right) ? 4 : 0) + ((down) ? 8 : 0);
  }
  public void clear() {
    arrowPad = 0;
    left = up = right = down = false;
    a = b = select = start = false;
  }
}
