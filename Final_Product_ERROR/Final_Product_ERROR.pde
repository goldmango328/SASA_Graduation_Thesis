int page = 0; 
int show_grid = -1; 
int show_popup = -1;

int grid_gap = 10;
int main_sectNum = 5;
int sub_sectNum = 6;
int[][] main_section = new int [main_sectNum][2];
int[][] sub_section = new int [sub_sectNum][2];

int[] page_tabLeft = new int [2]; 
int[] page_tabRight = new int [2];
int page_tabTop, page_tabBottom;

int tabbox_top, tabbox_bottom, tabbox_width, tabbox_height;
int[] tabboxLeft = new int[2]; 
int[] tabboxRight = new int[2];
int[] texttabboxLeft = new int[2]; 
int[] texttabboxRight = new int[2];

int typeboxNum = 3;
int typebox_height = grid_gap*3;  int typebox_width;
int[] typeboxLeft = new int[typeboxNum];
int[] typeboxRight = new int[typeboxNum];
int[] typeboxTop = new int[2];
int[] typeboxBottom = new int[2];
  
int subtypeboxLeft;  int subtypeboxRight;
int[] subtypeboxTop = new int[6];
int[] subtypeboxBottom = new int[6];

int popupboxLeft; int popupboxRight;
int[] popupboxTop = new int[2];
int[] popupboxBottom = new int[2];

int start_year = 2000;
int end_year = 2017;

boolean start_change = false; 
boolean end_change = false;

Table[] NOAA_year = new Table[18]; 
Table[] NOAA_country = new Table[97];
Table CountryName;
Table CountryCoord;

PFont title_font;
PFont tab_font;
PImage WorldMap; 
PImage ad,jp,pe,ru;
PImage pe_map;

color TAB_color = #FA7E7E;
color GRID_color = color(200);
color BOX_color = color(38,177,250);

String[] columnName = {"DH","MS","IN","DD","HT","HM"};
String[] longName = {"DEATHS","MISSING","INJURIES","DAMAGE_MILLIONS_DOLLARS","HOUSE_DESTROYED","HOUSE_DAMAGED"};
String maxTime;
int maxYear = 2000;
int maxMonth = 1;
int selectedType = 0;
int selectedCountry = 4;

int selectedEarthquake = 0;
int popupButton = 0;

void setup(){
  frameRate(100);
  size(1800,800);
  title_font = loadFont("YDIYGO310-48.vlw");
  tab_font = loadFont("YDIYGO350-10.vlw");
  
  WorldMap = loadImage("DarkMapSliced2.jpg");
  ad = loadImage("ad.png");
  jp = loadImage("jp.png");
  pe = loadImage("pe.png");
  ru = loadImage("ru.png");
  pe_map = loadImage("pe_img.png");
  
  CountryName = loadTable("countryName.csv","header"); // 데이터에 나타난 국가들의 이름
  CountryCoord = loadTable("countries.csv","header"); // 국가별 위도 경도 데이터
  
  // load NOAA_year Table
  for(int year = 0 ; year<18 ; year++){
    NOAA_year[year] = loadTable("NOAA_year["+year+"].csv","header");
  }
  for(int cnt = 0 ; cnt<97 ; cnt++){
    NOAA_country[cnt] = loadTable("NOAA_country["+cnt+"].csv","header");
  }
  
  main_section[0][0] = 30;   main_section[0][1] = 140;
  main_section[1][0] = 20;   main_section[1][1] = 480;
  
  main_section[2][0] = 530;  main_section[2][1] = main_section[0][1]-40;
  main_section[3][0] = 530;  main_section[3][1] = main_section[2][1]+460+grid_gap*2;
  main_section[4][0] = 530;  main_section[4][1] = main_section[2][1]+460+grid_gap*2;
  
  sub_section[0][0] = 20;                sub_section[0][1] = 100;
  sub_section[1][0] = 170+grid_gap*2;    sub_section[1][1] = 100;
  sub_section[2][0] = sub_section[1][0]+1080+grid_gap*2;  sub_section[2][1] = 100;
  sub_section[3][0] = sub_section[2][0]; sub_section[3][1] = sub_section[2][1]+180+grid_gap*2;
  sub_section[4][0] = sub_section[2][0]; sub_section[4][1] = sub_section[3][1]+180+grid_gap*2;
  sub_section[5][0] = sub_section[2][0]; sub_section[5][1] = sub_section[4][1]+180+grid_gap*2;
  
  popupboxLeft = main_section[0][0] + 240 + grid_gap*2;  popupboxRight = popupboxLeft + 200;
  popupboxTop[0] = main_section[0][1]+grid_gap*3; popupboxBottom[0] = popupboxTop[0] + grid_gap*3;
  popupboxTop[1] = popupboxBottom[0] +grid_gap*3; popupboxBottom[1] = popupboxTop[1] + grid_gap*3;
}

void draw(){
  background(0,10);
  show_gridlines(); // main_section을 나눌 때 이용하기 위한 그리드선
  draw_title(); // title을 보여주는 함수
  draw_titletabs(); // title tab을 보여주는 함수
  show_page();
  
  // println("x:"+str(mouseX)+"|y:"+str(mouseY));
  // print("start_year:"+start_year+" | start_change:"+ start_change);
  // print(" end_year:"+end_year+" | end_change:"+ end_change);
}

void show_page(){
  if(page ==0){
    control_year();
    control_type();
    show_specific();
    draw_popupButtons();
    
    draw_worldmap(); // 세계 지도를 보여주는 함수
    draw_graph1();
    draw_graph2();
    draw_graph3();
  }
  else{
    /*
    draw_selectBar1();
    draw_selectBar2();
    draw_selectBar3();
    draw_subgraph1();
    draw_subgraph2();
    draw_subgraph3();
    draw_subgraph4();
  */
  }
  if(show_popup==1){
    popup1();
  }
}
    
void show_gridlines(){
  strokeWeight(1);
  if(show_grid == 1){
    for(int i=0 ; i<=width ; i+=grid_gap){
      stroke(255,60);
      line(i,0,i,height);
    }
    for(int i=0 ; i<=height; i+=grid_gap){
      stroke(255,60);
      line(0,i,width,i);
    }
  }
  if(show_grid == -1){
    stroke(0);
  } 
}

void draw_title(){
  int title_height = 100;
  int title_gap = 20;
  
  fill(255);
  textFont(title_font);
  textSize(50);
  textAlign(LEFT,BOTTOM);
  text("EARTHQUAKES",title_gap,title_height-title_gap);
  
  fill(255);
  strokeWeight(2);
  stroke(200);
  line(title_gap, title_height-title_gap, width-title_gap, title_height-title_gap);
}

void draw_titletabs(){
  int tabHeight = 30;
  String[] title = {"Main Page","Sub Page"};
  
  rectMode(CORNERS);
  noStroke();
  textSize(24);
  textAlign(LEFT,BOTTOM);
  
  page_tabBottom = 70;
  page_tabTop = page_tabBottom - tabHeight;
  page_tabLeft[0] = 370;
  page_tabRight[0] = page_tabLeft[0]+20;
  page_tabLeft[1] = page_tabRight[0]+int(textWidth("Main Page"))+grid_gap*2;
  page_tabRight[1] = page_tabLeft[1]+20;
  
  for(int i=0 ; i<1 ; i++){
    fill( i == page? TAB_color : 255);
    rect(page_tabLeft[i],page_tabTop,page_tabRight[i],page_tabBottom);
    text(title[i], page_tabRight[i]+grid_gap,page_tabBottom);
  }
  stroke(255);
}

void keyPressed(){
  // about visualizing grid lines
  if(key=='V' || key=='v'){
    show_grid *= -1;
  }
  
  // about page changes
  if(key=='M' || key=='m'){ // 'M'ain page
    page = 0;
  }
  if(key=='S' || key=='s'){ // 'S'ub page
    page = 1;
  }
  // about control year tab button : changing start or end years
  if(start_change == true){
    if(key == 'U' || key == 'u'){
      start_year += 1;
      if(start_year >= 2017){
        start_year = 2017;
      }
      if(start_year > end_year){
        start_year = end_year-1;
      }
    }
    if(key == 'D' || key == 'd'){
      start_year -= 1;
      if(start_year <=2000){
        start_year = 2000;
      }
    }
  }
  if(end_change == true){
    if(key == 'U' || key == 'u'){
      end_year += 1;
      if(end_year >= 2017){
        end_year = 2017;
      }
    }
    if(key == 'D' || key == 'd'){
      end_year -= 1;
      if(end_year <=2000){
        end_year = 2000;
      }
      if(start_year > end_year){
        end_year = start_year+1;
      }
    }
  }
  
  if(key == 'E'){
    selectedCountry += 1;
    if(selectedCountry >= 96){
      selectedCountry = 0;
    }
  }
}

void mousePressed(){
  if(mouseY > page_tabTop && mouseY < page_tabBottom){
    for(int i=0 ; i<2 ; i++){
      if(mouseX > page_tabLeft[i] && mouseX < page_tabRight[i]){
        page = i;
      }
    }
  }
  
  // about worldmap_control tab button
  if(mouseX > tabboxLeft[0] && mouseX < tabboxRight[0]){
    if(mouseY > tabbox_top && mouseY < tabbox_bottom){
      start_change = true;
      end_change = false;
    }
    else if(mouseY > tabbox_top+tabbox_height+10 && mouseY < tabbox_bottom+tabbox_height+10){
      start_change = false;
      end_change = true;
    }
  }
  else{
    start_change = false;
    end_change = false;
  }
  
  for(int j=0 ; j<2 ; j++){
    for(int i=0 ; i<typeboxNum ; i++){
      if(mouseX > typeboxLeft[i] && mouseX < typeboxRight[i]){
        if(mouseY > typeboxTop[j] && mouseY < typeboxBottom[j]){
          selectedType = 3*j+i;
        }
      }
    }
  }
  
  if(mouseX > popupboxLeft && mouseY < popupboxRight){
    for(int i=0 ; i<2 ; i++){
      if(mouseY > popupboxTop[i] && mouseY < popupboxBottom[i]){
        show_popup*=-1;
      }
    }
  }
}
