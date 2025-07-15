PImage img;

void setup() {
  size(800, 800);
  img = loadImage("pattern.png");
}

void draw() {
  background(0);
  
  int sliceW = width / 2;
  int sliceH = height / 2;
  
  int mx = constrain(mouseX, 0, img.width - sliceW);
  int my = constrain(mouseY, 0, img.height - sliceH);

  PImage region = img.get(mx, my, sliceW, sliceH);

  // Original (top-left)
  image(region, 0, 0);

  // Flipped horizontally (top-right)
  pushMatrix();
  translate(width, 0);
  scale(-1, 1);
  image(region, 0, 0);
  popMatrix();

  // Flipped vertically (bottom-left)
  pushMatrix();
  translate(0, height);
  scale(1, -1);
  image(region, 0, 0);
  popMatrix();

  // Flipped both (bottom-right)
  pushMatrix();
  translate(width, height);
  scale(-1, -1);
  image(region, 0, 0);
  popMatrix();
}
