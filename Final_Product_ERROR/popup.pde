// 해당 지진이 발생한 국가에 대한 정보를 얻고 싶을때 클릭하는 팝업창
String[] title = new String[2];
  
void draw_popupButtons(){  
  title[0] = "More About Country";
  title[1] = "More About Earthquake";
  
  rectMode(CORNERS);
  noStroke();
  textSize(20);
  textAlign(LEFT,BOTTOM);
  
  for(int i=0 ; i<1 ; i++){
    fill( i == 1? TAB_color : 255);
    rect(popupboxLeft,popupboxTop[i],popupboxRight,popupboxBottom[i]);
    text(title[i], popupboxLeft,popupboxTop[i]);
  }
  fill(255);
  stroke(255);
}

// when showing country is selected -> Ranking에서 국가의 순위를 보여주고, 국가와 관련된 정보를 보여줌
void popup1(){
  int box_height = height-main_section[2][1]-40;
  int box_width = width-main_section[2][0]-30;
  
  fill(0,200);
  noStroke();
  rect(main_section[2][0], main_section[2][1], main_section[2][0]+box_width , main_section[2][1]+box_height);
  
  fill(255);
  textFont(title_font);
  textSize(36);
  textAlign(LEFT,BOTTOM);
  text(title[0],main_section[2][0], main_section[2][1]+50);
  stroke(255);
  line(main_section[2][0],main_section[2][1]+55,main_section[2][0]+box_width,main_section[2][1]+55);
  
  // 1) 해당 국가의 정보를 보여줌 -> 시연하는 경우에는 일본의 예시만 보여주자
  if(detail_code.equals("PE")==true){
    image(pe_map, main_section[2][0]+30,main_section[2][1]+75);
    
    textSize(20);
    text("NAME | PERU", main_section[2][0]+pe_map.width+grid_gap*5,main_section[2][1]+grid_gap*10);
    text("POPULATION | 31,151,643", main_section[2][0]+pe_map.width+grid_gap*5,main_section[2][1]+grid_gap*14);
    text("AREA | 1,285,216 km^2", main_section[2][0]+pe_map.width+grid_gap*5,main_section[2][1]+grid_gap*18);
    text("GDP(TOTAL) | 229,648,000,000 $",main_section[2][0]+pe_map.width+grid_gap*5,main_section[2][1]+grid_gap*22);
    
    fill(TAB_color);
    noStroke();
    textSize(15);
    textAlign(LEFT,TOP);
    rect(main_section[2][0], main_section[2][1]+pe_map.height+grid_gap*26,main_section[2][0]+200,main_section[2][1]+pe_map.height+grid_gap*29);
    rect(main_section[2][0]+220, main_section[2][1]+pe_map.height+grid_gap*26,main_section[2][0]+420,main_section[2][1]+pe_map.height+grid_gap*29);
    rect(main_section[2][0]+440, main_section[2][1]+pe_map.height+grid_gap*26,main_section[2][0]+640,main_section[2][1]+pe_map.height+grid_gap*29);
    rect(main_section[2][0], main_section[2][1]+pe_map.height+grid_gap*30,main_section[2][0]+200,main_section[2][1]+pe_map.height+grid_gap*33);
    rect(main_section[2][0]+220, main_section[2][1]+pe_map.height+grid_gap*30,main_section[2][0]+420,main_section[2][1]+pe_map.height+grid_gap*33);
    rect(main_section[2][0]+440, main_section[2][1]+pe_map.height+grid_gap*30,main_section[2][0]+640,main_section[2][1]+pe_map.height+grid_gap*33);
    fill(255);
    text("DH : 16(618)",main_section[2][0]+grid_gap,main_section[2][1]+pe_map.height+grid_gap*27);
    text("MS : 4 (68)",main_section[2][0]+230, main_section[2][1]+pe_map.height+grid_gap*27);
    text("IN : 14 (4288)",main_section[2][0]+450, main_section[2][1]+pe_map.height+grid_gap*27);
    text("DD : 75 (0)",main_section[2][0]+10, main_section[2][1]+pe_map.height+grid_gap*31);
    text("HT : 9 (64035)",main_section[2][0]+230, main_section[2][1]+pe_map.height+grid_gap*31);
    text("HM : 24 (2436)",main_section[2][0]+450, main_section[2][1]+pe_map.height+grid_gap*31);
    
  }
  // 2) Ranking 데이터에서 몇위를 차지하고 있는지를 보여줌
  
}

// when showing earthquake is selected 
void popup2(){
  int box_height = height-main_section[2][1]-40;
  int box_width = width-main_section[2][0]-30;
  
  fill(0,200);
  noStroke();
  rect(main_section[2][0], main_section[2][1], main_section[2][0]+box_width , main_section[2][1]+box_height);
  
  fill(255);
  textFont(title_font);
  textSize(36);
  textAlign(LEFT,BOTTOM);
  text(title[1],main_section[2][0], main_section[2][1]+50);
  stroke(255);
  line(main_section[2][0],main_section[2][1]+55,main_section[2][0]+box_width,main_section[2][1]+55);
}
