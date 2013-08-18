import 'dart:html';
import 'dart:math';

num height;
num width;
CanvasElement canvas = query('#conway');
CanvasRenderingContext2D ctx = canvas.context2d;

List conwayData;

void main() {
  width = canvas.width;
  height = canvas.height;
  
  conwayData = new List(height);

  var r = new Random(), i, j;

  for(i = 0; i < height; i++){
    conwayData[i] = new List(width);

    for(j = 0; j < width; j++){
      if(r.nextInt(15) == 0){
        conwayData[i][j] = 1;
      } else {
        conwayData[i][j] = 0;
      }
    }
  }

  draw();
  
  window.requestAnimationFrame(loop);
}

void loop(num timer){
  conway();
  draw();
  
  window.requestAnimationFrame(loop);
}

num numberofNeighbours(num y, num x){
  num n = 0;
  
  if(y > 0 && x > 0 && conwayData[y - 1][x - 1] == 1){
    n += 1;
  }
  
  if(y > 0 && conwayData[y - 1][x] == 1){
    n += 1;
  }
  
  if(y > 0 && x < (width - 1) && conwayData[y - 1][x + 1] == 1){
    n += 1;
  }
  
  if(x < (width - 1) && conwayData[y][x + 1] == 1){
    n += 1;
  }
  
  if(x < (width - 1) && y < (height - 1) && conwayData[y + 1][x + 1] == 1){
    n += 1;
  }
  
  if(y < (height - 1) && conwayData[y + 1][x] == 1){
    n += 1;
  }
  
  if(y < (height - 1) && x > 0 && conwayData[y + 1][x - 1] == 1){
    n += 1;
  }
  
  if(x > 0 && conwayData[y][x - 1] == 1){
    n += 1;
  }
  
  return n;
}

void conway(){
  var t, i, j;
  
  for(i = 0; i < height; i++){
    for(j = 0; j < width; j++){
      t = numberofNeighbours(i, j);
      
      if(conwayData[i][j] == 1 && t != 2 && t != 3){
        conwayData[i][j] = 0;
      } else if(conwayData[i][j] == 0 && t == 3){
        conwayData[i][j] = 1;
      }
    }
  }
}

void draw(){
  var black = "#000000";
  var white = "#FFFFFF";

  for(var i = 0; i < height; i++){
    for(var j = 0; j < width; j++){
      if(conwayData[i][j] == 0){
        ctx.fillStyle = white;
      } else {
        ctx.fillStyle = black;
      }
      
      ctx.fillRect(i, j, 1, 1);
    }
  }
}


