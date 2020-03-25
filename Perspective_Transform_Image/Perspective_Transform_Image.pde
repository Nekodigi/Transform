float scale = 500;
int gridNum = 10;
float tEPS = EPSILON*10*scale;//transform EPSILON
float cpR = 20;//control point radius
PVector[] toR = {new PVector(0, 0), new PVector(scale, 0.1*scale), new PVector(0.8*scale, 0.5*scale), new PVector(0.1*scale, scale)};//corner of rectangle
PVector[] fromR = {new PVector(0, 0), new PVector(scale, 0), new PVector(scale, scale), new PVector(0, scale)};
float[] A;
float[] Ainv;
ArrayList<PControl> pControls = new ArrayList<PControl>();
float[] xx;
float[] yy;
float[][] r;
float[][] g;
float[][] b;
PImage img;
boolean render = false;

void setup(){
  //fullScreen();
  size(1920, 1080);
  img = loadImage("FevCat.png");
  xx = range(img.width+1);
  yy = range(img.height+1);
  r = new float[xx.length][yy.length];
  g = new float[xx.length][yy.length];
  b = new float[xx.length][yy.length];
  for (int i = 0; i < xx.length; i++) {
    for (int j = 0; j < yy.length; j++) {
      r[i][j] = red(img.get(i, j));
      g[i][j] = green(img.get(i, j));
      b[i][j] = blue(img.get(i, j));
    }
  }
  strokeWeight(10);
  A = solve(fromR, toR);
  for(int i = 0; i < 4; i++){
    fromR[i].add(random(tEPS), random(tEPS));//It's not perfect
    toR[i].add(scale*1.5, 0);
    pControls.add(new PControl(fromR[i]));
    pControls.add(new PControl(toR[i]));
  }
}

void draw(){
  background(255);
  A = solve(fromR, toR);
  Ainv = solve(toR, fromR);
  noStroke();
  for (int i = 0; i < xx.length; i++) {
    for (int j = 0; j < yy.length; j++) {
      //fill(r[i][j], g[i][j], b[i][j]);
      //rect(i, j, 1, 1);
    }
  }
  //show base grid
  fill(0);
  for(PVector p : fromR){
    ellipse(p.x, p.y, cpR*2, cpR*2);
  }
  for(float i = 0; i <= gridNum; i++){
    line(i/gridNum*scale, 0, i/gridNum*scale, scale);
  }
  for(float j = 0; j <= gridNum; j++){
    line(0, j/gridNum*scale, scale, j/gridNum*scale);
  }
  //show transformed grid
  for(PVector p : toR){
    ellipse(p.x, p.y, cpR*2, cpR*2);
  }
  for(PVector p : fromR){
    PVector P = transform(p, A);
    //ellipse(P.x, P.y, cpR*2, cpR*2);
  }
  for(float i = 0; i <= gridNum; i++){
    PVector sp = transform(new PVector(i/gridNum, 0), A);
    PVector ep = transform(new PVector(i/gridNum, 1), A);
    line(sp.x, sp.y, ep.x, ep.y);
  }
  for(float j = 0; j <= gridNum; j++){
    PVector sp = transform(new PVector(0, j/gridNum), A);
    PVector ep = transform(new PVector(1, j/gridNum), A);
    line(sp.x, sp.y, ep.x, ep.y);
  }
  float tileS = 10;
  if(render) tileS = 1;
  for(float x = 0; x < width; x+=tileS){
    for(float y = 0; y < width; y+=tileS){
      if(isInTriangle(new PVector(x, y), toR[0], toR[1], toR[2]) || isInTriangle(new PVector(x, y), toR[0], toR[2], toR[3])){
        PVector p2 = transform(new PVector(x, y), Ainv);
        if(p2.x > tEPS && p2.x < scale-tEPS && p2.y > tEPS && p2.y < scale-tEPS){
          fill(bicubic(xx, yy, r, p2.x, p2.y), bicubic(xx, yy, g, p2.x, p2.y), bicubic(xx, yy, b, p2.x, p2.y));
          rect(p2.x, p2.y, tileS, tileS);
        }
        rect(x, y, tileS, tileS);
      }
    }
  }
  
  if(mousePressed){
    for(PControl pControl : pControls){
      pControl.update();
    }
  }
  //println(frameRate);
}

void keyPressed(){
  if(key == 'r'){
    render = !render;
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