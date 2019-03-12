// 만일 한 해 동안의 누적 사건 발생량 == 0 이라면 No Data를 출력하게끔(프로그램의 작동을 원활히 하기 위해서)

float yInterval = 50000; // grid Interval 에 대한 조건도 column마다 다르게 설정해줘야 함
float barWidth = 3; 

Float[] getMinMax(Table data){
  float MINy = 2000000;
  float MAXy = 0;
  float MINx = 2000000;
  float MAXx = 0;
  
  int origin_s = 2000;
  int origin_e = 2017;
  
  // find MINy, MAXy
  for(TableRow row : data.rows()){
    if(row.getInt(columnName[selectedType]) > MAXy){
      MAXy = row.getInt(columnName[selectedType]);
    }
    if(row.getInt(columnName[selectedType]) < MINy){
      MINy = row.getInt(columnName[selectedType]);
    }
  }
  
  // find MINx, MAXx
  for(TableRow row : data.rows()){
    int year = row.getInt("year");
    int month = row.getInt("month");
    int time = (year-2000)*12 + month;
    if(time > MAXx){
      MAXx = time;
    }
    if(time < MINx){
      MINx = time;
    }
  }
  
  if(selectedType >= 4){
    yInterval = 500000;
  }else{
    yInterval = 50000;
  }
  if(MAXy < yInterval && (origin_s != start_year || origin_e != end_year)){
    yInterval = (MAXy-MINy)/4-((MAXy-MINy)/4)%1000;
    origin_s = start_year;
    origin_e = end_year;
  }
  // println("MINy:"+str(MINy)+" MAXy:"+str(MAXy)+"|yInterval:"+str(yInterval));
  Float[] min_max = {MINy,MAXy,MINx,MAXx};
  return min_max;
}

void draw_VerticalGridLines(Float[] min_max, float x1,float y1,float x2,float y2){
  int gap = 20; // box_gap 에 맞출 수 있도록 변경해야 함
  
  stroke(GRID_color,120);
  strokeWeight(1);
  
  for(float y = min_max[0] ; y <= min_max[1] ; y++){
    if(y % yInterval == 0 && y!=min_max[0]){
      float val = map(y,min_max[1],min_max[0],y1+gap,y2);
      // grid text
      textFont(tab_font);
      textSize(15);
      fill(GRID_color);
      textAlign(RIGHT,CENTER);
      text((int)y, x2, val);
      // grid line
      line(x1,val,x2-textWidth(str(y)),val);
    }
  } 
}

void draw_VerticalBarChart(Table data, float x1,float y1,float x2,float y2){
  noStroke();
  int gap = 20;
  
  Float[] min_max = getMinMax(data);
  
  draw_VerticalGridLines(min_max,x1,y1,x2,y2);
  
  for(TableRow row : data.rows()){
    int time = (row.getInt("year")-2000)*12 + row.getInt("month");
    int val = row.getInt(columnName[selectedType]);
    
    // MAX DATA를 잡아내는 과정
    if(val == min_max[1]){
      maxYear = row.getInt("year");
      maxMonth = row.getInt("month");
      maxTime = str(maxYear)+"."+str(maxMonth)+". "+longName[selectedType].toLowerCase()+"("+columnName[selectedType]+") : "+str(val);
    }
    float x = map(time,min_max[2],min_max[3],x1+50,x2-50); // min_max[2] : minX, min_max[3] : maxX
    float y = map(val,min_max[1],min_max[0],y1+gap,y2); //min_max[0] : minY, min_max[1] : maxY 
    textFont(tab_font);
    textSize(10);
    fill(val == min_max[1] ? TAB_color : BOX_color);
    rect(x-barWidth/2,y,x+barWidth/2,y2);
    textAlign(CENTER);
    if(val >= min_max[0]+yInterval/2 && val!=0){
       text(val, x,y-10);
    }
  }
}

void drawLabelTitle(float x, float y,String title){
  fill(0);
  textSize(20);
  textFont(title_font);
  textAlign(LEFT,CORNER);
  text(title,x,y+40);
}

/*
void draw_HorizontalGridLines(Float[] min_max, float x1,float y1,float x2,float y2){
  int gap = 10;
  int yInterval = 10;
  
  stroke(GRID_color);
  strokeWeight(1);
  
  for(float y = min_max[0] ; y <= min_max[1] ; y++){
    if(y % yInterval == 0){
      float val = map(y,min_max[0],min_max[1],x1+gap,x2-gap);
      // grid text
      textSize(8);
      textFont(tab_font);
      fill(GRID_color);
      textAlign(CENTER);
      text((int)y, val, y2+10);
      
      // grid line
      line(val,y1,val,y2-10);
    }
  } 
}

void draw_HorizontalBarChart(Table data,float x1,float y1,float x2, float y2){
  noStroke();
  rectMode(CORNERS);
  fill(BOX_color);
  int gap = 20;
  int barWidth = 30;
  float cnt = 1;
  data.sort(1);
  
  // 정렬해서 가장 큰 게 위로 오도록 만들어야 함
  for(TableRow row : data.rows()){
    int val = row.getInt(1);
    print("val:"+val+"\n");
    float x = map(val,MINy,MAXy,x1+gap,x2-gap);
    float y = map(cnt,MAXx,MINx,y1+gap,y2-gap); // X,Y 좌표를 다루는 것에 유의! 특히 y mapping 중요
    rect(x1,y-barWidth/2,x,y+barWidth/2);
    cnt++;
    
    textSize(15);
    fill(BOX_color);
    textAlign(LEFT, CENTER);
    text(val, x+10,y);
  }
}
*/
