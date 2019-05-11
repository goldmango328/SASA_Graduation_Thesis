///====================== TOOL FOR DRAWING BAR CHART ====================== 
/* modules ::   chooseBarWidth() 

                getMinMax(Table data)
                sub_getMinMax()
                
                draw_VerticalGridLines(...)
                draw_VerticalBarChart(...)
                
                draw_HorizontalGridLines(...)
                draw_HorizontalBarChart(...)
*/ 

float yInterval = 50000; 

int Vert_barWidth = 3;
int Horz_barWidth = 5; // range: 97 => 5, range: 30 => 10 , range: 20 => 20, range: 10 => 30 

// chooseBarWidth() :: control Horizontal BarWidth by the selected ragne
void chooseBarWidth() {
  if (sub_check[0] == true) Horz_barWidth = 30;
  else if (sub_check[1] == true) Horz_barWidth = 20;
  else if (sub_check[2] == true) Horz_barWidth = 10;
  else Horz_barWidth = 5;
}

// getMinMax(Table data) :: returns Table's MIN & MAX about x(time) & y(selected_type) <- MAIN
Float[] getMinMax(Table data) {
  float MINy = 2000000;
  float MAXy = 0;
  float MINx = 2000000;
  float MAXx = 0;

  int origin_start = 2000;
  int origin_end = 2017;

  for (TableRow row : data.rows()) {
    try{
      if (row.getInt(column_Acronym[selected_type]) > MAXy) {
        MAXy = row.getInt(column_Acronym[selected_type]);
      }
      if (row.getInt(column_Acronym[selected_type]) < MINy) {
        MINy = row.getInt(column_Acronym[selected_type]);
      }
    } catch(IllegalArgumentException e){
      if (row.getInt(column_Name[selected_type]) > MAXy){
        MAXy = row.getInt(column_Name[selected_type]);
      }
      if (row.getInt(column_Name[selected_type]) < MINy) {
        MINy = row.getInt(column_Name[selected_type]);
      }
    }
  }

  // MAXx :: MAXIMUM time | MINx :: MINIMUM time
  for (TableRow row : data.rows()) {
    int year = row.getInt("year");
    int month = row.getInt("month");
    int time = (year-2000)*12 + month;
    if (time > MAXx) MAXx = time;
    if (time < MINx) MINx = time;
  }

  // yInterval is decided by SELECTED_TYPE 
  if (selected_type >= 4) {
    yInterval = 500000;
  } else {
    yInterval = 50000;
  }

  if (MAXy < yInterval && (origin_start != start_year || origin_end != end_year)) {
    yInterval = (MAXy-MINy)/4 - ((MAXy-MINy)/4)%1000;
    origin_start = start_year;
    origin_end = end_year;
  }

  // making it to one array to return 4 values at one
  Float[] min_max = {MINy, MAXy, MINx, MAXx};
  return min_max;
}

// sub_getMinMax(Table data) :: returns Table's MIN & MAX about sub_selected_type + EQ_cnt
int[][] sub_getMinMax() { 
  int[][] min_max = new int [2][7]; // [0][i] :: ith column MIN | [1][i] :: ith column MAX

  for (int i=0; i<6; i++) {
    min_max[1][i] = NOAA_rank.getInt(0, column_Acronym[i]+"_var");
    min_max[0][i] = NOAA_rank.getInt(sub_range-1, column_Acronym[i]+"_var");
  }
  min_max[1][6] = NOAA_rank.getInt(0, "EQ_var");
  min_max[0][6] = NOAA_rank.getInt(sub_range-1, "EQ_var");
  return min_max;
}

// draw_VerticalGridLines() :: function used with draw_VerticalBarChart
// param :: min_max, x1, y1, x2, y2 (need section coords)
void draw_VerticalGridLines(Float[] min_max, float x1, float y1, float x2, float y2) {
  int gap = 20; // Grid Line starts with a gap from the bottom of the section

  stroke(GRID_color, 120);
  strokeWeight(1);

  for (float y = min_max[0]; y <= min_max[1]; y++) { // min_max[0] :: MINy | min_max[1] :: MAXy
    if (y % yInterval == 0 && y != min_max[0]) {
      float val = map(y, min_max[1], min_max[0], y1+gap, y2);

      // TEXT about Grid Lines
      textFont(tab_font_15);
      textSize(15);
      fill(GRID_color);
      textAlign(RIGHT, CENTER);
      text((int)y, x2, val);

      // Grid Line
      line(x1, val, x2-textWidth(str(y)), val);
    }
  }
}

// draw_VerticalBarChart() :: function that draws VerticalBarChart at the section
// param :: data, x1, y1, x2, y2 (need data & section coords)
void draw_VerticalBarChart(Table data, float x1, float y1, float x2, float y2) {
  int gap = 20;
  Float[] min_max = getMinMax(data);

  draw_VerticalGridLines(min_max, x1, y1, x2, y2);

  for (TableRow row : data.rows()) {
    int time = (row.getInt("year")-2000)*12 + row.getInt("month");
    int val = row.getInt(column_Acronym[selected_type]);

    float x = map(time, min_max[2], min_max[3], x1+50, x2-50);
    float y = map(val, min_max[1], min_max[0], y1+gap, y2);

    fill(val == min_max[1] ? TAB_color : BOX_color); // MAX data is colored differently
    rect(x-Vert_barWidth/2, y, x+Vert_barWidth/2, y2);

    // TEXT about each data : written on top of each box
    textFont(tab_font);
    textAlign(CENTER);
    if (val >= min_max[0] + yInterval/2 && val!=0) {
      text(val, x, y-10);
    }
  }
}

// draw_HorizontalGridLines() :: function used with draw_HorizontalBarChart()
// param :: min_max, x1, y1, x2, y2 (need section coords)
void draw_HorizontalGridLines(int[][] min_max, int type, float x1, float y1, float x2, float y2) {
  int gap = 10;
  int yInterval = (min_max[1][type]-min_max[0][type])/15; // 15 grid lines would fit

  stroke(GRID_color);
  strokeWeight(1);

  for (int y = min_max[0][type]; y <= min_max[1][type]; y++) { // min_max[0] :: MINy | min_max[1] :: MAXy
    if (y % yInterval == 0 && y!=min_max[0][type]) {
      float val = map(y, min_max[0][type], min_max[1][type], x1, x2-gap);

      // TEXT about Grid Lines
      textSize(8);
      textFont(tab_font);
      fill(GRID_color);
      textAlign(CENTER);
      text((int)y, val, y2+10);

      // Grid Line
      line(val, y1, val, y2-10);
    }
  }
}

// draw_HorizontalBarChart() :: function that draws HorizontalBarChart at the section
// param :: type, x1, y1, x2, y2 (need sub_selected_type & section coords)
void draw_HorizontalBarChart(int type, float x1, float y1, float x2, float y2) {
  int gap = 20;
  int cnt = 0;

  int[][] min_max = sub_getMinMax();

  draw_HorizontalGridLines(min_max, type, x1, y1, x2, y2);
  chooseBarWidth();

  for (TableRow row : NOAA_rank.rows()) {
    if (cnt == sub_range) break;
    if (type != 6) {
      int val = row.getInt(column_Acronym[type]+"_var");

      float x = map(val, min_max[0][type], min_max[1][type], x1+gap, x2-gap*2);
      float y = map(cnt, 0, sub_range-1, y1+gap/2, y2-gap);
      
      fill(BOX_color);
      noStroke();
      rect(x1, y-Horz_barWidth/2, x, y+Horz_barWidth/2);
      cnt++;

      // TEXT about each data
      textFont(tab_font);
      textSize(8);
      textAlign(LEFT, CENTER);
      text(row.getString(column_Acronym[type]+"_country"), x+10, y);
    } else {
      int val = row.getInt("EQ_var");
      float x = map(val, min_max[0][type], min_max[1][type], x1+gap, x2-gap*2);
      float y = map(cnt, 0, sub_range-1, y1+gap/2, y2-gap);
      
      fill(BOX_color);
      noStroke();
      rect(x1, y-Horz_barWidth/2, x, y+Horz_barWidth/2);
      cnt++;

      // TEXT about each data
      textFont(tab_font);
      textSize(8);
      fill(BOX_color);
      textAlign(LEFT, CENTER);
      text(row.getString("EQ_country"), x+10, y);
    }
  }
}
