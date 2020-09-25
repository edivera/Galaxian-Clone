abstract class AnimatedObject {
  
  PImage[] frames;   //array of all frames
  int currentFrame;  //index for frame to display
  int x, y, w, h;    //in pixels
  
  abstract void step();
  void display() {
    if(currentFrame >= frames.length) {
      return;
    }
    
    float pixelW = 1.0 * width / 256;
    float pixelH = 1.0 * height / 240;
    float realX = x * pixelW;
    float realY = y * pixelH;
    for(int i = 0; i < h; i++) {
      for(int j = 0; j < w; j++) {
        if(frames[currentFrame].pixels[j + i * w] != #010101) {
          fill(frames[currentFrame].pixels[j + i * w]);
          stroke(frames[currentFrame].pixels[j + i * w]);
          rect(realX + j * pixelW, realY + i * pixelH, pixelW, pixelH);
        }
      }
    }
  }
  
}
