Boolean T=true;
class CAMERA{
  int color_count=60;
  int block_w=75;
  int []block_color={6,6,6,6,6,6,6,6,6}; 
  int men_cent=0;
  int []_Color_Index={//1                   2                   3                   4                   5                   
  //0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,
    7,0,0,2,2,2,2,2,7,0,0,0,7,4,4,4,4,4,7,7,7,7,7,3,3,3,3,3,3,3,3,3,7,7,7,7,7,7,7,7,7,7,1,1,1,1,1,7,7,7,7,7,7,7,7,7,7,7,7,7
  };
  int  Color_Load_ON=0;
  COLOR c;
  CAMERA(){
  }
  int []Camera_Block_Color_Get(){
    int []block_data=new int[9]; 
    int cx=pi.width/2,cy=pi.height/2;
    if(!T)  {      T=!T;      pi.save("pic/save.png");    }
    Color_Load_ON=0;
    PImage []block_pic=new PImage[9];
    for(int i=0;i<9;i++){
      int x=i%3-1,y=i/3-1,b=20;
      block_pic[i]=pi.get(int(cx+(x-0.5)*block_w+b),int(cy+(y-0.5)*block_w+b),block_w-b*2,block_w-b*2);
      int []rgb_data=INS1(block_pic[i]);
      PRINT_data(i,rgb_data);
      block_data[i]=INS2(rgb_data);
      block_data[i]=INS3(rgb_data,block_data[i]);
      //block_pic[i].save("pic/"+frameCount+"/"+i+".png");
    }
    return block_data;
  }
  void PRINT_data(int s,int []rgb_data){
    println("\n "+s+" \n");
    for(int i=0;i<rgb_data.length;i++){
      print(i+":"+rgb_data[i]+" ");
      if((i+1)%20==0)  println();
    }
  }
  void Draw_Camera(){
    float d_block_w=80;
    //if(pi.available() == true){      pi.read();    }
    PImage P=pi;//.get(cx-block_w*2,cy-block_w*2,block_w*4,block_w*4)
    float cx=P.width/2*(d_block_w/block_w),cy=height-P.height/2*(d_block_w/block_w);
    push();
      imageMode(CENTER);
      image(P,cx,cy,P.width*(d_block_w/block_w),P.height*(d_block_w/block_w));
    pop();
    push();
      int b=15,r=10;
      noFill();
      stroke(0,20,70,150);
      strokeWeight(2);
      rectMode(CENTER);
      rect(cx,cy,d_block_w*3,d_block_w*3,r);
      for(int i=0;i<9;i++){
        int x=i%3-1,y=i/3-1;
        rect(x*d_block_w+cx,y*d_block_w+cy,d_block_w-2*b,d_block_w-2*b,r);
      }
    pop();
  }
  int [] Color_Load(){
   int []d={};
    Boolean print=true;
    if(Color_Load_ON<frameCount)  return d;
    block_color=Camera_Block_Color_Get();
    //for(int b:block_color)print(b+" ");
    if(men_cent>5)  return d;
    if(block_color[4]==men_cent){
      for(int i=0;i<9;i++){
        if(block_color[i]>5){
          if(print)println("正常に認識できていません\n　焦点を調節して見てくだしい");                             
          return d;
        }
      }
      men_cent++;
      println("正常に認識しました");
      if(print || true){
        for(int i=0;i<block_color.length;i++){
          print(block_color[i]+" ");
          if((i+1)%9==0)  println();
          if((i+1)%3==0)  println();   
        }
      }
      return block_color;
    }
    else{ 
      if(print) println("色が一致しませんでした");    
      return d;
    }     
  }
  
  
  int []INS1(PImage pic){
    int []rgb_data=SET_COLOR(color_count);
    for(int y=0;y<pic.height;y++){
      for(int x=0;x<pic.width;x++){
        color col=pic.get(x,y);
        COLOR c=new COLOR (col);
        int rgb=((c.H+360/(rgb_data.length))/(360/rgb_data.length))%rgb_data.length;
        rgb_data[rgb]++;
        rgb_data[color_count]+=c.S;
        rgb_data[color_count+1]+=c.B;
      }
    }
    rgb_data[  color_count]/=pic.width*pic.height;
    rgb_data[color_count+1]/=pic.width*pic.height;
    return rgb_data;
  }
  int INS2(int []rgb_data){
    int mc=0,mi=0,index=5;
    for(int i=0;i<color_count;i++)if(mc<rgb_data[i])mc=rgb_data[i];
    for(int i=0;i<color_count;i++) if(rgb_data[i]==mc)  mi=i;
    index=mi;
    return index;
  }
  int INS3(int []rgb_data,int index){
    int n=0;
    if(rgb_data[color_count]<20 && rgb_data[color_count+1]>60)   n=5; 
    else if(rgb_data[color_count]<10 || rgb_data[color_count+1]<40)  n=6;  
    else  n=_Color_Index[index];
    return n;
  }
  int []SET_COLOR(int sum){
    int []d=new int [sum+2];
    for(int i=0;i<d.length;i++)  d[i]=0;
    return d;
  }  
  void Draw_In_Block(){
    int []data=block_color;
    int d_block_w=80;
    float p_x=width-d_block_w*1.5,p_y=height-d_block_w*1.5;
    int b=2;
    push();
    strokeJoin(BEVEL);
    strokeWeight(2);
    stroke(-1,200);
    rectMode(CENTER);
    fill(#251D4D);
    rect(p_x,p_y,d_block_w*3-6,d_block_w*3-6,10);
    for(int i=0;i<9;i++){
      int x=i%3-1,y=i/3-1,r=10;
      fill(Color[data[i]]);
      if(x==0 && y==0)  r=35;
      rect(x*d_block_w+p_x,y*d_block_w+p_y,d_block_w-b,d_block_w-b,r);
    }
    pop();
  }
  void Draw_Sub(){
    int [][]yaji={{ 132,0 },{ 0, -133 },{ 0, -62 },{ -162, -60 },{ -162, 60},{ 0, 62 },{ 0, 133 },{-100,0}};
    int p_x=width/2,p_y=height-50;
    push();
      translate(p_x,p_y);
      fill(#61E6FC);
      strokeWeight(3);
      stroke(#FFD500,200);
      beginShape();
      for(int i=0;yaji[i][0]!=-100;i++)  vertex(yaji[i][0]*0.2,yaji[i][1]*0.2);
      endShape(CLOSE);
    pop();
    push();
      fill(#61E6FC);
      strokeWeight(3);
      stroke(#FFD500,200);
      rectMode(CORNER);
    pop();
  }
}
