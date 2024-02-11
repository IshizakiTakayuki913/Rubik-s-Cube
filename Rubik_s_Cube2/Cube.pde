class CUBE{
  int cubelin=3+2;
  int [][][]data_Cube;
  int []rotat=new int[3];
  int block_w=60;
  int frame;
  int one_modve_frame=int(FR*1);
  String []tank_ro=new String[0];
  Boolean Move_Rotate=false;
  Boolean numbering_count=false;
  char []ro_ke={  'F',   'B',   'D',   'U',   'R',   'L',   'Z',   'Y',   'X' };
  int [][]yazi={
    { 50, 4,  0},  { 50,-4,  0},
    {  0, 4,-30},  {  0,-4,-30},
    {  0, 4, 30},  {  0,-4, 30},
  };
  CUBE(int [][][]data_Cube_ini){
    data_Cube=data_Cube_ini;
  }  void Draw_Effect(int []rota){
    int w=140;
    if(!Move_Rotate)  return;
    int pog=rota[1],rad=rota[2];
    //int mov=rota[1]*int(constrain(rota[2],-1,1));
    int mov=(rota[1]==0?1:rota[1])*int(constrain(rota[2],-1,1));
    
    pushMatrix();
    switch(rota[0]){
      case 0: 
        translate(0,0,pog*block_w);
        rotateZ(radians(-45)); 
        switch(mov){
          case -1: 
            rotateX(radians(180)); 
          break;
          case  1: 
          break;
        }
      break;
      case 1:   
        translate(0,pog*block_w,0);
        rotateY(radians(-45)); 
        switch(mov){
          case  1: 
            if(pog==0){  rotateX(radians(90));  break;  } 
            rotateX(radians(-90)); 
          break;
          case -1:    
            if(pog==0){  rotateX(radians(-90));  break;  } 
            rotateX(radians( 90)); 
          break;
        }
      break;
      case 2: 
        translate(pog*block_w,0,0);
        rotateY(radians(-90)); 
        rotateZ(radians(-45)); 
        switch(mov){
          case  1: 
            rotateX(radians(180)); 
          break;
          case -1: 
          break;
        }
      break;
    }
    effect(rad);
    popMatrix();
    //int pog=rota[1],rad=rota[2];
    //int mov=int(map(frameCount,frame-one_modve_frame*abs(rad),frame,0,87));
  }
  void effect(int rad){
    int w=130;
    push();
    noStroke();
    fill(#0028FF);
    int i=0;
    for(i=-45;i<-45+map(frameCount,frame-one_modve_frame*abs(rad),frame,0,90*abs(rad));i+=2){
      pushMatrix();
      rotateZ(radians(i));  
      translate(w,0,0);
      box(4,20,20);
      popMatrix();
    }
    pushMatrix();
      rotateZ(radians(i-10));  
      translate(w,0,0);
      rotateZ(radians(100));  
      beginShape(QUAD_STRIP);
      for(int s=0;s<yazi.length+2;s++)   vertex(yazi[s%yazi.length][0],yazi[s%yazi.length][1],yazi[s%yazi.length][2]);
      endShape(CLOSE);
      beginShape(TRIANGLES);
      for(int s=0;s<yazi.length+2;s+=2)  vertex(yazi[s%yazi.length][0],yazi[s%yazi.length][1],yazi[s%yazi.length][2]);
      endShape(CLOSE);
      beginShape(TRIANGLES);
      for(int s=1;s<yazi.length+2;s+=2)  vertex(yazi[s%yazi.length][0],yazi[s%yazi.length][1],yazi[s%yazi.length][2]);
      endShape(CLOSE);
    popMatrix();
    pop();
  }
  String [] Sort(){
    int [][][]seek=new int [cubelin][cubelin][cubelin];
    String []R_C={},Tan={};
    for(int i=0;i<int(pow(cubelin,3));i++){
      int z=int(i/pow(cubelin,2)), y=int((i%pow(cubelin,2))/pow(cubelin,1)),x=int(i%pow(cubelin,1));
      seek[z][y][x]=data_Cube[z][y][x];
    }
    Tan=Sort_Edge_FD(seek);
    if(Tan.length!=0){
      R_C=concat(R_C,Tan);  
      print("Edge FD rotate : \n");   for(String c:Tan){  print(c+"  ");  if(c.equals("Y")) println();}   println();
    }
    
    Tan=Sort_Corner_FDR(seek);
    if(Tan.length!=0){
      R_C=concat(R_C,Tan);  
      print("Corner FRD rotate : \n");     for(String c:Tan){  print(c+"  ");  if(c.equals("Y")) println();}   println();
    }
    
    Tan=Sort_Edge_FR(seek);
    if(Tan.length!=0){
      R_C=concat(R_C,Tan);  
      print("Edge RF rotate : \n");    for(String c:Tan){  print(c+"  ");  if(c.equals("Y")) println();}   println();
    }
    
    Tan=Sort_OLL_Cross(seek);    
    if(Tan.length!=0){
      R_C=concat(R_C,Tan);    
      print("Edge U rotate : \n");    for(String c:Tan){  print(c+"  ");  if(c.equals("Y")) println();}   println();
    }
    
    Tan=Sort_OLL_Corner(seek);    
    if(Tan.length!=0){
      R_C=concat(R_C,Tan);    
      print("Corner U rotate : \n");    for(String c:Tan){  print(c+"  ");  if(c.equals("Y")) println();}   println();
    }
    
    Tan=Sort_PLL_Cross(seek);    
    if(Tan.length!=0){
      R_C=concat(R_C,Tan);    
      print("Cross PLL rotate : \n");    for(String c:Tan){  print(c+"  ");  if(c.equals("Y")) println();}   println();
    }
    
    Tan=Sort_PLL_Corner(seek);    
    if(Tan.length!=0)  R_C=concat(R_C,Tan);    
    print("Corner PLL rotate : \n");    for(String c:Tan){  print(c+"  ");  if(c.equals("Y")) println();}   println();
    
    Tan=Sort_PLL_AUF(seek);    
    if(Tan.length!=0)  R_C=concat(R_C,Tan);    
    print("AUF rotate : \n");    for(String c:Tan){  print(c+"  ");  if(c.equals("Y")) println();}   println();
    
    return R_C;
  }
  String []Sort_PLL_AUF(int [][][]seek){
    String []R_C=new String [0];
    String Tc="";
    int u=seek[cubelin-1][cubelin/2-1][cubelin/2];
    if(u==seek[cubelin-1][cubelin/2][cubelin/2])  return  R_C;
    if(u==seek[cubelin/2][cubelin/2][cubelin-1])  Tc="U'";
    if(u==seek[0][cubelin/2][cubelin/2])  Tc="U2";
    if(u==seek[cubelin/2][cubelin/2][0])  Tc="U  ";
    print("ro :");  for(String a:split(Tc,' '))  print(a+" ");
    println();
    R_C=concat(R_C,split(Tc,' '));
    return R_C;
  }
  String []Sort_PLL_Corner(int [][][]seek){
    String []R_C=new String [0];
    String Tc="",A="X' R2 D2 R' U' R D2 R' U R' X",B="X' R U' R D2 R' U R D2 R2 X";
    int []side=new int [8];
    int T=0,F=0;
    int t=-1,f=-1;
    for(int i=0;i<4;i++){
      int ey=round(-sin(i*radians(90)-HALF_PI)),ex=round(cos(i*radians(90)-HALF_PI));
      int cy=round(-sqrt(2)*sin(i*radians(90)-HALF_PI/2)),cx=round(sqrt(2)*cos(i*radians(90)-HALF_PI/2));
      println("ex:"+nfs(ex,0)+" ey:"+nfs(ey,0)+" cx:"+nfs(cx,0)+" cy:"+nfs(cy,0));
      side[i*2]=seek[cubelin/2+ey][1][cubelin/2+ex]-18;
      side[i*2+1]=seek[cubelin/2+cy][1][cubelin/2+cx]-34;
    }
    for(int i=0;i<4;i++){
      if(side[i*2]==side[(i*2+1)%side.length]){  T++;  t=i;  }
      if(side[i*2]==side[(i*2-1+side.length)%side.length]){  F++;  f=i;  }
    }
    println(" T:"+T+" t:"+t+" F:"+F+" f:"+f);
    if(T==4) return R_C;
    if(T==0 && F==0) Tc=A+" U' "+A;
    if(T==0 && F==2) {
      if(f%2==0)  Tc=A+" U "+A;
      if(f%2!=0)  Tc=" U "+A+" U "+A;
    }
    if(T==1) {
      if(t==0)  Tc="U2";
      if(t==1)  Tc="U'";
      if(t==3)  Tc="U";
      
      if(F==0)  Tc+=(" "+A);
      if(F==2)  Tc+=(" "+B);
    }
    print("ro :");  for(String c:split(Tc,' '))  print(c+" ");
    println();
    R_C=concat(R_C,split(Tc,' '));
    SEEK_ROTATE(seek,Tc);
    return R_C;
  }
  String []Sort_PLL_Cross(int [][][]seek){
    String []R_C=new String [0];
    String Tc="",A="R U' R U R U R U' R' U' R2",B="R2 U R U R' U' R' U' R' U R'";
    int []side={seek[cubelin/2+1][1][cubelin/2  ],seek[cubelin/2  ][1][cubelin/2+1],
                seek[cubelin/2-1][1][cubelin/2  ],seek[cubelin/2  ][1][cubelin/2-1]};
    for(int i=0;i<side.length;i++)  side[i]-=18;
    int pair=-1;
    for(int i=0;i<side.length;i++)if((side[i]+1)%4==side[(i+1)%4])  pair+=(i+1);
    if(pair>4) return R_C;
    if(pair==-1) Tc=A+" U' "+A;
    if(pair== 0) Tc=B;
    if(pair== 1) Tc="U "+B;
    if(pair== 2) Tc="U' "+A;
    if(pair== 3) Tc=A;
    R_C=concat(R_C,split(Tc,' '));
    SEEK_ROTATE(seek,Tc);
    return R_C;
  }
    
  String []Sort_OLL_Corner(int [][][]seek){
    String []R_C=new String [0];
    String Tc="";
    String L="L' U' L U' L' U2 L R U R' U R U2 R'",R="R U2 R' U' R U' R' L' U2 L U L' U L";
    for(int i=0;i<=3;i++){
      int []ins=OLL_Corner_Ins(seek);
      if(min(ins)==max(ins))  return R_C;
      if     (ins[0]!=1)  Tc=ins[0]==0?L:R;
      else if(ins[1]!=1)  Tc="U "+(ins[1]==0?L:R);
      else if(ins[2]!=1)  Tc="U2 "+(ins[2]==0?L:R);
      R_C=concat(R_C,split(Tc,' '));
      SEEK_ROTATE(seek,Tc);
    }
    return R_C;
  }
  int []OLL_Corner_Ins(int [][][]seek){
    int []ins=new int [4];
    int Center=seek[cubelin/2][0][cubelin/2];
    for(int i=0;i<4;i++){
      int y=int(i/2)*2-1,x=(i%2)*2-1;
      ins[i]=seek[cubelin/2+y][0][cubelin/2+x]==Center?1:0;
      if(ins[i]==0){
        ins[i]=seek[cubelin/2+y][1][cubelin/2+x*2]==Center?0:2;
        if(y*x==1)  ins[i]=(ins[i]+6)%4;
      }
    }
    int []ins2={ins[3],ins[1],ins[0],ins[2]};
    return  ins2;
  }
  String []Sort_OLL_Cross(int [][][]seek){
    String []R_C=new String [0];
    int []edge={seek[cubelin/2-1][0][cubelin/2],seek[cubelin/2][0][cubelin/2-1],seek[cubelin/2+1][0][cubelin/2]};
    for(int i=0;i<3;i++)  edge[i]= edge[i]==seek[cubelin/2][0][cubelin/2] ? 1 : 0;
    //print(" edge :");  for(int i:edge)  print(i+" ");
    String Tc="",S="F R' F' R U R U' R'",L="R U R' U' R' F R F'";
    if(edge[0]==1 && edge[1]==1 && edge[2]==1)  return R_C;
    
    if(edge[0]==1 && edge[1]==1 && edge[2]==0)  Tc=S;
    if(edge[0]==1 && edge[1]==0 && edge[2]==0)  Tc="U' "+S;
    if(edge[0]==0 && edge[1]==0 && edge[2]==1)  Tc="U2 "+S;
    if(edge[0]==0 && edge[1]==1 && edge[2]==1)  Tc="U "+S;
    
    if(edge[0]==1 && edge[1]==0 && edge[2]==1)  Tc="U "+L;
    if(edge[0]==0 && edge[1]==1 && edge[2]==0)  Tc=L;
    
    if(edge[0]==0 && edge[1]==0 && edge[2]==0)  Tc=S+" U "+L;
      
    R_C=concat(R_C,split(Tc,' '));
    SEEK_ROTATE(seek,Tc);
    return R_C;
  }
  String []Sort_Edge_FR(int [][][]seek){
    String []R_C={};
    for(int n=14;n<=17;n++){
      int []point=Ins(seek,n);
      String Tc="";
      if(point[0]==1 && point[1]==0 && point[2]==1 &&
        seek[cubelin-1][cubelin/2][cubelin/2] == seek[cubelin-1][cubelin/2][cubelin-2]){
        Tc="Y";     
        R_C=concat(R_C,split(Tc,' '));
        SEEK_ROTATE(seek,Tc);
        continue;
      }
      if(point[1]==0){
        if(point[0]==-1 && point[2]==-1)  Tc="Y2 R U' R' F R' F' R Y2";
        if(point[0]==-1 && point[2]== 1)  Tc="Y R U' R' F R' F' R Y'"; 
        if(point[0]== 1 && point[2]==-1)  Tc="Y' R U' R' F R' F' R Y"; 
        if(point[0]== 1 && point[2]== 1)  Tc="R U' R' F R' F' R";
        R_C=concat(R_C,split(Tc,' '));
        SEEK_ROTATE(seek,Tc);
      }
      point=Ins(seek,n);
      if(point[1]==-1){
        int side_col=seek[point[0]+cubelin/2][0][point[2]+cubelin/2];
        if(side_col==seek[cubelin-1][cubelin/2][cubelin/2] ){
          if(point[0]==-1)  Tc="U R' F' R U R U' R' F Y";
          if(point[0]== 1)  Tc="U' R' F' R U R U' R' F Y";
          if(point[2]==-1)  Tc="U2 R' F' R U R U' R' F Y";
          if(point[2]== 1)  Tc="R' F' R U R U' R' F Y";
        }    
        else{
          if(point[0]==-1)  Tc="U' R U' R' F R' F' R Y";
          if(point[0]== 1)  Tc="U R U' R' F R' F' R Y";
          if(point[2]==-1)  Tc="R U' R' F R' F' R Y";
          if(point[2]== 1)  Tc="U2 R U' R' F R' F' R Y";
        }
      }    
      R_C=concat(R_C,split(Tc,' '));
      SEEK_ROTATE(seek,Tc);
    }
    return R_C;
  }
  String [] Sort_Edge_FD(int [][][]seek){
    String []R_C={};
    for(int n=10;n<=13;n++){
      int []point=Ins(seek,n);
      String Tc="";
      if(point[2]!=0){
        int side_col=seek[point[0]+cubelin/2][point[1]+cubelin/2][point[2]*2+cubelin/2];
        if(side_col==seek[cubelin-1][cubelin/2][cubelin/2] ){
          if(point[2]==-1){
            if(point[0]==-1)  Tc="L U' L' F2 Y";
            if(point[0]== 1)  Tc="L' U' L F2 Y";
            if(point[1]==-1)  Tc="U' F2 Y";
            if(point[1]== 1)  Tc="L2 U' F2 Y";
          }
          else if(point[2]==1){
            if(point[0]==-1)  Tc="R' U R F2 Y";
            if(point[0]== 1)  Tc="R U R' F2 Y";
            if(point[1]==-1)  Tc="U F2 Y";
            if(point[1]== 1)  Tc="R2 U F2 Y";
          }
        }    
        else{
          if(point[2]==-1){
            if(point[0]==-1)  Tc="L2 F' L2 Y";
            if(point[0]== 1)  Tc="F' Y";
            if(point[1]==-1)  Tc="L F' L' Y";
            if(point[1]== 1)  Tc="L' F' L Y";
          }
          else if(point[2]==1){
            if(point[0]==-1)  Tc="R2 F R2 Y";
            if(point[0]== 1)  Tc="F Y";
            if(point[1]==-1)  Tc="R' F R Y";
            if(point[1]== 1)  Tc="R F R' Y";
          }
        }
      }
      else if(point[2]==0){
        int side_col=seek[point[0]*2+cubelin/2][point[1]+cubelin/2][point[2]+cubelin/2];
        if(side_col==seek[cubelin-1][cubelin/2][cubelin/2] ){
          if(point[0]==-1 && point[1]==-1)  Tc="U2 F2 Y";
          if(point[0]==-1 && point[1]== 1)  Tc="B2 U2 F2 Y";
          if(point[0]== 1 && point[1]==-1)  Tc="F2 Y";
          if(point[0]== 1 && point[1]== 1)  Tc="Y";
        }    
        else{
          if(point[0]==-1 && point[1]==-1)  Tc="U R' F R Y";
          if(point[0]==-1 && point[1]== 1)  Tc="B2 U R' F R Y";
          if(point[0]== 1 && point[1]==-1)  Tc="U' R' F R Y";
          if(point[0]== 1 && point[1]== 1)  Tc="F2 U' R' F R Y";
        }
      }
      R_C=concat(R_C,split(Tc,' '));
      SEEK_ROTATE(seek,Tc);
    }    
    return R_C;
  }
  String [] Sort_Corner_FDR(int [][][]seek){
    String []R_C={};
    for(int n=30;n<=33;n++){
      int []point=Ins(seek,n);
      String Tc="";
      if(point[0]== 1 && point[1]== 1 && point[2]== 1){
        int dc=seek[cubelin/2][cubelin-1][cubelin/2];
        if(seek[cubelin-2][cubelin-1][cubelin-2]==dc)  Tc="Y";
        if(seek[cubelin-1][cubelin-2][cubelin-2]==dc)  Tc="R U' R' U R U' R' Y";
        if(seek[cubelin-2][cubelin-2][cubelin-1]==dc)  Tc="R U R' U' R U R' Y";
        R_C=concat(R_C,split(Tc,' '));
        SEEK_ROTATE(seek,Tc);
        continue;
      }
      if(point[2]==-1){
        if(point[0]==-1 && point[1]==-1)  Tc="U2";
        if(point[0]==-1 && point[1]== 1)  Tc="L U2 L'";
        if(point[0]== 1 && point[1]==-1)  Tc="U'";
        if(point[0]== 1 && point[1]== 1)  Tc="L' U' L";
      }     
      else if(point[2]==1){
        if(point[0]==-1 && point[1]==-1)  Tc="U";
        if(point[0]==-1 && point[1]== 1)  Tc="R' U2 R U'";
      }
      R_C=concat(R_C,split(Tc,' '));
      SEEK_ROTATE(seek,Tc);
      
      int dc=seek[cubelin/2][cubelin-1][cubelin/2];
      if(seek[cubelin-2][0][cubelin-2]==dc)  Tc="R U2 R' U' R U R' Y";
      if(seek[cubelin-1][1][cubelin-2]==dc)  Tc="U R U' R' Y";
      if(seek[cubelin-2][1][cubelin-1]==dc)  Tc="R U R' Y";
      R_C=concat(R_C,split(Tc,' '));
      SEEK_ROTATE(seek,Tc);
    }    
    return R_C;
  }
  void SEEK_ROTATE(int [][][]seek,String Tc){
    for(String c:split(Tc,' ')){
      int index;
      for(index=0;index<rotate_char.length;index++)  if(rotate_char[index].equals(c)) break;
      if(c.equals("") || c.equals(" ") || index==rotate_char.length){
        println("一致しません  ["+c+"]");
      }
      else{
        int []r=rotate_data[index];
        seek=Rotate(seek,r);
      }
    }    
  }
  int [] Ins(int [][][]seek,int n){
    int []p=new int [3];
    int o=(cubelin-1)/2;
    for(int i=0;i<pow(3,3);i++){
      int []ind={int(i/pow(3,2))-1, int((i%pow(3,2))/pow(3,1))-1,int(i%pow(3,1))-1};
      if(seek[o+ind[0]][o+ind[1]][o+ind[2]]==n){
        p=ind;
        break;
      }
    }
    return p;
  }
  void Draw(int [][][]cube,int []rota){
    push();
    stroke(0,50,50,100);
    strokeWeight(1);
    int b=4;
    for(int i=0;i<pow(cubelin,3);i++){
      int z=int(i/pow(cubelin,2)), y=int((i%pow(cubelin,2))/pow(cubelin,1)),x=int(i%pow(cubelin,1));
      fill(Color[int(constrain(cube[z][y][x],0,9))]);
      z-=2;  y-=2;  x-=2;  
      if(abs(z)<2 && abs(y)<2 && abs(x)<2 )  continue;
      if(abs(z)==2 && abs(y)==2 ||
         abs(y)==2 && abs(x)==2 ||
         abs(x)==2 && abs(z)==2   )  continue;
      float pz=z,py=y,px=x;
      int wz=block_w-b,wy=block_w-b,wx=block_w-b;
      if(abs(z)==2){      wz=8;  pz-=PM(pz)/2;  }
      else if(abs(y)==2){ wy=8;  py-=PM(py)/2;  }
      else {              wx=8;  px-=PM(px)/2;  }
      push();
        if(Move_Rotate){
          int pog=rota[1],rad=rota[2],mov=int(map(frameCount,frame-one_modve_frame*abs(rad),frame,0,87));
          if(pog==0){
            switch(rota[0]){
              case 0:  rotateZ(radians(+rad*mov));  break;
              case 1:  rotateY(radians(-rad*mov));  break;
              case 2:  rotateX(radians(+rad*mov));  break;
            }
          }
          else{
            switch(rota[0]){
              case 0:  if(abs(z)>=abs(pog) && z/pog>=1) rotateZ(radians(pog*rad*mov));  break;
              case 1:  if(abs(y)>=abs(pog) && y/pog>=1) rotateY(radians(pog*rad*mov));  break;
              case 2:  if(abs(x)>=abs(pog) && x/pog>=1) rotateX(radians(pog*rad*mov));  break;
            }
          }
        }
        translate(px*block_w,py*block_w,pz*block_w);
        box(wx,wy,wz);
      pop();
    }
    Draw_Effect(rota);
    pop();
  }
  int [][][]Rotate(int [][][]cube,int []rota){
    int vec=rota[0],hukasa=rota[1],rad=rota[2];
    int [][]sub=new int[cubelin][cubelin];
    int o=(cubelin-1)/2;
    if(hukasa!=0){
      switch(vec){
        case 0:
          for(int s=1;s<=2;s++){
            for(int i=0;i<pow(cubelin,2);i++){
              int y=i/cubelin,x=i%cubelin;
              sub[y][x]=cube[o+hukasa*s][y][x];
            }
            for(int i=0;i<pow(cubelin,2);i++){
              int y=i/cubelin,x=i%cubelin;
              cube[o+hukasa*s][y][x]=sub[o+round(YY(-90*hukasa*rad,x-o,y-o))][o+round(XX(-90*hukasa*rad,x-o,y-o))];
            }
          }
        break;
        case 1:
          for(int s=1;s<=2;s++){
            for(int i=0;i<pow(cubelin,2);i++){
              int y=i/cubelin,x=i%cubelin;
              sub[y][x]=cube[y][o+hukasa*s][x];
            }
            for(int i=0;i<pow(cubelin,2);i++){
              int y=i/cubelin,x=i%cubelin;
              cube[y][o+hukasa*s][x]=sub[o+round(YY(90*hukasa*rad,x-o,y-o))][o+round(XX(90*hukasa*rad,x-o,y-o))];
            }
          }
        break;
        case 2:
          for(int s=1;s<=2;s++){
            for(int i=0;i<pow(cubelin,2);i++){
              int y=i/cubelin,x=i%cubelin;
              sub[y][x]=cube[y][x][o+hukasa*s];
            }
            for(int i=0;i<pow(cubelin,2);i++){
              int y=i/cubelin,x=i%cubelin;
              cube[y][x][o+hukasa*s]=sub[o+round(YY(-90*hukasa*rad,x-o,y-o))][o+round(XX(-90*hukasa*rad,x-o,y-o))];
            }
          }
        break;
      }
    }
    else{
      switch(vec){
        case 0:
          for(int s=0;s<cube.length;s++){
            for(int i=0;i<pow(cubelin,2);i++){
              int y=i/cubelin,x=i%cubelin;
              sub[y][x]=cube[s][y][x];
            }
            for(int i=0;i<pow(cubelin,2);i++){
              int y=i/cubelin,x=i%cubelin;
              cube[s][y][x]=sub[o+round(YY(-90*rad,x-o,y-o))][o+round(XX(-90*rad,x-o,y-o))];
            }
          }
        break;
        case 1:
          for(int s=0;s<cube.length;s++){
            for(int i=0;i<pow(cubelin,2);i++){
              int y=i/cubelin,x=i%cubelin;
              sub[y][x]=cube[y][s][x];
            }
            for(int i=0;i<pow(cubelin,2);i++){
              int y=i/cubelin,x=i%cubelin;
              cube[y][s][x]=sub[o+round(YY(-90*rad,x-o,y-o))][o+round(XX(-90*rad,x-o,y-o))];
            }
          }
        break;
        case 2:
          for(int s=0;s<cube.length;s++){
            for(int i=0;i<pow(cubelin,2);i++){
              int y=i/cubelin,x=i%cubelin;
              sub[y][x]=cube[x][y][s];
            }
            for(int i=0;i<pow(cubelin,2);i++){
              int y=i/cubelin,x=i%cubelin;
              cube[x][y][s]=sub[o+round(YY(90*rad,x-o,y-o))][o+round(XX(90*rad,x-o,y-o))];
            }
          }
        break;
      }
    }
    return cube;
  }

  void numbering(){
    //println("ナンバリング");
    data_Cube=edge_numbering(data_Cube);
    data_Cube=corner_numbering(data_Cube);
  }
  int [][][]corner_numbering(int [][][]cube){
    int Down=cube[(cubelin-1)/2][cubelin-1][(cubelin-1)/2];
    int Top =cube[(cubelin-1)/2][0][(cubelin-1)/2];
    int []Side=new int [4];
    for(int i=0;i<4;i++){ 
      Side[i]=cube[(cubelin-1)/2-round(sin(HALF_PI*(i-1))*(cubelin-1)/2)][(cubelin-1)/2]
                       [(cubelin-1)/2+round(cos(HALF_PI*(i-1))*(cubelin-1)/2)];
    }
    int [][]corner_color_number=new int [8][3];
    for(int i=0;i<4;i++){
      corner_color_number[i][0]=Down;
      corner_color_number[i][1]=Side[i];
      corner_color_number[i][2]=Side[(i+1)%4];
      corner_color_number[i]=sort(corner_color_number[i]);
    }
    for(int i=0;i<4;i++){
      corner_color_number[i+4][0]=Top;
      corner_color_number[i+4][1]=Side[i];
      corner_color_number[i+4][2]=Side[(i+1)%4];
      corner_color_number[i+4]=sort(corner_color_number[i+4]);
    }
    for(int i=0;i<pow(3,3);i++){
      int []ind={int(i/pow(3,2))-1, int((i%pow(3,2))/pow(3,1))-1,int(i%pow(3,1))-1};
      int sum=0;
      for(int s:ind)  if(s==0)  sum++;
      if(sum>0)  continue;
      int []piece_col=new int[3];
      for(int s=0;s<3;s++){
      piece_col[s]=cube[ind[0]*(s==0?2:1)+(cubelin-1)/2][ind[1]*(s==1?2:1)+(cubelin-1)/2][ind[2]*(s==2?2:1)+(cubelin-1)/2];
      }
      piece_col=sort(piece_col);
      for(int s=0;s<corner_color_number.length;s++){
        if(corner_color_number[s][0]==piece_col[0] && corner_color_number[s][1]==piece_col[1] && corner_color_number[s][2]==piece_col[2]){
          cube[ind[0]+(cubelin-1)/2][ind[1]+(cubelin-1)/2][ind[2]+(cubelin-1)/2]=s+30;
          break;
        }
      }
    }
    return cube;
  }
  int [][][] edge_numbering(int [][][]cube){
    int Down=cube[(cubelin-1)/2][cubelin-1][(cubelin-1)/2];
    int Top =cube[(cubelin-1)/2][0][(cubelin-1)/2];
    int []Side=new int [4];
    for(int i=0;i<4;i++){ 
      Side[i]=cube[(cubelin-1)/2-round(sin(HALF_PI*(i-1))*(cubelin-1)/2)][(cubelin-1)/2]
                       [(cubelin-1)/2+round(cos(HALF_PI*(i-1))*(cubelin-1)/2)];
    }
    int [][]edge_color_number=new int [12][2];
    for(int i=0;i<4;i++){
      edge_color_number[i][0]=Down;
      edge_color_number[i][1]=Side[i];
    }
    for(int i=0;i<4;i++){
      edge_color_number[i+4][0]=Side[i];
      edge_color_number[i+4][1]=Side[(i+1)%4];
    }
    for(int i=0;i<4;i++){
      edge_color_number[i+8][0]=Top;
      edge_color_number[i+8][1]=Side[i];
    }
    for(int i=0;i<edge_color_number.length;i++)  edge_color_number[i]=sort(edge_color_number[i]);
    for(int i=0;i<pow(3,3);i++){
      int []ind={int(i/pow(3,2))-1, int((i%pow(3,2))/pow(3,1))-1,int(i%pow(3,1))-1};
      int sum=0;
      for(int s:ind)  if(s==0)  sum++;
      if(sum>=2 || sum==0)  continue;
      for(int s=0;s<ind.length;s++)  if(ind[s]==0)  sum=s;
      int []piece_col=new int[2];
      sum=(sum+1)%3;
      piece_col[0]=cube[ind[0]*(sum==0?2:1)+(cubelin-1)/2][ind[1]*(sum==1?2:1)+(cubelin-1)/2][ind[2]*(sum==2?2:1)+(cubelin-1)/2];
      sum=(sum+1)%3;
      piece_col[1]=cube[ind[0]*(sum==0?2:1)+(cubelin-1)/2][ind[1]*(sum==1?2:1)+(cubelin-1)/2][ind[2]*(sum==2?2:1)+(cubelin-1)/2];
      piece_col=sort(piece_col);
      for(int s=0;s<edge_color_number.length;s++){
        if(edge_color_number[s][0]==piece_col[0] && edge_color_number[s][1]==piece_col[1]){
          cube[ind[0]+(cubelin-1)/2][ind[1]+(cubelin-1)/2][ind[2]+(cubelin-1)/2]=s+10;
          break;
        }
      }
    }
    return cube;
  }
  void Move(int []_r){
    if(Move_Rotate==true)  return;
    rotat=_r;
    Move_Rotate=true;
    frame=one_modve_frame*abs(_r[2])+frameCount;
  }
  void Re_Write(){
    if(Move_Rotate==true && frame<frameCount){
      Move_Rotate=false;
      data_Cube=Rotate(data_Cube,rotat);
    }
  }
  void keyP(char c){
    int n;
    for(n=0;n<ro_ke.length;n++)  if(str(ro_ke[n]).equals(str(c).toUpperCase())) break;
    if(n==ro_ke.length)  return;
    if(Move_Rotate==true)  return;
    String co=str(ro_ke[n]).toUpperCase();
    if(Button_Control>frameCount)  co=co+"2";
    else if(Button_Shift>frameCount)  co=co+"'";
    println(co);
    for(n=0;n<rotate_char.length;n++)  if(rotate_char[n].equals(co)) break;
    int []r=rotate_data[n];
    Move(r);
  }
  void tank_rotate(){
    if(Move_Rotate==true)  return;
    if(tank_ro.length==0) return;
    String c=tank_ro[0];
    int n;
    for(n=0;n<rotate_char.length;n++)  if(rotate_char[n].equals(c)) break;
    if(n==rotate_char.length)  println("一致しません ["+c+"]");
    else {
      int []r=rotate_data[n];
      Move(r);
    }
    tank_ro=subset(tank_ro,1);
  }
  void data_Cube_Set(int []data){
    for(int i=0;i<data.length;i++){
      int y=i/3,x=i%3;
      data_Cube[cubelin-1][y+1][x+1]=data[i];
    }
  }
  void color_data_set(int [][]nd){
    for(int i=0;i<pow(nd.length,2);i++){
      int y=i/nd.length,x=i%nd.length;
      data_Cube[data_Cube.length-1][y+1][x+1]=nd[y][x];
    }
  }
}
