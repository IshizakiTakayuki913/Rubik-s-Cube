String []rotate_char={
"B","B'","B2","Z","Z'","Z2","F","F'","F2",
"U","U'","U2","Y","Y'","Y2","D","D'","D2",
"L","L'","L2","X","X'","X2","R","R'","R2",
};
int [][]rotate_data={
{0,-1,1},{0,-1,-1},{0,-1,2},{0,0,1},{0,0,-1},{0,0,2},{0,1,1},{0,1,-1},{0,1,2},
{1,-1,1},{1,-1,-1},{1,-1,2},{1,0,1},{1,0,-1},{1,0,2},{1,1,1},{1,1,-1},{1,1,2},
{2,-1,1},{2,-1,-1},{2,-1,2},{2,0,1},{2,0,-1},{2,0,2},{2,1,1},{2,1,-1},{2,1,2},
};
float COS(float w, float r) {    
  return cos(radians(r))*w;
}
float SIN(float w, float r) {    
  return sin(radians(r))*w;
}
float XX(float r, float x, float y) {
  return x*cos(radians(r))-y*sin(radians(r));
}
float YY(float r, float x, float y) {
  return x*sin(radians(r))+y*cos(radians(r));
}
void mousePressed(){
  //test.Push();
  //reset.Push();
}
void Draw_back(){
  background(220, 50, 90);
  ambientLight    (0,0,50);
  lightSpecular   (0,0,50);
  directionalLight(0,0,80, 1,1,-1); 
}
void LINE() {
  int c=0,s=5,w=width/5*2;
  push();
  noStroke();
  fill(c+=100, 100, 100, 80);
  box(w, s,s);
  fill(c+=100, 100, 100, 80);
  box(s, w, s);
  fill(c+=100, 100, 100, 80);
  box(s,s, w);
  pop();
  push();
    fill(0,0,30);
    translate(0, width/2, 0);
    box(width,20,width);
  pop();
}
float PM(float n){
  int g=1;
  if(n==0)  g=0;
  else if(n<0)  g=-1;
  return g;
}
void Print_data(int [][][]da){
  println("int [][][]data={");
  for(int [][]z:da){  print("{");
    for(int   []y:z){  print("{");
      for(int     x:y)  print(x+",");
      print("},");
    }
    println(" }");
  }
  println(" };");
}
void Print_data2(int [][][]da){
  for(int [][]z:da){  print(" ");
    for(int   []y:z){  print(" ");
      for(int     x:y){
        if(x<10)  print(" ");
        print(x+" ");
      }
      print(" ");
    }
    println(" ");
  }
  println();
}
void IMage(PImage pic){
  PGraphics pg;
  println("保存しました");
  pg = createGraphics(100, 100);
  pg.beginDraw();
  pg.image(pic,0,0);
  pg.endDraw();
  pg.save("pic/IMage.png");
}
//int [][][]data_Cube_ini={ 
//{ {9,9,9,9,9},{9,5,5,5,9},{9,2,2,2,9},{9,2,2,2,9},{9,9,9,9,9} },
//{ {9,0,0,5,9},{3,9,9,9,2},{3,9,9,9,1},{3,9,9,9,1},{9,4,4,4,9} },
//{ {9,5,5,5,9},{3,9,9,9,2},{3,9,9,9,1},{3,9,9,9,1},{9,4,4,4,9} },
//{ {9,1,1,5,9},{2,9,9,9,1},{3,9,9,9,1},{3,9,9,9,1},{9,4,4,4,9} },
//{ {9,9,9,9,9},{9,5,5,0,9},{9,0,0,0,9},{9,0,0,0,9},{9,9,9,9,9} },
//};
//int [][][]data_Cube_ini={ 
//{ {9,9,9,9,9},{9,2,2,2,9},{9,2,2,2,9},{9,2,2,2,9},{9,9,9,9,9} },
//{ {9,5,5,5,9},{3,9,9,9,1},{3,9,9,9,1},{3,9,9,9,1},{9,4,4,4,9} },
//{ {9,5,5,5,9},{3,9,9,9,1},{3,9,9,9,1},{3,9,9,9,1},{9,4,4,4,9} },
//{ {9,5,5,5,9},{3,9,9,9,1},{3,9,9,9,1},{3,9,9,9,1},{9,4,4,4,9} },
//{ {9,9,9,9,9},{9,0,0,0,9},{9,0,0,0,9},{9,0,0,0,9},{9,9,9,9,9} },
//};
//int [][][]data_Cube_ini={ 
//{ {6,6,6,6,6},{6,6,6,6,6},{6,6,2,6,6},{6,6,6,6,6},{6,6,6,6,6} },
//{ {6,6,6,6,6},{6,6,6,6,6},{6,6,6,6,6},{6,6,6,6,6},{6,6,6,6,6} },
//{ {6,6,5,6,6},{6,6,6,6,6},{3,6,6,6,1},{6,6,6,6,6},{6,6,4,6,6} },
//{ {6,6,6,6,6},{6,6,6,6,6},{6,6,6,6,6},{6,6,6,6,6},{6,6,6,6,6} },
//{ {6,6,6,6,6},{6,6,6,6,6},{6,6,0,6,6},{6,6,6,6,6},{6,6,6,6,6} },
//};
