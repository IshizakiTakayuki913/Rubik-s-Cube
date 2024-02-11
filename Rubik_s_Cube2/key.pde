int Button_Shift=0;
int Button_Control=0;
float dis=400;
int rad_k=90, rad_e=00;
Boolean Ke[]={false,false,false,false,false,false,false};
void KEY() {
  float X, Y, Z,rs=3;
  if (Ke[0])  rad_e+=rs;
  if (Ke[1])  rad_e-=rs;
  if (Ke[2])  rad_k+=rs;
  if (Ke[3])  rad_k-=rs;
  if (Ke[4])  dis-=rs*2;
  if (Ke[5])  dis+=rs*2;
  rad_e=constrain(rad_e,-86,86);
  rad_k%=360;
  dis=constrain(dis,50,700);
  float c=COS(dis, rad_e);
  Y=SIN(dis, rad_e);
  X=COS(c, rad_k);
  Z=SIN(c, rad_k);
  camera(X, -Y, Z, 0, 0, 0, 0, 1, 0);
}
void keyReleased() {
  switch(keyCode) {
    case      UP:   Ke[0]=false;   break;
    case    DOWN:   Ke[1]=false;   break;
    case    LEFT:   Ke[2]=false;   break;
    case   RIGHT:   Ke[3]=false;   break;    
    //case   SHIFT:   Ke[6]=false;   break;
  }
  switch(key) {
    case '\\': Ke[4]=false;   break;
    case '/':  Ke[5]=false;   break;
    case 'm':  
      String []s=split(scramble,' ');
      cube.tank_ro=s;
    break;
    case 'p':  
      Print_data2(cube.data_Cube);
    break;
    case 'q':  
      int [][]nd={{1,1,6},{1,1,6},{6,6,2}};
      cube.color_data_set(nd);
    break;
    case 's':  
      cube.tank_ro=get_solb;
    break;
  }
  cube.keyP(key);
}
void keyPressed() {
  switch(keyCode) {
    case      UP:  Ke[0]=true;   break;
    case    DOWN:  Ke[1]=true;   break;
    case    LEFT:  Ke[2]=true;   break;
    case   RIGHT:  Ke[3]=true;   break;
    case   SHIFT:  Button_Shift=frameCount+FR;  break;
    case CONTROL:  Button_Control=frameCount+FR;  break;
    case     TAB:    
      if(cube.Move_Rotate)  return;
      T=false;
      cam.Color_Load_ON=frameCount+20;   
    break;
  }
  switch(key) {
    case   '\\':   Ke[4]=true;   break;
    case    '/':   Ke[5]=true;   break;
  }
}
