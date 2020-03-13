float[] solve(PVector[] pt, PVector[] Pt){//p:from P:to each rectangle corner division by scale for accuracy
  PVector[] p = new PVector[4];
  PVector[] P = new PVector[4];
  p[0] = PVector.div(pt[0], scale).copy();
  p[1] = PVector.div(pt[1], scale).copy();
  p[2] = PVector.div(pt[2], scale).copy();
  p[3] = PVector.div(pt[3], scale).copy();
  P[0] = PVector.div(Pt[0], scale).copy();
  P[1] = PVector.div(Pt[1], scale).copy();
  P[2] = PVector.div(Pt[2], scale).copy();
  P[3] = PVector.div(Pt[3], scale).copy();
  float[][] N = {{p[0].x, p[0].y, 1,      0,      0, 0, -p[0].x*P[0].x, -p[0].y*P[0].x},
                 {p[1].x, p[1].y, 1,      0,      0, 0, -p[1].x*P[1].x, -p[1].y*P[1].x},
                 {p[2].x, p[2].y, 1,      0,      0, 0, -p[2].x*P[2].x, -p[2].y*P[2].x},
                 {p[3].x, p[3].y, 1,      0,      0, 0, -p[3].x*P[3].x, -p[3].y*P[3].x},
                 {     0,      0, 0, p[0].x, p[0].y, 1, -p[0].x*P[0].y, -p[0].y*P[0].y},
                 {     0,      0, 0, p[1].x, p[1].y, 1, -p[1].x*P[1].y, -p[1].y*P[1].y},
                 {     0,      0, 0, p[2].x, p[2].y, 1, -p[2].x*P[2].y, -p[2].y*P[2].y},
                 {     0,      0, 0, p[3].x, p[3].y, 1, -p[3].x*P[3].y, -p[3].y*P[3].y}};
                 
  float[] B = {P[0].x, P[1].x, P[2].x, P[3].x, P[0].y, P[1].y, P[2].y, P[3].y};
  
  return simultaSolve(N, B);
}

PVector transform(PVector pt, float[] A){
  PVector p = PVector.div(pt, scale);
  float x = (A[0]*p.x+A[1]*p.y+A[2])/(A[6]*p.x+A[7]*p.y+1);
  float y = (A[3]*p.x+A[4]*p.y+A[5])/(A[6]*p.x+A[7]*p.y+1);
  return new PVector(x*scale, y*scale);
}

boolean isInTriangle(PVector P, PVector A, PVector B, PVector C){//based on this site https://www.youtube.com/watch?v=HYAgJN3x4GA
  float w1 = (A.x*(C.y-A.y)+(P.y-A.y)*(C.x-A.x)-P.x*(C.y-A.y))/((B.y-A.y)*(C.x-A.x)-(B.x-A.x)*(C.y-A.y));
  float w2 = (P.y-A.y-w1*(B.y-A.y))/(C.y-A.y);
  if(w1 >= 0 && w2 >= 0 && (w1+w2) <= 1){
    return true;
  }else{
    return false;
  }
}