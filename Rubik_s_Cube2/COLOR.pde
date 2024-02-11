color []Color={
//  赤      青   オレンジ    緑       黄     白      黒      紫   黒ピンク　汚いミント      
#ff0000,#0244ff,#E86900,#2CB400,#D4D800,#cccccc,#2C2C2C,#720E9D,#A27D88,#3D9B7E
};
class COLOR{
  color col;
  int r,g,b;
  int H,S,B;
  COLOR(color _col){
    col=_col;
    r=int(red(col));
    g=int(green(col));
    b=int(blue(col));
    H=int(hue(col));
    S=int(saturation(col));
    B=int(brightness(col));
  }
}
