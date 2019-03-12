Table mergeintoOneTable(){
  // merge라는 새로운 Table을 선언하여 데이터를 병합하는 방식으로
  Table merge = new Table();
  merge.addColumn("year",Table.INT); // 해당하는 데이터의 column을 가져오는 방법?
  merge.addColumn("month",Table.INT);
  merge.addColumn("DH",Table.INT);
  merge.addColumn("MS",Table.INT);
  merge.addColumn("IN",Table.INT);
  merge.addColumn("DD",Table.INT);
  merge.addColumn("HT",Table.INT);
  merge.addColumn("HM",Table.INT);
  
  for(int year = start_year ; year <= end_year ; year++){
    for(int month = 1 ; month <= 12 ; month++){
      TableRow newRow = merge.addRow();
      newRow.setInt("year",year);
      newRow.setInt("month",month);
    }
  }
  
  for(int year = start_year ; year <= end_year ; year++){
    for(TableRow row : NOAA_year[year-2000].rows()){
      for(TableRow findrows : merge.findRows(str(year),"year")){
        if(findrows.getInt("month") == row.getInt("month")){
          findrows.setInt("DH",findrows.getInt("DH")+row.getInt("deaths"));
          findrows.setInt("MS",findrows.getInt("MS")+row.getInt("missing"));
          findrows.setInt("IN",findrows.getInt("IN")+row.getInt("injuries"));
          findrows.setInt("DD",findrows.getInt("DD")+row.getInt("damage_millions_dollars"));
          findrows.setInt("HT",findrows.getInt("HT")+row.getInt("house_destroyed"));
          findrows.setInt("HM",findrows.getInt("HM")+row.getInt("house_damaged"));
          break;
        }
      }
    }
  }
  saveTable(merge,"merged_Table.csv");
  return merge;
}

// 보여지는 가장 큰 그래프 -> 형태는? 선형 그래프 / 막대 그래프 
void draw_graph1(){
  int box_height = 460;
  int box_width = 1640-main_section[2][0]+130;
 
  // int timeline_sx = main_section[3][0]+box_margin;
  // int timeline_ex = main_section[3][0]+box_width-box_margin;
  // int timelineY = main_section[3][1]+box_height/2;
  
  Table mergedData = mergeintoOneTable();
  // Graph1 Legend Box Guide Lines
  /*
  fill(255,40);
  rect(main_section[2][0]+box_width+20,main_section[2][1],main_section[2][0]+box_width+140,main_section[0][1]+box_height);
  */
  
  draw_VerticalBarChart(mergedData, main_section[2][0], main_section[2][1], main_section[2][0]+box_width, main_section[2][1]+box_height);
  
  stroke(255,120);
  strokeWeight(2);
  line(main_section[2][0], main_section[2][1]+box_height, main_section[2][0]+box_width, main_section[2][1]+box_height);

  // Graph1 Guide Lines
  /*
  stroke(255);
  rectMode(CORNERS);
  fill(255,40);
  rect(main_section[2][0],main_section[2][1],main_section[2][0]+box_width,main_section[0][1]+box_height);
  
  fill(255);
  textAlign(CENTER,CENTER);
  textFont(title_font);
  textSize(36);
  text("Graph1",(2*main_section[2][0]+box_width)/2,(2*main_section[2][1]+box_height)/2);
  */
}

// 막대그래프에서 대푯값에 대한 설명
void show_explain1(){
  int box_height = 100;
  int box_width = 100;
}
