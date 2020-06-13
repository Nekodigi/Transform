float r = 100;

void setup(){
  size(500, 500);
  background(255);
  PVector o = new PVector(width/2, height/2);
  for(float x = 0; x < width; x+=50){
    for(float y = 0; y < height; y+=50){
      PVector sP = new PVector(x, y);
        ellipse(x, y, 20, 20);
        PVector inved = mobiusInverse(o, r, sP);
        ellipse(inved.x, inved.y, 20, 20);
        //PVector invinved = mobiusInverse(o, r, inved);
        //ellipse(invinved.x, invinved.y, 20, 20);
    }
  }
  //ellipse(width/2, height/2, 200, 200);
}

void draw(){
}

PVector mobiusInverse(PVector o, float r, PVector p){
  PVector d = PVector.sub(p, o);
  float a = r * r / d.magSq();
  return new PVector(a * d.x + o.x, a * d.y + o.y);
}

PVector mobiusInverseInv(PVector o, float r, PVector p){
  PVector d = PVector.sub(p, o);
  float a = r * r / d.magSq();
  return new PVector(a * d.x + o.x, a * d.y + o.y);
}
