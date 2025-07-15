ArrayList<Cloud> clouds;
String[] emotions = {"happy", "angry", "sleepy", "calm"};

void setup() {
  size(1000, 500);
  clouds = new ArrayList<Cloud>();
  for (int i = 0; i < 6; i++) {
    clouds.add(new Cloud(random(width), random(height/2), random(80, 140)));
  }
}

void draw() {
  background(135, 206, 235);
  for (Cloud c : clouds) {
    c.update();
    c.display();
  }
}

void mousePressed() {
  for (Cloud c : clouds) {
    if (c.isMouseInside(mouseX, mouseY)) {
      c.changeEmotion();
    }
  }
}

void keyPressed() {
  for (Cloud c : clouds) {
    if (key == 'h') c.setEmotion("happy");
    if (key == 'a') c.setEmotion("angry");
    if (key == 's') c.setEmotion("sleepy");
    if (key == 'c') c.setEmotion("calm");
  }
}

class Cloud {
  float x, y, size, speed;
  String emotion;
  color cloudColor;

  Cloud(float x, float y, float size) {
    this.x = x;
    this.y = y;
    this.size = size;
    setEmotion("calm");
  }

  void setEmotion(String e) {
    emotion = e;
    switch(e) {
      case "happy":
        cloudColor = color(255, 255, 255, 200);
        speed = 1;
        break;
      case "angry":
        cloudColor = color(150, 50, 50, 220);
        speed = 3;
        break;
      case "sleepy":
        cloudColor = color(200, 200, 255, 120);
        speed = 0.5;
        break;
      case "calm":
      default:
        cloudColor = color(240, 240, 240, 180);
        speed = 1.5;
        break;
    }
  }

  void changeEmotion() {
    String newEmotion = emotions[int(random(emotions.length))];
    setEmotion(newEmotion);
  }

  void update() {
    x += speed;
    if (x > width + size) x = -size;
  }

  void display() {
    noStroke();
    fill(cloudColor);
    ellipse(x, y, size, size * 0.6);
    ellipse(x - size * 0.4, y + 10, size * 0.7, size * 0.5);
    ellipse(x + size * 0.4, y + 5, size * 0.6, size * 0.4);
  }

  boolean isMouseInside(float mx, float my) {
    return dist(mx, my, x, y) < size / 2;
  }
}
