float scale = 500;
int gridNum = 10;
float cpR = 10;//control point radius
PVector[] toR = {new PVector(0, 0), new PVector(1, 0.1), new PVector(0.8, 0.5), new PVector(0, 1)};//corner of rectangle
PVector[] fromR = {new PVector(0, 0), new PVector(1, 0), new PVector(1, 1), new PVector(0, 1)};
float[] A;
ArrayList<PControl> pControls = new ArrayList<PControl>();

void setup(){
  size(1400, 700);
  strokeWeight(5);
  A = solve(fromR, toR);
  for(int i = 0; i < 4; i++){
    fromR[i].add(random(EPSILON), random(EPSILON));//It's not perfect
    toR[i].add(1.5, 0);
    pControls.add(new PControl(fromR[i]));
    pControls.add(new PControl(toR[i]));
  }
}

void draw(){
  background(255);
  A = solve(fromR, toR);
  //show base grid
  fill(0);
  for(PVector p : fromR){
    ellipse(p.x*scale, p.y*scale, cpR*2, cpR*2);
  }
  for(float i = 0; i <= gridNum; i++){
    line(i/gridNum*scale, 0, i/gridNum*scale, scale);
  }
  for(float j = 0; j <= gridNum; j++){
    line(0, j/gridNum*scale, scale, j/gridNum*scale);
  }
  //show transformed grid
  for(PVector p : toR){
    ellipse(p.x*scale, p.y*scale, cpR*2, cpR*2);
  }
  for(PVector p : fromR){
    PVector P = transform(p, A);
    //ellipse(P.x*scale, P.y*scale, cpR*2, cpR*2);
  }
  for(float i = 0; i <= gridNum; i++){
    PVector sp = transform(new PVector(i/gridNum, 0), A);
    PVector ep = transform(new PVector(i/gridNum, 1), A);
    line(sp.x*scale, sp.y*scale, ep.x*scale, ep.y*scale);
  }
  for(float j = 0; j <= gridNum; j++){
    PVector sp = transform(new PVector(0, j/gridNum), A);
    PVector ep = transform(new PVector(1, j/gridNum), A);
    line(sp.x*scale, sp.y*scale, ep.x*scale, ep.y*scale);
  }
  if(mousePressed){
    for(PControl pControl : pControls){
      pControl.update();
    }
  }
}

void mousePressed(){
  for(PControl pControl : pControls){
    pControl.press();
  }
}

void mouseReleased(){
  for(PControl pControl : pControls){
    pControl.release();
  }
}