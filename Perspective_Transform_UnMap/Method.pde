float[] solve(PVector[] p, PVector[] P){//p:from P:to each rectangle corner
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

PVector transform(PVector p, float[] A){
  float x = (A[0]*p.x+A[1]*p.y+A[2])/(A[6]*p.x+A[7]*p.y+1);
  float y = (A[3]*p.x+A[4]*p.y+A[5])/(A[6]*p.x+A[7]*p.y+1);
  return new PVector(x, y);
}

float[] simultaSolve(float[][] a, float[] b){
  float[][] A = new float[a.length][a[0].length+1];
  
  for(int j = 0; j < a.length; j++){
    for(int i = 0; i < a[0].length; i++){
      A[j][i] = a[j][i]+(float)i*EPSILON*97/100+(float)j*EPSILON*101/100;//it is not perfect. division by zero measures
    }
    A[j][a[0].length] = b[j];
  }
  return simultaSolve(A);
}

float[] simultaSolve(float[][] a){
  float t = 0;
  for(int k = 0; k < a.length; k++){
    for(int i = k + 1; i < a.length; i++){
      t = a[i][k] / a[k][k];
      for(int j = k + 1; j <=a.length; j++){
        a[i][j] -= a[k][j] * t;
      }
    }
  }
  
  for(int i = a.length-1; i >= 0; i--){
    t = a[i][a.length];
    for(int j = i + 1; j < a.length; j++) t -= a[i][j] * a[j][a.length];
    a[i][a.length] = t / a[i][i];
  }
  float[] result = new float[a.length];
  for(int k = 0; k < a.length; k++){
    result[k] = a[k][a.length];
  }
  return result;
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