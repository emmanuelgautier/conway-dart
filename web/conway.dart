import 'dart:html';
import 'dart:math';

final String black = "#000000";
final String white = "#FFFFFF";
final String blue = "#0000FF";

final CanvasElement canvas = query('#conway');
final CanvasRenderingContext2D ctx = canvas.context2d;

num state;

num canvas_height;
num canvas_width;
num height;
num width;
num size_pixel;

List conwayData;

void main() {
  var container = query(".container"),

      choice_two = query("#two"),
      choice_three = query("#three");

  canvas.height = (window.screen.available.height - window.screen.available.height / 5).toInt();
  canvas.width = canvas.height;

  canvas_width = canvas.width;
  canvas_height = canvas.height;

  height = 150;
  width = 150;

  size_pixel = canvas_height / height;

  conwayData = new List(height);

  var r = new Random(), i, j;

  for(i = 0; i < height; i++){
    conwayData[i] = new List(width);

    for(j = 0; j < width; j++){
      if(r.nextInt(20) == 0){
        conwayData[i][j] = 1;
      } else {
        conwayData[i][j] = 0;
      }
    }
  }

  state = 2;

  choice_two.onClick.listen((MouseEvent me){
    state = 2;
  });

  choice_three.onClick.listen((MouseEvent me){
    state = 3;
  });

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

  if(y > 0 && x > 0 && conwayData[y - 1][x - 1] != 0){
    n += 1;
  }

  if(y > 0 && conwayData[y - 1][x] != 0){
    n += 1;
  }

  if(y > 0 && x < (width - 1) && conwayData[y - 1][x + 1] != 0){
    n += 1;
  }

  if(x < (width - 1) && conwayData[y][x + 1] != 0){
    n += 1;
  }

  if(x < (width - 1) && y < (height - 1) && conwayData[y + 1][x + 1] != 0){
    n += 1;
  }

  if(y < (height - 1) && conwayData[y + 1][x] != 0){
    n += 1;
  }

  if(y < (height - 1) && x > 0 && conwayData[y + 1][x - 1] != 0){
    n += 1;
  }

  if(x > 0 && conwayData[y][x - 1] != 0){
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
        if(state == 2){
          conwayData[i][j] = 1;
        } else {
          conwayData[i][j] = 2; 
        }
      } else if(conwayData[i][j] == 2){
        conwayData[i][j] = 1;
      }
    }
  }
}

void draw(){
  for(var i = 0; i < height; i++){
    for(var j = 0; j < width; j++){
      ctx.fillStyle = ((conwayData[i][j] == 0) ? white : (conwayData[i][j] == 1 ? black : blue));

      ctx.fillRect(i * size_pixel, j * size_pixel, size_pixel, size_pixel);
    }
  }
}