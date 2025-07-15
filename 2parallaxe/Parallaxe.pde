PImage jelly;
float offset_x, offset_y;

void setup() {
  size(1000, 562, P2D);
  jelly = loadImage("jellyfish.png");
  imageMode(CENTER);
}

void draw() {
  background(10, 30, 60);
  translate(width / 2, height / 2);

  float mouse = float(mouseY) / float(height);

  color c1 = color(102, 204, 255, 200);
  color c2 = color(204, 102, 255, 130);
  color c3 = color(255, 204, 102, 100);

  imageLayer(c1, -80, -60, mouse, 2.0);
  imageLayer(c2, 50, 20, mouse, 1.5);
  imageLayer(c3, 120, 80, mouse, 2.8);
}

void imageLayer(color col, float offset_x, float offset_y, float mouse, float scale) {
  tint(col);
  image(jelly, offset_x, offset_y, mouse * scale * width, mouse * scale * height);
}
