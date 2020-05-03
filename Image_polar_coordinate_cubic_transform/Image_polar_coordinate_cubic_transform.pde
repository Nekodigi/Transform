float outSize = 200;
float mapSize = 200;
int nr = 10, nt = 20;
boolean render = false;

PImage img;
Bicubic bicubic;

void setup(){
  size(500, 500);
  //fullScreen();
  img = loadImage("FevCat.png");
  bicubic = new Bicubic(img);
}

void  draw(){
  background(255);
  image(img, 0, 0, height/4, height/4);
  
  translate(width/2, height/2);
  float tileS = 5;
  if(render){ 
    tileS = 1;
  }
  //show image
  noStroke();
  for(float x = -outSize; x < outSize; x+=tileS){
    for(float y = -outSize; y < outSize; y+=tileS){
      PVector p = new PVector(y, x);
      float rp = map(p.mag(), 0, mapSize, 0, 1);
      float offX = map(width-mouseX, 0, width, 0, img.width);
      float offY = map(height-mouseY, 0, height, 0, img.height);
      PVector p2 = p.setMag(unEaseOutCubic(rp)*img.height).add(offY, offX);
      if(p2.x > 0 && p2.x < img.width && p2.y > 0 && p2.y < img.height){
        fill(bicubic.colorAt(p2.y, p2.x));
        //rect(p2.x, p2.y, tileS, tileS);
        rect(x, y, tileS, tileS);
      }
    }
  }
}

void keyPressed(){
  if(key == 'r'){
    render = !render;
  }
}
