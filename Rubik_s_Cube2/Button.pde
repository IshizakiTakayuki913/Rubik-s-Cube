class Button{
  int x0,y0,x1,y1;
  String ch;
  color co;
  int time_interval=0;
  Boolean push=false;
  Button(int _x0,int _y0,int _x1,int _y1,String _ch,color _co){
    x0=_x0; y0=_y0; x1=_x1; y1=_y1; ch=_ch; co=_co;
  }
  void Draw(){
    push();
      fill(co);
      strokeWeight(5);
      stroke(-1);
      int b=10;
      rectMode(CORNERS);
      strokeJoin(BEVEL);
      rect(x0,y0,x1,y1);
      
      fill(-1);
      textAlign(CENTER,CENTER);
      textSize((y1-y0)*0.6);
      text(ch,(x0+x1)/2,(y0+y1)/2);
    pop();
  }
  void Push(){
    if(!(mousePressed==true && x0<mouseX && mouseX<x1 && y0<mouseY && mouseY<y1))  return;
    if(push==false && time_interval>frameCount)  return;
    push=true;
    time_interval=frameCount+FR*2;
  }
}
