float scale = 200;
int nr = 10, nt = 40;

void setup() {
  size(500, 500);
  noFill();
  strokeWeight(5);
  background(255);
  translate(width/2, height/2);
  for (int i = 0; i < nr; i++) {
    float r = easeOutCubic(map(i, 0, nr, 0, 1))*scale;
    beginShape();
    for (int j = 0; j < nt; j++) {
      float theta = map(j, 0, nt, 0, TWO_PI);
      PVector pos = PVector.fromAngle(theta).mult(r);
      vertex(pos.x, pos.y);
    }
    endShape(CLOSE);
  }
}

void  draw() {
}

float easeOutCubic(float x) {
  return 1 - pow(1 - x, 3);
}
