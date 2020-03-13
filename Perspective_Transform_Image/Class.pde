class PControl{
  PVector p;
  PVector startPm;
  PVector startPp;
  boolean selected;
  
  PControl(PVector p){
    this.p = p;
  }
  
  void press(){
    PVector Pm = new PVector(mouseX, mouseY);
    if(PVector.dist(p, Pm) < cpR){
      startPp = p.copy();
      startPm = Pm;
      selected = true;
    }
  }
  
  void release(){
    selected = false;
  }
  
  void update(){
    if(selected){
      PVector diffPm = new PVector(mouseX, mouseY).sub(startPm);
      PVector t = PVector.add(startPp, diffPm);
      p.x = t.x; p.y = t.y;
    }
  }
}