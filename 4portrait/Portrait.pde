PImage[] images;
int size_x, size_y;

void setup() 
{
  size(600, 600); 
  images = new PImage[3]; 
  size_x = width / 3; 
  size_y = height / 3; 

  for (int i = 0; i < images.length; i++) 
  {
    images[i] = loadImage("portrait" + (i + 1) + ".jpg");
    images[i].resize(width, height);
  }

  image(images[int(random(images.length))], 0, 0);
}

void mousePressed() 
{
  mouseDragged();
}

void mouseDragged() 
{
  int x = int(mouseX / size_x) * size_x;
  int y = int(mouseY / size_y) * size_y;

  PImage tile = images[int(random(images.length))].get(x, y, size_x, size_y);

  PGraphics pg = createGraphics(size_x, size_y);
  pg.beginDraw();
  pg.translate(size_x / 2, size_y / 2);
  pg.rotate(random(TWO_PI));
  pg.imageMode(CENTER);
  pg.image(tile, 0, 0);
  pg.endDraw();

  image(pg, x, y);
}

void draw() {}
