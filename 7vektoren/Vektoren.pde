PImage image;
PShape[] svgs;
float brSize;

void setup() {
  size(985, 720);
  svgs = new PShape[1];
  image = loadImage("city.png");
  image.loadPixels();

  for (int i = 0; i < svgs.length; i++) {
    svgs[i] = loadShape(i + ".svg");
  }
}

void draw() {
  background(0);
  shapeMode(CENTER);

  for (int y = 0; y < image.height; y += 2) {
    for (int x = 0; x < image.width; x += 3) {
      int index = x + y * image.width;
      float br = brightness(image.pixels[index]);
      int brIndex = int(constrain(br, 0, svgs.length));
      float m = (float(mouseX) / float(width)) * 4;

      if (brIndex != svgs.length) {
        shape(svgs[brIndex], x, y, m, m);
      }
    }
  }

  fill(255);
  textSize(24);
  text("City at Night", 20, height - 30);
}

void mousePressed() {
  redraw();
}

void mouseDragged() {
  redraw();
}
