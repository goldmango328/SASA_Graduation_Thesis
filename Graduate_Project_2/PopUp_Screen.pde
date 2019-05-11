//====================== POPUP SCREEN ==============================
/* modules ::   popup1()
                popup2()
 */

// popup1() ::More About Country" | LEFT section
void popup1() {
  int box_height = height-main_section[2][1]-40;
  int box_width = (width-main_section[2][0]-30)/2;

  // drawing POPUP screen
  fill(0, 200);
  noStroke();
  rect(popup_section[0][0], popup_section[0][1], popup_section[0][0]+box_width-5, popup_section[0][1]+box_height);

  // TEXT for popup1 title : "More About Country"
  fill(255);
  textFont(title_font);
  textSize(36);
  textAlign(LEFT, BOTTOM);
  text(popup_title[0], popup_section[0][0], popup_section[0][1] + 50);

  stroke(255);
  line(popup_section[0][0], popup_section[0][1]+55, popup_section[0][0]+box_width-5, popup_section[0][1]+55);
  
  // TEXT for ranking bubbles : "Rank of this country"
  fill(255);
  textFont(title_font);
  textSize(36);
  textAlign(LEFT, BOTTOM);
  text("Rank of this country", popup_section[0][0], 630);

  stroke(255);
  line(popup_section[0][0], 640, popup_section[0][0]+box_width-5, 640);
  
  if (detail_country == "None") return;
  // informations for mouseDragged detail
  TableRow detail = country_info.findRow(detail_code.toUpperCase(),"ISO-3166aplha2");
  TableRow acronym = country_acronym.findRow(detail_code.toUpperCase(),"country");
  TableRow coord = country_coord.findRow(detail_code.toUpperCase(),"country");
  int index = country_name.findRow((acronym.getString("name")).toUpperCase(),"country").getInt("index");
  
  // Representing Additional Datas about the country
  // name | latitude | longitude | capital | area | population | continent
  textFont(title_font_20);
  textSize(20);
  text("NAME(INDEX) | "+acronym.getString("name")+"("+index+")", popup_section[0][0] , popup_section[0][1] + grid_gap*10);
  text("LATITUDE | "+coord.getString("latitude"), popup_section[0][0] , popup_section[0][1] + grid_gap*14);
  text("LONGITUDE | "+coord.getString("longitude"), popup_section[0][0] , popup_section[0][1] + grid_gap*18);
  text("CAPITAL | "+detail.getString("capital"),popup_section[0][0] , popup_section[0][1] + grid_gap*22);
  text("AREA | "+detail.getString("area")+ "km^2", popup_section[0][0] , popup_section[0][1] + grid_gap*26);
  text("POPULATION | "+detail.getString("population"), popup_section[0][0] , popup_section[0][1] + grid_gap*30);
  text("CONTINENT | "+detail.getString("continent"), popup_section[0][0] , popup_section[0][1] + grid_gap*34);
  
  // Representing Additional Datas about the country as BUBBLES
  int rank;
  for (int i=0 ; i<6 ; i++) {
    rank = 1;
    for (TableRow row : NOAA_rank.rows()){
      if (row.getString(column_Acronym[i]+"_country").equals(detail_country) == true){
        float rad = map(rank, 1, 97, 30,5); // bubble radius : rank of the feature
        float x = map(i,0,6, popup_section[0][0]+30, popup_section[0][0]+box_width-30);
        float y = popup_section[0][1]+box_height-50;
        
        noStroke();
        fill(BOX_color);
        ellipseMode(RADIUS);
        ellipse(x, y, rad, rad);
        
        textAlign(CENTER, CENTER);
        textFont(tab_font_15);
        textSize(20);
        if (rad >= 15){
          fill(0);
          text(rank, x, y);
        } else{
          fill(255);
          text(rank, x, y+rad+3);
        }
        fill(255);
        textFont(tab_font_12);
        textSize(12);
        text(column_Name[i], x, i%2==0? y-rad-10 : y+rad+30);
        break;
      }
      rank += 1;
    }
  }
  rank = 1;
  for(TableRow row : NOAA_rank.rows()){
    if (row.getString("EQ_country").equals(detail_country) == true){
      float rad = map(rank, 1, 97, 30,5); // bubble radius : rank of the feature
        float x = map(6,0,6, popup_section[0][0]+30, popup_section[0][0]+box_width-40);
        float y = popup_section[0][1]+box_height-50;
        
        noStroke();
        fill(BOX_color);
        ellipseMode(RADIUS);
        ellipse(x, y, rad, rad);
        
        textFont(tab_font_15);
        textSize(20);
        if (rad >= 15){
          fill(0);
          textAlign(CENTER, CENTER);
          text(rank, x, y);
        } else{
          fill(255);
          textAlign(CENTER, TOP);
          text(rank, x, y+rad+10);
        }
        
        fill(255);
        textAlign(CENTER, CENTER);
        textFont(tab_font_12);
        textSize(12);
        text("earthquake CNT", x, y-rad-10);
        break;
      }
      rank += 1;
  }
}

// popup2() :: "More About Earthquake" | RIGHT section :: use NOAA_country data 
void popup2() {
  int box_height = height-main_section[2][1]-40;
  int box_width = (width-main_section[2][0]-30)/2;
  
  TableRow acronym = country_acronym.findRow(detail_code.toUpperCase(),"country");
  int index;
  try{
    index = country_name.findRow((acronym.getString("name")).toUpperCase(),"country").getInt("index");
  } catch(NullPointerException e){
    return ;
  }
  
  Float[] min_max = getMinMax(NOAA_country[index]);

  fill(0, 200);
  noStroke();
  rect(popup_section[1][0], popup_section[1][1], width-20, popup_section[1][1]+box_height);

  // TEXT for popup1 title : "More About Earthquake"
  fill(255);
  textFont(title_font);
  textSize(36);
  textAlign(LEFT, BOTTOM);
  text(popup_title[1], popup_section[1][0], popup_section[1][1] + 50);

  stroke(255);
  line(popup_section[1][0], popup_section[1][1]+55, width-20, popup_section[1][1]+55);
  
  noStroke();
  fill(255, 30);
  rect(popup_section[1][0]+10, popup_section[1][1]+70, popup_section[1][0]+box_width-10, popup_section[1][1]+box_width-10);
  
  // if the max data is 0 : doesn't mean anything 
  if(min_max[1] == 0){
    fill(255);
    textFont(title_font);
    textSize(36);
    textAlign(CENTER, CENTER);
    text("NO RELATIONSHIP", popup_section[1][0]+box_width/2, popup_section[1][1] + box_width/2);
    return ;
  }
  
  // HORIZONTAL LINE for scatterplot : about Magnitude
  for (int i=0 ; i<7 ; i++){
    float x = map(i+4, 4, 10, popup_section[1][0]+30, popup_section[1][0]+box_width-30);
    
    strokeWeight(1);
    stroke(255,80);
    line(x, popup_section[1][1]+70, x, popup_section[1][1]+box_width-10);
    
    fill(255);
    textFont(tab_font_12);
    textSize(12);
    textAlign(CENTER, TOP);
    text(i+4, x, popup_section[1][1]+box_width+3);
  }
  
  // VERTICAL LINE for scatterplot : about selected_type //<>//
  for (float i = min_max[0] ; i <=min_max[1] ; i+= (min_max[1]-min_max[0])/6 ){
    float y = map(i, min_max[0], min_max[1], popup_section[1][1]+box_width-30, popup_section[1][1]+70);
   
    strokeWeight(1);
    stroke(255,80);
    line(popup_section[1][0], y, popup_section[1][0]+box_width, y);
    
    fill(255);
    textFont(tab_font_12);
    textSize(12);
    textAlign(LEFT, CENTER);
    text(int(i), popup_section[1][0]+box_width, y-3);
  }
  
  // draw GRID line for scatterplot
  for (TableRow row : NOAA_country[index].rows()){
    float mag = row.getFloat("EQ_primary");
    int val = row.getInt(column_Name[selected_type]);
    
    float x = map(mag, 4, 10, popup_section[1][0]+30, popup_section[1][0]+box_width-30);
    float y = map(val, min_max[0], min_max[1], popup_section[1][1]+box_width-30, popup_section[1][1]+70);
    
    fill(BOX_color);
    noStroke();
    ellipseMode(RADIUS);
    ellipse(x,y, 3,3);
  }
}
