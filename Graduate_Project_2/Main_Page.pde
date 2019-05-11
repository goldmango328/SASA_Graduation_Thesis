//====================== MAIN PAGE ==============================
/* modules ::   isMouseinData()
                draw_paper_title()
                draw_title()
                draw_pagetab()
                draw_popupbuttons()
                mergeintoOneTable()
                
                control_year()
                control_type()
                control_graph3()
                
                draw_graph1()
                draw_graph2()
                draw_graph3()
*/

// isMouseinData() :: returns true if mouse is in bubble
boolean isMouseinData(float x, float y, float radius){
  if (dist(mouseX, mouseY, x, y) <= radius) return true;
  else return false;
}

// draw_paper_title() :: draws title of this thesis & address for github
void draw_paper_title(){
  textFont(paper_font);
  textSize(20);
  textAlign(CENTER,CENTER);
  fill(255);
  text("Development of Visualization Program",260,140);
  text("for International Seismic Data Applications",260,170);
  
  textSize(15);
  text("Sejong Academy of Science and Arts", 260,220);
  textFont(tab_font_15);
  text("Jee Myoung Guem", 260, 250);
  
  text("DATE : 2018.01. ~ 2019.05.", 260, 270);
  
  fill(255,200);
  textSize(12);
  text("CODES & PAPER : https://github.com/goldmango328/SASA_Graduation_Thesis", 260, 330);
  
  fill(255);
  strokeWeight(2);
  stroke(200);
  line(20,355,510,355);
}


// draw_title() :: drawing title "EARTHQUAKES"
void draw_title(){
  int title_height = 100;
  int title_gap = 20;

  fill(255);
  textFont(title_font);
  textSize(50);
  textAlign(LEFT, BOTTOM);
  text("EARTHQUAKES", title_gap, title_height-title_gap);

  fill(255);
  strokeWeight(2);
  stroke(200);
  line(title_gap, title_height-title_gap, width-title_gap, title_height-title_gap);
}

// draw_pagetab() :: drawing 2 page tab buttons
void draw_pagetab(){
  String[] title = {"Main Page","Sub Page"};
  
  rectMode(CORNERS);
  noStroke();
  textSize(24);
  textAlign(LEFT, BOTTOM);
  
  for(int i=0 ; i<2 ; i++){
    fill(i==page? TAB_color : color(255,50));
    rect(page_tabLeft[i], page_tabTop, page_tabRight[i], page_tabBottom);
    fill(i==page? 255 : color(255,50));
    text(title[i], page_tabRight[i]+grid_gap, page_tabBottom);
  }
}

// draw_popupButtons() :: drawing 2 popup buttons 
void draw_popupButtons(){  
  rectMode(CORNERS);
  noStroke();
  textFont(title_font_20);
  textSize(20);
  textAlign(LEFT, BOTTOM);
  
  fill(show_popup == 1 ? TAB_color : 255 ); // if it is pressed : (1) TAB_color / (-1) 255
  rect(popup_tabLeft, popup_tabTop, popup_tabRight, popup_tabBottom);
  text("More Information", popup_tabLeft, popup_tabTop);
  
  // shows what is selected with country-time-magnitude
  textAlign(LEFT, TOP);
  text("NOW SELECTED: "+detail_country+" | "+detail_value, popup_tabLeft, popup_tabTop + 40);
}

// mergeintoOneTable() :: merge start_year ~ end_year data into one
// merge :: time(year-month) | type (every 6 feature)
Table mergeintoOneTable(){
  Table merge = new Table();
  
  merge.addColumn("year", Table.INT);
  merge.addColumn("month", Table.INT);
  merge.addColumn("DH", Table.INT);
  merge.addColumn("MS", Table.INT);
  merge.addColumn("IN", Table.INT);
  merge.addColumn("DD", Table.INT);
  merge.addColumn("HT", Table.INT);
  merge.addColumn("HM", Table.INT);

  for (int year = start_year; year <= end_year; year++) {
    for (int month = 1; month <= 12; month++) {
      TableRow newRow = merge.addRow();
      newRow.setInt("year", year);
      newRow.setInt("month", month);
    }
  }

  for (int year = start_year; year <= end_year; year++) {
    for (TableRow row : NOAA_year[year-2000].rows()) { 
      for (TableRow findrows : merge.findRows(str(year), "year")) { // finding merge-row of "year"
        if (findrows.getInt("month") == row.getInt("month")) { // finding merge-row of "month"
          findrows.setInt("DH", findrows.getInt("DH")+row.getInt("deaths"));
          findrows.setInt("MS", findrows.getInt("MS")+row.getInt("missing"));
          findrows.setInt("IN", findrows.getInt("IN")+row.getInt("injuries"));
          findrows.setInt("DD", findrows.getInt("DD")+row.getInt("damage_millions_dollars"));
          findrows.setInt("HT", findrows.getInt("HT")+row.getInt("house_destroyed"));
          findrows.setInt("HM", findrows.getInt("HM")+row.getInt("house_damaged"));
          break;
        }
      }
    }
  }
  return merge;
}

// control_year() :: making buttons and reaction about controling start_year & end_year
void control_year(){
  int box_height = 300;
  
  time_tabTop = main_section[1][1] + box_height/2;
  time_tabBottom = main_section[1][1] + box_height/2 + 30;
  time_tabWidth = 60;
  time_tabHeight = time_tabBottom - time_tabTop;
  
  // START button tab
  time_tabLeft[0] = main_section[1][0] + grid_gap*2;
  time_tabRight[0] = time_tabLeft[0] + time_tabWidth;
  timetext_tabLeft[0] = time_tabRight[0];
  timetext_tabRight[0] = timetext_tabLeft[0] + time_tabWidth*2;
  
  // END button tab
  time_tabLeft[1] = time_tabLeft[0];
  time_tabRight[1] = time_tabRight[0];
  timetext_tabLeft[1] = timetext_tabLeft[0];
  timetext_tabRight[1] = timetext_tabRight[0];
  
  // TEXT :: explanation about time tabs
  fill(255);
  textAlign(LEFT, BOTTOM);
  textFont(title_font_20);
  textSize(23);
  text("Choose Year", 40, time_tabTop-grid_gap);
  
  noStroke();
  fill(TAB_color);
  rectMode(CORNERS);
  rect(time_tabLeft[0], time_tabTop, time_tabRight[0], time_tabBottom);
  rect(time_tabLeft[1], time_tabTop+time_tabHeight+10, time_tabRight[1], time_tabBottom+time_tabHeight+10);

  fill(255, 80);
  rect(timetext_tabLeft[0], time_tabTop, timetext_tabRight[0], time_tabBottom);
  rect(timetext_tabLeft[1], time_tabTop+time_tabHeight+10, timetext_tabRight[1], time_tabBottom+time_tabHeight+10);

  fill(255);
  textAlign(CENTER, CENTER);
  textFont(tab_font_12);
  textSize(12);
  text("START", (time_tabLeft[0]+time_tabRight[0])/2, time_tabTop+time_tabHeight/2);
  text("END", (time_tabLeft[1]+time_tabRight[1])/2, time_tabTop+time_tabHeight/2+time_tabHeight+10);
  textSize(14);
  text(str(start_year), (timetext_tabLeft[0]+timetext_tabRight[0])/2, time_tabTop+time_tabHeight/2);
  text(str(end_year), (timetext_tabLeft[1]+timetext_tabRight[1])/2, time_tabTop+time_tabHeight/2+time_tabHeight+10);
  
}

// control_type() :: making buttons and control reactions about 6 features
void control_type(){
  type_tabTop[0] = 510;
  type_tabBottom[0] = type_tabTop[0] + type_tabHeight;
  
  type_tabTop[1] = type_tabBottom[0] + grid_gap; 
  type_tabBottom[1] = type_tabTop[1] + type_tabHeight;

  type_tabLeft[0] = 40;  
  type_tabRight[2] = 480;
  type_tabWidth = (type_tabRight[2]-type_tabLeft[0]-grid_gap*2)/3;
  
  type_tabRight[0] = type_tabLeft[0]+type_tabWidth;
  type_tabLeft[1] = type_tabRight[0]+grid_gap;  
  type_tabRight[1] = type_tabLeft[1]+type_tabWidth;
  type_tabLeft[2] = type_tabRight[1]+grid_gap;
  
  // TEXT :: explanation about type tabs & shows selected_type
  textAlign(LEFT, BOTTOM);
  textFont(title_font_20);
  textSize(23);
  text("Choose Type", type_tabLeft[0], type_tabTop[0]-grid_gap);
  text("ver."+selected_type, type_tabLeft[0]+textWidth("Choose Type")+grid_gap*2, type_tabTop[0]-grid_gap);
  text(column_Name[selected_type].toLowerCase(), type_tabLeft[0]+textWidth("Choose Type ver.0")+grid_gap*2, type_tabTop[0]-grid_gap);

  for (int j=0; j<2; j++) {
    for (int i=0; i<type_tabNum; i++) {
      // when the box is the selcted_type : more darker than the original
      // RIGHT TAB BOX :: where the text is in 
      fill(255, j*3+i == selected_type? 40 : 80);
      rect(type_tabLeft[i], type_tabTop[j], type_tabRight[i], type_tabBottom[j]);
      
      // LEFT TAB BOX :: shows color of graph
      fill(j*3+i == selected_type? PRESS_BOX_color : BOX_color);
      rect(type_tabLeft[i], type_tabTop[j], type_tabLeft[i]+type_tabHeight, type_tabBottom[j]);

      fill(255);
      textAlign(CENTER, CENTER);
      textFont(tab_font);
      textSize(12);
      text(column_Acronym[j*3+i], (type_tabLeft[i]+type_tabRight[i]+type_tabHeight)/2, (type_tabTop[j]+type_tabBottom[j])/2);
    }
  }
}

// control_graph3() :: making small checkbox with appearance about significant earthquakes
void control_graph3(){
  int check_gap = 10;
  String[] check_text = {"MAGNITUDE 7 ~ 8","MAGNITUDE 8 ~ 9","MAGNITUDE 9 ~ 10","ALL SELEECTED"};
  
  check_tabWidth = check_tabHeight = 20;
  
  check_tabLeft = 270;
  check_tabRight = check_tabLeft + check_tabWidth;
  
  check_tabTop[0] = 630;
  check_tabBottom[0] = check_tabTop[0] + check_tabHeight;
  
  for(int i=1 ; i<check_tabNum ; i++){
    check_tabTop[i] = check_tabBottom[i-1] + check_gap;
    check_tabBottom[i] = check_tabTop[i] + check_tabHeight;
  }
  
  textAlign(LEFT, BOTTOM);
  textFont(title_font_20);
  textSize(23);
  text("Choose Category", check_tabLeft, check_tabTop[0]-10);
  
  textAlign(LEFT,CENTER);
  textFont(tab_font_15);
  textSize(15);
  
  for(int i=0 ; i<check_tabNum ; i++){
    fill(check[i] == true ? TAB_color : color(255,50));
    rect(check_tabLeft, check_tabTop[i], check_tabRight, check_tabBottom[i]);
    fill(255);
    text(check_text[i], check_tabRight+10, (check_tabBottom[i]+check_tabTop[i])/2);
  }
  
}

// draw_graph1() :: Main Page Graph | Vertical Bar Chart | x :time, y :selected_type
void draw_graph1(){
  int box_height = 460;
  int box_width = 1640-main_section[2][0] + 130;
  
  Table mergedData = mergeintoOneTable(); // when ever start_year and end_year changes, mergedData should be updated
  
  // main_graph1 :: Vertical Bar Chart (x:time | y:selected_type)
  draw_VerticalBarChart(mergedData, main_section[2][0], main_section[2][1], main_section[2][0]+box_width, main_section[2][1]+box_height);
  
  // BOTTOM LINE of the main_graph1
  stroke(255, 120);
  strokeWeight(2);
  line(main_section[2][0], main_section[2][1]+box_height, main_section[2][0]+box_width, main_section[2][1]+box_height);
}

// draw_graph2() :: Main Page Graph | Bambo Chart(about more important earthquake with selected_type) | x :time, bubble :magnitude
void draw_graph2(){
  int box_height = 60;
  int box_width = 1780 - main_section[4][0];
  int box_margin = 20; // box_margin :: (x coord) gap between actual graph and section
  
  int timeline_gap = 15; // timeline_gap :: length for vertical line at timeline bar
  int timeline_smallgap = 8; // timeline_smallgap :: length for small vertical line in middle of timeline bar
  int timetext_gap = 10;
  
  int timeline_sx = main_section[3][0] + box_margin;
  int timeline_ex = main_section[3][0] + box_width - box_margin;
  int timelineY = main_section[3][1] + box_height/2;
  
  Table merged = mergeintoOneTable();
  Float[] min_max = getMinMax(merged);
  
  stroke(255,120);
  strokeWeight(3);
  
  line(timeline_sx, timelineY, timeline_ex, timelineY); // horizontal line to timeline_sx <-> timeline_ex
  line(timeline_sx, timelineY-timeline_gap, timeline_sx, timelineY+timeline_gap); // vertical line at timeline_sx
  line(timeline_ex, timelineY-timeline_gap, timeline_ex, timelineY+timeline_gap); // vertical line at timeline_ex
  
  for (int year = start_year ; year <= end_year+1 ; year++){
    float timelineX = map(year, start_year, end_year+1, timeline_sx, timeline_ex);
    
    // marking every YEAR timeline
    strokeWeight(1);
    line(timelineX, timelineY-timeline_smallgap, timelineX, timelineY+timeline_smallgap);
    
    // TEXT for every year
    fill(255);
    textFont(tab_font);
    textAlign(CENTER, CENTER);
    textSize(year == start_year || year == end_year+1 ? 15: 10);
    text(str(year), timelineX, timelineY+timeline_gap+timetext_gap);
  }
  
  for (int year = start_year ; year <= end_year ; year++ ){
    for (TableRow row : NOAA_year[year-2000].rows()){
      // raw_value :: takes value of selected_type
      float raw_value = row.getFloat(column_Name[selected_type]);
      
      // visualize ONLY significant events with these CONDITIONS
      if(selected_type == 0 && raw_value < 10){ // about [0] "deaths"
        continue;
      } else if (selected_type == 3 && raw_value < 1000000){ // about [3] "damage_millions_dollars"
        continue;
      }
      
      int row_year = row.getInt("year");
      int row_month = row.getInt("month");
      int row_day = row.getInt("day");
      int total_days = (row_year - start_year)*365 + (row_month-1)*30 + row_day;
      float x = map(total_days, 0, 365*(end_year-start_year+1), timeline_sx, timeline_ex);
      float value = map(raw_value, min_max[0], min_max[1], 5, 30);
      
      fill(#FF9090,100);
      noStroke();
      ellipseMode(CENTER);
      ellipse(x, timelineY, value, value);
    }
  }
}
      
// draw_graph3() :: Main Page Graph | Bambo Chart | x :time, bubble :magnitude
void draw_graph3(){
  int box_height = 200;
  int box_width = 1780 - main_section[3][0];
  int box_margin = 20; // box_margin :: (x coord) gap between actual graph and section 
  
  int timeline_gap = 15; // timeline_gap :: length for vertical line at timeline bar
  int timeline_smallgap = 8; // timeline_smallgap :: length for small vertical line in middle of timeline bar
  int timetext_gap = 10; 
  
  int timeline_sx = main_section[3][0] + box_margin;
  int timeline_ex = main_section[3][0] + box_width - box_margin;
  int timelineY = main_section[3][1] + box_height/2;
  
  stroke(255, 120);
  strokeWeight(3);
  
  line(timeline_sx, timelineY, timeline_ex, timelineY); // horizontal line to timeline_sx <-> timeline_ex
  line(timeline_sx, timelineY-timeline_gap, timeline_sx, timelineY+timeline_gap); // vertical line at timeline_sx
  line(timeline_ex, timelineY-timeline_gap, timeline_ex, timelineY+timeline_gap); // vertical line at timeline_ex
  
  for (int year = start_year ; year <= end_year+1 ; year++){
    float timelineX = map(year, start_year, end_year+1, timeline_sx, timeline_ex);
    
    // marking every YEAR timeline
    strokeWeight(1);
    line(timelineX, timelineY-timeline_smallgap, timelineX, timelineY+timeline_smallgap);
    
    // TEXT for every year
    fill(255);
    textFont(tab_font);
    textAlign(CENTER, CENTER);
    textSize(year == start_year || year == end_year+1 ? 15: 10);
    text(str(year), timelineX, timelineY+timeline_gap+timetext_gap);
  }
  
  for (int year = start_year ; year <= end_year ; year++){
    for (TableRow row : NOAA_year[year-2000].rows()){
      float raw_value = row.getFloat("EQ_primary");
      
      if (check[0] == true){
        if ((raw_value >= 7 && raw_value <=8) != true)continue;
      }
      else if (check[1] == true){
        if ((raw_value >= 8 && raw_value <=9) != true)continue;
      }
      else if (check[2] == true){
        if ((raw_value >= 9 && raw_value <=10) != true) continue;
      }
      
      int row_year = row.getInt("year");
      int row_month = row.getInt("month");
      int row_day = row.getInt("day");
      int total_days = (row_year-start_year)*365 + (row_month-1)*30 + row_day;
      
      float x = map(total_days, 0, 365*(end_year-start_year+1), timeline_sx, timeline_ex);
      float value = map(raw_value, 5, 10, 1,30);
      
      fill(#FF9090, 100);
      noStroke();
      ellipseMode(CENTER);
      ellipse(x, timelineY, value, value);
      
      // there should be isMouseinData function for interactive reactions
      if (isMouseinData(x,timelineY, value) && show_popup == -1){
        detail_value = raw_value;
        detail_country = row.getString("country");
        detail_area = row.getString("location_name");
        
        TableRow codeRow = country_acronym.findRow(detail_country.charAt(0)+detail_country.substring(1).toLowerCase(), "name");
        // try-catch :: not all country names are in the data, so if there is error then it will be
        try {
          detail_code = codeRow.getString("country");
          detail_time[0] = row.getInt("year");
          detail_time[1] = row.getInt("month");
          detail_time[2] = row.getInt("day");
          detail_time[3] = row.getInt("hour");
          detail_time[4] = row.getInt("minute");
          detail_time[5] = row.getInt("second");
        } catch (NullPointerException e){
          continue;
        } 
      }
    }
  }
}
