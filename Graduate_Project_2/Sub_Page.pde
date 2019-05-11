//====================== SUB PAGE ==============================
/* modules ::   sub_draw_buttons()
                sub_draw_checkBox()
                
                sub_draw_graph()
                sub_draw_TOPrank()
*/ 

// sub_draw_buttons() :: draw buttons for selecting 6 feature + earthquake cnt
void sub_draw_buttons(){
  int box_height = 20;
  int box_width = 20;
  
  sub_type_tabTop = 50;
  sub_type_tabBottom = sub_type_tabTop + box_height;
  
  sub_type_tabLeft[0] = 710;
  sub_type_tabRight[0] = sub_type_tabLeft[0] + box_width;
  
  // drawing 1st button
  fill(sub_selected_type == 0 ? BOX_color : color(255,50));
  rect(sub_type_tabLeft[0], sub_type_tabTop, sub_type_tabRight[0], sub_type_tabBottom);
  
  fill(sub_selected_type == 0 ? 255 : color(255,50));
  textFont(title_font_20);
  textSize(20);
  textAlign(LEFT, CENTER);
  text(column_Name[0], sub_type_tabRight[0] + grid_gap , (sub_type_tabTop + sub_type_tabBottom)/2);
  
  // drawing 2nd ~ 6th buttons
  for(int i=1 ; i < sub_type_tabNum-1 ; i++){
    sub_type_tabLeft[i] = int(sub_type_tabRight[i-1] + textWidth(column_Name[i-1]) + grid_gap*2);
    sub_type_tabRight[i] = sub_type_tabLeft[i] + box_width;
    fill(sub_selected_type == i? BOX_color : color(255,50));
    rect(sub_type_tabLeft[i], sub_type_tabTop, sub_type_tabRight[i], sub_type_tabBottom);
    
    fill(sub_selected_type == i? 255 : color(255,50));
    text(column_Name[i], sub_type_tabRight[i] + grid_gap, (sub_type_tabTop + sub_type_tabBottom)/2);
  }
  
  // drawing 7th button 
  sub_type_tabLeft[6] = int(sub_type_tabRight[5] + textWidth(column_Name[5]) + grid_gap*2);
  sub_type_tabRight[6] = sub_type_tabLeft[6] + box_width;
  fill(sub_selected_type == 6 ? BOX_color : color(255,50));
  rect(sub_type_tabLeft[6], sub_type_tabTop, sub_type_tabRight[6], sub_type_tabBottom);
  
  fill(sub_selected_type == 6 ? 255 : color(255,50));
  text("EQ_cnt", sub_type_tabRight[6] + grid_gap, (sub_type_tabTop + sub_type_tabBottom)/2);
}

// sub_draw_checkBox() :: draw checkBox for control the number of showing data
void sub_draw_checkBox(){
  int box_width = width - 20 - sub_section[1][0];
  
  sub_check_tabHeight = 15;
  sub_check_tabWidth = 15;
  
  // TEXT for title
  fill(255);
  textAlign(LEFT, BOTTOM);
  textFont(title_font_20);
  textSize(23);
  text("Choose Range", sub_section[1][0], sub_section[1][1] + 20); 
  
  // TITLE LINE for title
  stroke(255,100);
  strokeWeight(1);
  line(sub_section[1][0], sub_section[1][1] + 25, sub_section[1][0] + box_width , sub_section[1][1] + 25);
  
  // SET coordinates for sub check boxs
  sub_check_tabLeft = sub_section[1][0] + 5;
  sub_check_tabRight = sub_check_tabLeft + sub_check_tabWidth;
  sub_check_tabTop[0] = sub_section[1][1] + 40;
  sub_check_tabBottom[0] = sub_check_tabTop[0] + sub_check_tabHeight;
  for (int i=1 ; i<sub_check_tabNum ; i++){
    sub_check_tabTop[i] = sub_check_tabBottom[i-1] + 10;
    sub_check_tabBottom[i] = sub_check_tabTop[i] + sub_check_tabHeight;
  }
  
  // drawing BUTTONS for sub check tab
  for (int i=0 ; i<sub_check_tabNum ; i++){
    noStroke();
    fill(sub_check[i] == true? TAB_color : color(255,50));
    rect(sub_check_tabLeft, sub_check_tabTop[i], sub_check_tabRight, sub_check_tabBottom[i]);
  }
  
  fill(255);
  textAlign(LEFT, CENTER);
  textFont(tab_font_15);
  textSize(15);
  text("Range up to 10", sub_check_tabRight + 10, (sub_check_tabTop[0]+sub_check_tabBottom[0])/2);
  text("Range up to 20", sub_check_tabRight + 10, (sub_check_tabTop[1]+sub_check_tabBottom[1])/2);
  text("Range up to 30", sub_check_tabRight + 10, (sub_check_tabTop[2]+sub_check_tabBottom[2])/2);
  text("ALL SELECTED", sub_check_tabRight + 10, (sub_check_tabTop[3]+sub_check_tabBottom[3])/2);
  
   // control sub_range by selected check box
  if(sub_check[0] == true) sub_range = 10;
  else if(sub_check[1] == true) sub_range = 20;
  else if(sub_check[2] == true) sub_range = 30;
  else sub_range = 97;
}

// sub_draw_graph() :: Sub Page Graph | Horizontal Bar Chart
void sub_draw_graph(){
  int box_width = 1490;
  int box_height = 680;
  
  draw_HorizontalBarChart(sub_selected_type, sub_section[0][0], sub_section[0][1], sub_section[0][0] + box_width, sub_section[0][1] + box_height);
}

// sub_draw_TOPrank() :: shows TOP 20 rnaking for each one
void sub_draw_TOPrank(){
  int box_width = width - 20 - sub_section[2][0];
  int cnt = 0;
  
  int box_top = sub_section[2][1] + 40; // y coordinate for each text
  
  // TEXT for title
  fill(255);
  textAlign(LEFT, BOTTOM);
  textFont(title_font_20);
  textSize(23);
  text("TOP 20", sub_section[2][0], sub_section[2][1] + 20);
  
  // TITLE LINE for title
  stroke(255,100);
  strokeWeight(1);
  line(sub_section[2][0], sub_section[2][1] + 25, sub_section[2][0] + box_width , sub_section[2][1] + 25);

  fill(255);
  textAlign(LEFT, CENTER);
  textFont(tab_font_15);
  textSize(18);
  for(TableRow row : NOAA_rank.rows()){
    if(cnt >= 20) break;
    if(sub_selected_type != 6 ){
      String country = row.getString(column_Acronym[sub_selected_type]+"_country");
      text((cnt+1)+". "+country.charAt(0)+country.substring(1).toLowerCase(), sub_section[2][0], box_top);
      box_top += 20;
      cnt++;
    } else {
      String country = row.getString("EQ_country");
      text((cnt+1)+". "+country.charAt(0)+country.substring(1).toLowerCase(), sub_section[2][0], box_top);
      box_top += 20;
      cnt++;
    }
  }
}
