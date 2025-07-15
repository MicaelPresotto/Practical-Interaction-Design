import processing.sound.*;

ArrayList<Orb> orbs = new ArrayList<Orb>();
PImage galaxyBg, starImg, planet1Img, planet2Img;
int planetCooldown = 0;

SoundFile collisionSound;
SoundFile bgMusic;

void setup() {
  size(800, 600);

  galaxyBg = loadImage("galaxy.jpg");
  starImg = loadImage("star.png");
  planet1Img = loadImage("planet1.png");
  planet2Img = loadImage("planet2.png");

  collisionSound = new SoundFile(this, "collision.wav");
  bgMusic = new SoundFile(this, "background.mp3");
  bgMusic.loop();

  noCursor();

  for (int i = 0; i < 12; i++) {
    orbs.add(new Orb(random(width), random(height), starImg, false, false, orbs));
  }

  orbs.add(new Orb(mouseX, mouseY, starImg, true, false, orbs)); // player-controlled star
}

void draw() {
  drawGalaxyBackground();

  for (Orb o : orbs) {
    o.update();
    o.display();
  }

  handleCollisions();

  if (planetCooldown > 0) {
    planetCooldown--;
  }
}

void drawGalaxyBackground() {
  imageMode(CORNER);
  image(galaxyBg, 0, 0, width, height);
}

void handleCollisions() {
  Orb player = null;
  for (Orb o : orbs) {
    if (o.isPlayerControlled) {
      player = o;
      break;
    }
  }

  if (player != null && planetCooldown == 0) {
    for (int i = 0; i < orbs.size(); i++) {
      Orb target = orbs.get(i);
      if (target.isPlanet || target.isPlayerControlled) continue;

      float d = dist(player.x, player.y, target.x, target.y);
      if (d < (player.r + target.r) * 0.9) {
        float newX = (player.x + target.x) / 2;
        float newY = (player.y + target.y) / 2;
        PImage chosenPlanet = random(1) < 0.5 ? planet1Img : planet2Img;
        orbs.add(new Orb(newX, newY, chosenPlanet, false, true, orbs));
        planetCooldown = 10;
        collisionSound.play(); // Sound plays here
        return;
      }
    }
  }

  for (int i = 0; i < orbs.size(); i++) {
    Orb a = orbs.get(i);
    if (a.isPlanet || a.isPlayerControlled) continue;
    for (int j = i + 1; j < orbs.size(); j++) {
      Orb b = orbs.get(j);
      if (b.isPlanet || b.isPlayerControlled) continue;

      float d = dist(a.x, a.y, b.x, b.y);
      if (d < (a.r + b.r) * 0.9 && planetCooldown == 0) {
        float newX = (a.x + b.x) / 2;
        float newY = (a.y + b.y) / 2;
        PImage chosenPlanet = random(1) < 0.5 ? planet1Img : planet2Img;
        orbs.add(new Orb(newX, newY, chosenPlanet, false, true, orbs));
        planetCooldown = 10;
        collisionSound.play(); // Sound plays here too
        return;
      }
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    orbs.removeIf(o -> !o.isPlayerControlled);
    orbs.add(new Orb(random(width), random(height), starImg, false, false, orbs));
    orbs.add(new Orb(random(width), random(height), starImg, false, false, orbs));
  }
}

class Orb {
  float x, y;
  float vx, vy;
  float r = 25;
  float spring = 0.3;
  float friction = -0.5;
  PImage img;
  boolean isPlanet = false;
  boolean isPlayerControlled = false;
  ArrayList<Orb> others;

  Orb(float x_, float y_, PImage img_, boolean playerControlled, boolean isPlanet_, ArrayList<Orb> others_) {
    x = x_;
    y = y_;
    img = img_;
    isPlayerControlled = playerControlled;
    isPlanet = isPlanet_;
    others = others_;

    float speed = 4;
    vx = random(-speed, speed);
    vy = random(-speed, speed);
    if (isPlanet) r *= 1.3;
  }

  void update() {
    if (isPlayerControlled) {
      x = mouseX;
      y = mouseY;
      return;
    }

    for (Orb other : others) {
      if (other == this || other.isPlayerControlled) continue;
      collide(other);
    }

    x += vx;
    y += vy;

    if (x < r || x > width - r) {
      x = constrain(x, r, width - r);
      vx *= friction;
    }
    if (y < r || y > height - r) {
      y = constrain(y, r, height - r);
      vy *= friction;
    }
  }

  void collide(Orb other) {
    float dx = other.x - x;
    float dy = other.y - y;
    float dist = sqrt(dx * dx + dy * dy);
    float minDist = r + other.r;
    if (dist < minDist && dist > 0) {
      float angle = atan2(dy, dx);
      float targetX = x + cos(angle) * minDist;
      float targetY = y + sin(angle) * minDist;
      float ax = (targetX - other.x) * spring;
      float ay = (targetY - other.y) * spring;

      vx -= ax;
      vy -= ay;
      other.vx += ax;
      other.vy += ay;
    }
  }

  void display() {
    imageMode(CENTER);
    image(img, x, y, r * 2, r * 2);
  }
}
