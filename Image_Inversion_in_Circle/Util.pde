PVector mobiusInverse(PVector o, float r, PVector p){//Same as inverse function
  PVector d = PVector.sub(p, o);
  float a = r * r / d.magSq();
  return new PVector(a * d.x + o.x, a * d.y + o.y);
}
