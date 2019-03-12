// 세계지도 관련된 function 정리
float mapGeoLeft = -165.00; 
float mapGeoRight = 173.00;
float mapGeoTop = 115.00;
float mapGeoBottom = -90.00;
float mapScreenWidth, mapScreenHeight;
float bubble_radius = 2.5;

void draw_worldmap(){
  int box_height = 360;
  int box_width = 470;
  
  mapScreenHeight = box_height;
  mapScreenWidth = box_width;
  
  /*
  rectMode(CORNERS);
  fill(255,40);
  rect(main_section[0][0],main_section[0][1],main_section[0][0]+box_width,main_section[0][1]+box_height);
  
  fill(255);
  textAlign(CENTER,CENTER);
  textSize(36);
  text("World Map",(2*main_section[0][0]+box_width)/2,(2*main_section[0][1]+box_height)/2);
  */
  
  control_year();
  control_type();
  show_specific();
  
  // grid_worldmap(main_section[0][0]+box_width+grid_gap*2, main_section[0][1]);
  WorldMap.resize(int(mapScreenWidth), int(mapScreenHeight));
  
  image(WorldMap, main_section[0][0],main_section[0][1]);
  mapScreenHeight = main_section[0][1]+box_height;
  mapScreenWidth = main_section[0][0]+box_width;
  
  fill(#17EEFF);
  noStroke(); // strokeWeight(30); 주변에 검은색 테두리를 만들어줄 수 있음
  PVector p = geoToPixel(new PVector(-0.8,51.5)); // London
  ellipse(p.x,p.y,5,5);
  
  fill(255,255,255);
  for(TableRow NameRow : CountryName.rows()){
    String name = NameRow.getString(1);
    for(TableRow CoordRow : CountryCoord.rows()){
      String find_name = CoordRow.getString("name");
      if(find_name.toUpperCase().equals(name) == true){
        float latitude = CoordRow.getFloat(1);
        float longtitude = CoordRow.getFloat(2);
        // println(name);
        // println(longtitude,latitude);
    
        PVector pp = geoToPixel(new PVector(longtitude,latitude));
        ellipse(pp.x,pp.y,bubble_radius,bubble_radius);
        //textSize(10);
        //text(name,pp.x+3,pp.y-3);
        break;
      }
    }
  }
}

void control_year(){
  int box_height = 300;
  int box_width = 470;
  
  tabbox_top = (main_section[1][1] + box_height/2);
  tabbox_bottom = (main_section[1][1] +box_height/2)+30;
  tabbox_width = 60;
  tabbox_height = tabbox_bottom - tabbox_top;
  
  tabboxLeft[0] = main_section[1][0] + grid_gap*2;
  tabboxRight[0] = tabboxLeft[0] + tabbox_width;
  texttabboxLeft[0] = tabboxRight[0];
  texttabboxRight[0] = texttabboxLeft[0] + tabbox_width*2;
  
  textAlign(LEFT,BOTTOM);
  textFont(title_font);
  textSize(23);
  text("Choose Year",40,tabbox_top-grid_gap);
  
  // Horizontal 
  /*
  tabboxLeft[1] = texttabboxRight[0] + 40;
  tabboxRight[1] = tabboxLeft[1] + tabbox_width;
  texttabboxLeft[1] = tabboxRight[1];
  texttabboxRight[1] = texttabboxLeft[0] + tabbox_width;
  */
  
  // Vertical
  tabboxLeft[1] = tabboxLeft[0];
  tabboxRight[1] = tabboxRight[0];
  texttabboxLeft[1] = texttabboxLeft[0];
  texttabboxRight[1] = texttabboxRight[0];
  
  noStroke();
  fill(TAB_color);
  rectMode(CORNERS);
  rect(tabboxLeft[0],tabbox_top,tabboxRight[0],tabbox_bottom);
  rect(tabboxLeft[1],tabbox_top+tabbox_height+10,tabboxRight[1],tabbox_bottom+tabbox_height+10);
  
  fill(255,80);
  rect(texttabboxLeft[0],tabbox_top,texttabboxRight[0],tabbox_bottom);
  rect(texttabboxLeft[1],tabbox_top+tabbox_height+10,texttabboxRight[1],tabbox_bottom+tabbox_height+10);
  
  fill(255);
  textAlign(CENTER,CENTER);
  textFont(tab_font);
  textSize(12);
  text("START", (tabboxLeft[0]+tabboxRight[0])/2,tabbox_top+tabbox_height/2);
  text("END",(tabboxLeft[1]+tabboxRight[1])/2,tabbox_top+tabbox_height/2+tabbox_height+10);
  textSize(14);
  text(str(start_year),(texttabboxLeft[0]+texttabboxRight[0])/2,tabbox_top+tabbox_height/2);
  text(str(end_year),(texttabboxLeft[1]+texttabboxRight[1])/2,tabbox_top+tabbox_height/2+tabbox_height+10);
  /*
  rectMode(CORNERS);
  fill(255,40);
  rect(main_section[1][0],main_section[1][1],main_section[1][0]+box_width,main_section[1][1]+box_height);
  
  textAlign(CENTER,CENTER);
  textSize(36);
  fill(255);
  text("World Map Control",(2*main_section[1][0]+box_width)/2,(2*main_section[1][1]+box_height)/2);
  */
}

// 막대그래프로 보여주는 속성을 조절하는 함수
void control_type(){  
  typeboxTop[0] = 510;  typeboxBottom[0] = typeboxTop[0]+typebox_height;
  typeboxTop[1] = typeboxBottom[0]+grid_gap; typeboxBottom[1] = typeboxTop[1]+typebox_height;
  
  typeboxLeft[0] = 40;  typeboxRight[2] = 480;
  typebox_width = (typeboxRight[2]-typeboxLeft[0]-grid_gap*2)/3;
  
  typeboxRight[0] = typeboxLeft[0]+typebox_width;
  typeboxLeft[1] = typeboxRight[0]+grid_gap;  typeboxRight[1] = typeboxLeft[1]+typebox_width;
  typeboxLeft[2] = typeboxRight[1]+grid_gap;
  
  textAlign(LEFT,BOTTOM);
  textFont(title_font);
  textSize(23);
  text("Choose Type",typeboxLeft[0],typeboxTop[0]-grid_gap);
  text("ver."+selectedType, typeboxLeft[0]+textWidth("Choose Type")+grid_gap*2, typeboxTop[0]-grid_gap);
  text(longName[selectedType].toLowerCase(), typeboxLeft[0]+textWidth("Choose Type ver.0")+grid_gap*2, typeboxTop[0]-grid_gap);
  
  // Use ColumnName
  // 첫째줄에 3개 
  // rect(40,510,480,510+typebox_height);
  fill(255,0,0);
  
  for(int j=0 ; j<2 ; j++){
    for(int i=0 ; i<typeboxNum ; i++){
      fill(255,80);
      rect(typeboxLeft[i],typeboxTop[j],typeboxRight[i],typeboxBottom[j]);
      fill(BOX_color);
      rect(typeboxLeft[i],typeboxTop[j],typeboxLeft[i]+typebox_height,typeboxBottom[j]);
      
      fill(255);
      textAlign(CENTER,CENTER);
      textFont(tab_font);
      textSize(12);
      text(columnName[j*3+i], (typeboxLeft[i]+typeboxRight[i]+typebox_height)/2,(typeboxTop[j]+typeboxBottom[j])/2);   
    }
  }
  
  // 둘째줄에 3개
  // rect(40,510+typebox_height+grid_gap,480,510+grid_gap+typebox_height*2);
  /*
  for(int i=0 ; i<typeboxNum ; i++){
    fill(255,80);
    rect(typeboxLeft[i],typeboxTop[1],typeboxRight[i],typeboxBottom[1]);
    fill(BOX_color);
    rect(typeboxLeft[i],typeboxTop[1],typeboxLeft[i]+typebox_height,typeboxBottom[1]);
  }
  */
}

/*
void grid_worldmap(int x, int y){
  stroke(255);
  strokeWeight(2);
  line(x,y,x,height-grid_gap);
}
*/

// show_specific :: max value에 대해서 포함하고 있는 국가가 어떻게 되는지?
void show_specific(){
  Table angleCountry = new Table();
  int box_height = 130;
  int box_width = 240;
  int angleNum = 10;
  
  float[] angles = new float[angleNum];
  float centerX,centerY;
  
  angleCountry.addColumn("country");
  angleCountry.addColumn("value",Table.INT); // selectedType의 value를 합쳐주면 됨
  
  textAlign(LEFT,BOTTOM);
  textFont(title_font);
  textSize(23);
  text("Show Specific About Max",240,tabbox_top-grid_gap);
  
  strokeWeight(1);
  stroke(255);
  fill(255,10);
  // 전체 윤곽에 대해서 rect(240,tabbox_top, 240+box_width, tabbox_top+box_height);
  
  fill(255,10);
  rect(240+box_height+grid_gap,tabbox_top,240+box_width,tabbox_top+box_height);
  ellipseMode(CORNER);
  ellipse(240,tabbox_top,box_height,box_height);
  
  centerX = (240+box_height/2);
  centerY = (tabbox_top+box_height/2);
  point(centerX, centerY);
  
  for(TableRow row : NOAA_year[maxYear-2000].rows()){
    int month = row.getInt("month");
    String country = row.getString("country");
    
    if(month == maxMonth){ // maxMonth인 경우에~
      boolean flag = false;
      for(TableRow angleRow : angleCountry.rows()){
        if((angleRow.getString("country")).equals(country) == true){
          flag = true;
          angleRow.setInt("value",angleRow.getInt("value")+row.getInt("
        }
      }
    }
  }
}

public PVector geoToPixel(PVector geoLocation)
{
    return new PVector(mapScreenWidth*(geoLocation.x-mapGeoLeft)/(mapGeoRight-mapGeoLeft),
                       mapScreenHeight - mapScreenHeight*(geoLocation.y-mapGeoBottom)/(mapGeoTop-mapGeoBottom));
}
