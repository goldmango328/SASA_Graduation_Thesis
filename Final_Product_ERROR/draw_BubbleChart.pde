// 해당 국가에서 발생한 구체적인 사건들에 대한 조사를 우선으로 하고 싶어하기 때문에~
// ex : country[4] :: Japan
// 일단은 sub graph1의 test용으로 
// 세로축  = 죽은 사람 가로축 = 피해정도 반지름 = 지진의 강도
// 아래에 모든 자료에 대한 정보를 보여줄 수 있도록(표로 제공) -> maybe subgraph2
float[] getMinMax(Table data, String categ){
  float MIN = 90000000;
  float MAX = 0;
  
  for(TableRow row: data.rows()){
    if(row.getInt(categ) > MAX){
      MAX = row.getInt(categ);
    }
    if(row.getInt(categ) < MIN){
      MIN = row.getInt(categ);
    }
  }
  
  float[] min_max = {MIN,MAX};
  return min_max;
}

void draw_BubbleChart(Table data, float x1,float y1,float x2,float y2){ 
  println(data.getRowCount());
  for(int i=0 ; i<data.getRowCount() ; i++){
    TableRow row = data.getRow(i);
    int year = row.getInt("year");
    int month = row.getInt("month");
    int day = row.getInt("day");
    int hour = row.getInt("hour");
    int minute = row.getInt("minute");
    int second = row.getInt("second");
    
    float radius = row.getFloat("EQ_primary");
    float data1 = row.getFloat("injuries");
    float data2 = row.getFloat("damage_millions_dollars");
    
    float[] radius_MINMAX = getMinMax(data,"EQ_primary");
    float[] data1_MINMAX = getMinMax(data,"injuries");
    float[] data2_MINMAX = getMinMax(data,"damage_millions_dollars");
    
    float x = map(data1, data1_MINMAX[0], data1_MINMAX[1], x1+10,x2-10);
    float y = map(data2, data2_MINMAX[0], data2_MINMAX[1], y1+10,y2-10);
    float rad = map(radius, radius_MINMAX[0], radius_MINMAX[1], 10,40);
    //println(str(year)+":"+str(month)+":"+str(day)+" |"+str(radius)+" "+str(rad)+" |"+str(data1)+" "+str(x)+" |"+str(data2)+" "+str(y));
    println(data1_MINMAX[0], data1_MINMAX[1]," ",data2_MINMAX[0],data2_MINMAX[1]);
    fill(BOX_color,50);
    ellipse(x,y,rad,rad);
  }
}
