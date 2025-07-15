import processing.video.*;
Capture video;

float angle = 0;
float angleStep = 0.01;
float radius = 250;

void setup() {
  size(800, 800);
  background(0);
  video = new Capture(this, 640, 480);
  video.start();
  imageMode(CENTER);
}

void draw() {
  if (video.available()) {
    video.read();
    video.loadPixels();
    
    int xCenter = video.width / 2;

    for (int y = 0; y < video.height; y++) {
      int pixelIndex = y * video.width + xCenter;
      color c = video.pixels[pixelIndex];

      float r = map(y, 0, video.height, 0, radius);
      float x = width/2 + cos(angle) * r;
      float y_ = height/2 + sin(angle) * r;

      stroke(c);
      point(x, y_);
    }

    angle += angleStep;

    if (angle > TWO_PI) {
      angle = 0;
    }
  }
}

void keyPressed() {
  if (key == 's') saveFrame("slitscan-####.png");
  if (key == 'r') {
    background(0);
    angle = 0;
  }
}
