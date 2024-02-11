import processing.video.*;
import processing.opengl.*;
int FR=20;
Capture pi;
CAMERA cam;
CUBE cube;
int [][][]data_Cube_ini={ 
{ {6,6,6,6,6},{6,6,6,6,6},{6,6,2,6,6},{6,6,6,6,6},{6,6,6,6,6} },
{ {6,6,6,6,6},{6,6,6,6,6},{6,6,6,6,6},{6,6,6,6,6},{6,6,6,6,6} },
{ {6,6,5,6,6},{6,6,6,6,6},{3,6,6,6,1},{6,6,6,6,6},{6,6,4,6,6} },
{ {6,6,6,6,6},{6,6,6,6,6},{6,6,6,6,6},{6,6,6,6,6},{6,6,6,6,6} },
{ {6,6,6,6,6},{6,6,6,6,6},{6,6,0,6,6},{6,6,6,6,6},{6,6,6,6,6} },
};
String scramble="D' F2 L2 U L2 D L2 R2 F2 U2 B' L F2 U F R D2 L2 F' U' L2";
String []color_set_move={
  "Y","Y","Y","Y X","X2","X"
};
String []get_solb;
Button test =new Button (528, 33,665, 90,"検査",#6AAA6E);
Button reset=new Button (528,140,665,200,"リセット",#582B93);
void setup(){
  size(900,600,P3D);
  //fullScreen(P3D);
  colorMode(HSB,360,100,100);
  frameRate(FR);
  noStroke();
  String[] cameras = Capture.list();
  for(;cameras.length==0;)    cameras = Capture.list();
  printArray(cameras);
  pi = new Capture(this, cameras[1],24); //cameras.length-1
  pi.start();
  cam=new CAMERA();
  cube=new CUBE(data_Cube_ini);
}
void captureEvent(Capture c) {
  c.read();
}
void draw(){
  if(pi.available() == true)  pi.read();
  Draw_back();
  int []data=cam.Color_Load();
  if(data.length!=0){
    cube.data_Cube_Set(data);
    cube.tank_ro=split(color_set_move[cam.men_cent-1],' ');
    if(cam.men_cent==6){
      pi.stop();
    }
  }
  if(cam.men_cent==6 && cube.Move_Rotate==false && cube.tank_ro.length==0 && !cube.numbering_count){
    cube.numbering_count=true;
    cube.numbering(); 
    get_solb=cube.Sort();
  }
  push();
    KEY();
    LINE();
    cube.Draw(cube.data_Cube,cube.rotat);
  pop();
  
  cube.Re_Write();
  cube.tank_rotate();
  
  if(cam.men_cent<6){
  cam.Draw_Camera(); 
  cam.Draw_In_Block();
  }
}
