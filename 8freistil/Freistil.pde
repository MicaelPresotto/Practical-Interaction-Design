import processing.pdf.*;
import java.util.Calendar;

boolean savePDF = false;
String word = "ECHO";

void setup() {
  size(800, 800);
  textAlign(CENTER, CENTER);
  textSize(48);
  smooth();
}

void draw() {
  if (savePDF) beginRecord(PDF, timestamp() + ".pdf");

  background(0);
  fill(255);
  translate(width/2, height/2);
  float baseAngle = radians(mouseX * 0.2);
  float radiusStep = map(mouseY, 0, height, 20, 100);

  for (int r = 50; r < 400; r += radiusStep) {
    int num = int(TWO_PI * r / 40);
    for (int i = 0; i < num; i++) {
      float angle = TWO_PI / num * i + baseAngle;
      float x = cos(angle) * r;
      float y = sin(angle) * r;

      pushMatrix();
      translate(x, y);
      rotate(angle + sin(frameCount * 0.01 + r * 0.05));
      text(word.charAt(i % word.length()), 0, 0);
      popMatrix();
    }
  }

  if (savePDF) {
    savePDF = false;
    endRecord();
  }
}

void keyPressed() {
  if (key == 's') saveFrame(timestamp() + "_##.png");
  if (key == 'p') savePDF = true;
  if (key == ' ') word = randomWord(); 
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

String randomWord() {
  String[] options = {"ECHO", "WAVES", "BLAST", "VOID", "FEED", "NOISE", "RISE"};
  return options[int(random(options.length))];
}
