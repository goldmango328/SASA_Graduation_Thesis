//====================== SCREEN FLAG INFO =============================
int page = 0; // 0 :: Main Page 1 :: Sub Page
int show_grid = -1; // press 'V' to show grid lines to help making sections
int show_popup = -1; // clicking button -> shows informations through popup screen 

int selected_country = 4; // selected country related with popup button
int selected_earthquake = 0; // selected earthquake related with popup button

//====================== DEFAULT INFO =================================
int grid_gap = 10;
int main_sectNum = 5; // number of sections at Main Page
int sub_sectNum = 3; // number of sections at Sub Page
int[][] main_section = new int [main_sectNum][2]; // Main Page sections' coordinate 
int[][] sub_section = new int [sub_sectNum][2]; // Sub Page sections' coordinate

//====================== PAGE BUTTON INFO =============================
int[] page_tabLeft = new int [2]; // 0 :: Main Page 1 :: Sub Page
int[] page_tabRight = new int [2]; // 0 :: Main Page 1 :: Sub Page
int page_tabTop, page_tabBottom;

//====================== TIME CONTROL BUTTON INFO =====================
int[] time_tabLeft = new int [2];
int[] time_tabRight = new int [2];
int time_tabTop, time_tabBottom, time_tabWidth, time_tabHeight;

int[] timetext_tabLeft = new int [2];
int[] timetext_tabRight = new int [2];

//====================== 6 FEATURE BUTTON INFO ========================
int selected_type = 0; // selected type button (0 ~ 5)
int type_tabNum = 3; // button places as 3 * 2
int[] type_tabLeft = new int [type_tabNum];
int[] type_tabRight = new int [type_tabNum];
int[] type_tabTop = new int [2]; int[] type_tabBottom = new int [2];
int type_tabHeight = grid_gap * 3; int type_tabWidth;

int sub_selected_type = 0; // selected type button in sub page (0 ~ 6)
int sub_type_tabNum = 7; // button places as 7 * 1
int[] sub_type_tabLeft = new int [sub_type_tabNum];
int[] sub_type_tabRight = new int [sub_type_tabNum];
int sub_type_tabTop, sub_type_tabBottom;

//====================== CHECK BOX BUTTON INFO ========================
int check_tabNum = 4;
boolean[] check = new boolean[check_tabNum]; // check1 : mag 7 ~ 8 | check2 : mag 8 ~ 9 | check3 : mag 9 ~ 10 | check4 : show all
int[] check_tabTop = new int [check_tabNum];
int[] check_tabBottom = new int [check_tabNum];
int check_tabLeft, check_tabRight, check_tabWidth, check_tabHeight;

//====================== SUB CHECK BOX BUTTON INFO ====================
int sub_range = 97;
int sub_check_tabNum = 4;
boolean[] sub_check = new boolean[check_tabNum]; // sub_check1 : 10 | sub_check2 : 20 | sub_check3 : 30 | sub_check4 : all
int[] sub_check_tabTop = new int [sub_check_tabNum]; 
int[] sub_check_tabBottom = new int [sub_check_tabNum];
int sub_check_tabLeft, sub_check_tabRight, sub_check_tabWidth, sub_check_tabHeight;

//====================== POPUP BUTTON INFO ============================
int popup_tabLeft, popup_tabRight, popup_tabTop, popup_tabBottom;
int popup_tabHeight, popup_tabWeight;
int[][] popup_section = new int [2][2];

//====================== TIME CONTRL VARIABLE INFO ====================
int start_year = 2000;
int end_year = 2017;

boolean start_change = false;
boolean end_change = false;

//====================== TABLE DATA INFO ==============================
int year_cnt = 18; // number of year data
int country_cnt = 97; // number of country
Table[] NOAA_year = new Table [year_cnt];
Table[] NOAA_country = new Table [country_cnt]; 
Table NOAA_rank = new Table();

Table country_name; // records country name
Table country_coord; // records country coordinates (latitude & longitude)
Table country_acronym; // record country acronym & country full name
Table country_info; // records country information

//====================== FONT & IMAGE & COLOR & STRING & ETC ==========
PFont paper_font; // paper_font :: font for this paper title
PFont title_font; // title_font :: original text size = 48
PFont title_font_20; // title font for text size 20
PFont tab_font; // tab_font :: original text size = 10
PFont tab_font_12; // tab_font for text size 12
PFont tab_font_15; // tab_font for text size 15

PImage[] country_flag = new PImage [97]; // 97 images of country flags
PImage[] country_map = new PImage [97]; // 97 images of country maps

color TAB_color = #FA7E7E;
color GRID_color = color(200);
color BOX_color = color(38, 177, 250); // #26B1FA default color of tab buttons
color PRESS_BOX_color = #296889;

String[] column_Acronym = {"DH","MS","IN","DD","HT","HM"};
String[] column_Name = {"deaths","missing","injuries","damage_millions_dollars","house_destroyed","house_damaged"};

String[] popup_title = {"More About Country","More About Earthquake"};
String detail_country = "None";  // mouseDragged country info
String detail_area = "None"; // mouseDragged location info
String detail_code = "AD"; // mouseDragged country code info
float detail_value; // mouseDragged selected_type info
int[] detail_time = new int [6]; // mouseDragged event time code (y-m-d-h-m-s)

void setup(){
  size(1800, 800);
  paper_font = loadFont("PainterPERSONALUSEONLY-48.vlw");
  title_font = loadFont("YDIYGO310-48.vlw");
  title_font_20 = loadFont("YDIYGO310-20.vlw");
  tab_font = loadFont("YDIYGO350-10.vlw");
  tab_font_12 = loadFont("YDIYGO330-12.vlw");
  tab_font_15 = loadFont("YDIYGO330-15.vlw");
  
  country_name = loadTable("countryName.csv","header");
  country_coord = loadTable("countries_info.csv","header");
  country_acronym = loadTable("countries.csv","header");
  country_info = loadTable("parse_countryInfo.csv","header");
  
  for(int i=0 ; i<year_cnt ; i++){
    NOAA_year[i] = loadTable("NOAA_year["+i+"].csv","header");
  }
  for(int i=0 ; i<country_cnt ; i++){
    NOAA_country[i] = loadTable("NOAA_country["+i+"].csv","header");
  }
  NOAA_rank = loadTable("NOAA_total.csv", "header");
  
  check[3] = true; // default :: all check box is selected
  sub_check[3] = true; // default :: all sub check box is selected
  
  //====================== MAIN SECTION ==============================
  main_section[0][0] = 30;    main_section[0][1] = 140;
  main_section[1][0] = 20;    main_section[1][1] = 480;
  main_section[2][0] = 530;   main_section[2][1] = main_section[0][1]-40;
  main_section[3][0] = 530;   main_section[3][1] = main_section[2][1]+460+grid_gap*2;
  main_section[4][0] = 530;   main_section[4][1] = main_section[2][1]+460+grid_gap*2;
  
  //====================== SUB SECTION ==============================
  sub_section[0][0] = 20;     sub_section[0][1] = 100;
  sub_section[1][0] = 1550;   sub_section[1][1] = 100;
  sub_section[2][0] = 1550;   sub_section[2][1] = 250;
  
  //====================== POPUP BUTTON SECTION =====================
  popup_tabLeft = 40;  
  popup_tabRight = popup_tabLeft + 200;
  popup_tabTop = 390;
  popup_tabBottom = popup_tabTop + grid_gap*3;
  
  popup_section[0][0] = main_section[2][0];    popup_section[0][1] = main_section[2][1];
  popup_section[1][0] = popup_section[0][0] + (width-main_section[2][0]-30)/2 + 5;
  popup_section[1][1] = popup_section[0][1];
  
  //====================== PAGE TAB BUTTON ==========================
  textSize(24); // to get correct measure about textWidth of "Main Page"
  page_tabBottom = 70;
  page_tabTop = page_tabBottom - 30; // 30 :: tabHeight
  page_tabLeft[0] = 370;
  page_tabRight[0] = page_tabLeft[0]+20;
  page_tabLeft[1] = page_tabRight[0]+int(textWidth("Main Page"))+grid_gap*2;
  page_tabRight[1] = page_tabLeft[1]+20;
}

void draw(){
  background(0, 10);
  
  show_gridLines(); // show_gridlines() :: shows grid lines to help section
  draw_title(); // draw_title() :: drawing title
  draw_pagetab(); // draw_pagetab() :: drawing page tabs
  show_page();
  print_test();
}

// show_page() :: core control about showing the screen
void show_page() {
  if (page == 0) { 
    // Main Page
    draw_paper_title();
    control_year(); 
    control_type();
    control_graph3();
   
    draw_popupButtons();

    draw_graph1();
    draw_graph2();
    draw_graph3();
    
    if (show_popup == 1) { 
    // popup screen 1 & 2
      popup1(); 
      popup2();
    } 
  } else { 
    // Sub Page
    sub_draw_buttons();
    sub_draw_checkBox();
    
    sub_draw_graph();
    sub_draw_TOPrank();
  }
}

// print_test() :: function for test 
void print_test(){
}

// show_gridLines() :: shows gridLines to help create sections
void show_gridLines(){
  strokeWeight(1);
  if (show_grid == 1) { // if the user pressed the key 'V'
    for (int i=0; i<=width; i+=grid_gap) {
      stroke(255, 60);
      line(i, 0, i, height);
    }
    for (int i=0; i<=height; i+=grid_gap) {
      stroke(255, 60);
      line(0, i, width, i);
    }
  }
  if (show_grid == -1) {
    stroke(0);
  }
}

void keyPressed(){  
  if (key == 'V' || key == 'v'){ // 'V' : show_gridLines()
    show_grid *= -1;
  }
  if (start_change == true){ // if the start_year button is CLICKED
    if (key == 'U' || key == 'u'){ // increasing start_year
      start_year += 1;
      if (start_year >= 2017){
        start_year = 2017;
      }
      if (start_year >= end_year){
        start_year = end_year - 1;
      }
    }
    if (key == 'D' || key == 'd'){ // decreasing start_year
      start_year -= 1;
      if (start_year <= 2000){
        start_year = 2000;
      }
    }
  }
  if (end_change == true){ // if the end_year button is CLICKED
    if (key == 'U' || key == 'u'){ // increasing end_year
      end_year += 1;
      if (end_year >= 2017){
        end_year = 2017;
      }
    }
    if (key == 'D' || key == 'd'){ // decreasing end_year
      end_year -= 1;
      if (end_year <= 2000){
        end_year = 2000;
      }
      if (start_year >= end_year){
        end_year = start_year + 1;
      }
    }
  }
}

void mousePressed(){ 
  // if the page tab button is CLICKED
  if (mouseY > page_tabTop && mouseY < page_tabBottom){
    for (int i=0 ; i<2 ; i++){
      if (mouseX > page_tabLeft[i] && mouseX < page_tabRight[i]){
        page = i;
      }
    }
  }
  
  // if the time tab button is CLICKED
  if (mouseX > time_tabLeft[0] && mouseX < time_tabRight[0]){
    if (mouseY > time_tabTop && mouseY < time_tabBottom){
      start_change = true;
      end_change = false;
    } else if (mouseY > time_tabTop + time_tabHeight + 10 && mouseY < time_tabBottom + time_tabHeight + 10 ){
      start_change = false;
      end_change = true;
    }
  } else {
    start_change = false;
    end_change = false;
  }
  
  // if one of the 6 feature tab button is CLICKED
  for (int j=0 ; j<2 ; j++){
    for (int i=0 ; i<type_tabNum ; i++){
      if (mouseX > type_tabLeft[i] && mouseX < type_tabRight[i]){
        if (mouseY > type_tabTop[j] && mouseY < type_tabBottom[j]){
          selected_type = 3*j+i;
        }
      }
    }
  }
  
  // if the checkbox button is CLICKED
  for(int i=0 ; i<check_tabNum-1 ; i++){
    if (mouseX > check_tabLeft && mouseX < check_tabRight){
      if (mouseY > check_tabTop[i] && mouseY < check_tabBottom[i]){
        if(check[i] == true) check[i] = false;
        else check[i] = true;
      }
    }
  }
  if(check[0] == false && check[1] == false && check[2] == false){
    check[3] = true;
  } else{
    check[3] = false;
  }
  if(mouseX > check_tabLeft && mouseX < check_tabRight &&  mouseY > check_tabTop[3] && mouseY < check_tabBottom[3]){
    if(check[3] == false){
      check[3] = true;
      check[0] = check[1] = check[2] = false;
    }
  }
  
  // if the popup_button is CLICKED
  if (mouseX > popup_tabLeft && mouseX < popup_tabRight){
    if (mouseY > popup_tabTop && mouseY < popup_tabBottom){
        if(show_popup == -1) show_popup = 1;
        else show_popup = -1;
    }
  }
  
  // if one of the 6 feature tab button in Sub Page is CLICKED
  for(int i=0 ; i<sub_type_tabNum ; i++){
    if (mouseY > sub_type_tabTop && mouseY < sub_type_tabBottom){
      if (mouseX > sub_type_tabLeft[i] && mouseX < sub_type_tabRight[i]){
        sub_selected_type = i;
      }
    }
  }
  
  // if the sub checkbox button is CLICKED
  for(int i=0 ; i<sub_check_tabNum ; i++){
    if (mouseX > sub_check_tabLeft && mouseX < sub_check_tabRight){
      if (mouseY > sub_check_tabTop[i] && mouseY < sub_check_tabBottom[i]){
        if(sub_check[i] == true) {
          sub_check[i] = false;
          sub_check[3] = true;
        }
        else {
          sub_check[i] = true;
          for (int j=0 ; j<sub_check_tabNum ; j++){
            if(j == i) continue;
            else sub_check[j] = false;
          }
        }
      }
    }
  }
}


    
