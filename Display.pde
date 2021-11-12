class Display {
  Menu topMenu;
  BarChart bchart;
  ScatterPointPlot schart;
  PieChart pchart;
  
  Display() {
    topMenu = new Menu();
    bchart = new BarChart();
    schart = new ScatterPointPlot();
    pchart = new PieChart();
  }
  
  void display() {
    background(#2C3B4B);
    boolean [] months = new boolean[12];
    for (int i = 0; i < months.length; i++) {
      months[i] = topMenu.months[i].set;
    }
    boolean max = topMenu.max.set;
    boolean min = topMenu.min.set;
    boolean mean = topMenu.mean.set;
    boolean snow = topMenu.snow.set;
    int start_rng = topMenu.start_rng;
    int end_rng = topMenu.end_rng;
    
    if(topMenu.graph.setting == 0)
      bchart.display(max, min, mean, snow, start_rng, end_rng, months);
    if(topMenu.graph.setting == 1)
      schart.display(max, min, mean, snow, start_rng, end_rng, months);
    if (topMenu.graph.setting == 2)
      pchart.display(months, start_rng, end_rng, topMenu.startYear, topMenu.endYear);
    topMenu.display();
  }
  
  void mouseClick() {
    topMenu.click();
  }
}






class Menu {
  Switch graph;
  
  Button min;
  Button max;
  Button mean;
  Button snow;
  
  Trigger allMonths;
  Trigger noMonths;
  Button [] months = new Button [12];
  
  Trigger yearRange;
  Trigger resetYears;
  int start_rng = 0;
  int end_rng = data.size() -1;
  int maxYear;
  int minYear;
  int startYear = data.get(0).d.Year;
  int endYear = data.get(data.size() -1).d.Year;
  
  Menu () {
    String [] tempnames = {"Barchart", "Scatter Chart", "Pie Chart"};
    graph = new Switch(width * (1.0/32), 0, width * (33.0/184), height/8, tempnames);
    max = new Button(width * (1.0/32) + width * (33.0/184), 0, width * (11.0/92), height/24, true, "Max Temp");
    min = new Button(width * (1.0/32) + width * (33.0/184), height/24, width * (11.0/92), height/24, true, "Min Temp");
    mean = new Button(width * (1.0/32) + width * (33.0/184), height/12, width * (11.0/92), height/24, false, "Mean Temp");
    snow = new Button(width * (1.0/32) + width * (55.0/184), 0, width * (11.0/92), height/8, false, "Snow Fall");
    
    String [] monthnames = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
    float x = width * (467.0/736) - height * (21.0/144);
    float y = height * (5.0/144);
    for (int i = 0; i < months.length; i++) {
      months[i] = new Button(x, y, height/24, true, monthnames[i]);
      x += height/18;
      if(i == 5) {
        y += height/18;
        x = width * (467.0/736) - height * (21.0/144);
      }
    }
    allMonths = new Trigger(width * (77.0/184 + (1.0/32)), 0, width * (10.0/184), height/16, "All");
    noMonths = new Trigger(width * (77.0/184 + (1.0/32)), height/16, width * (10.0/184), height/16, "None");
    
    maxYear = data.get(data.size() -1).d.Year;
    minYear = data.get(0).d.Year;
    resetYears = new Trigger(width * (1 - (1.0/32) - (77.0/368)), 0, width * (21.0/368), height/8, "Reset");
    yearRange = new Trigger(width * (1 - (1.0/32) - (28.0/184)), 0, width * (28.0/184), height/8, "Choose Years");
      
  }
  
  void display() {
    fill(#238641);
    rect(0, -height/8, width, height/4, width/32);
    graph.display();
    if(graph.setting != 2) {
      max.display();
      min.display();
      mean.display();
      snow.display();
    }
    
    allMonths.display();
    noMonths.display();
    for (Button m: months) {
      m.display();
    }
    
    resetYears.display();
    yearRange.display();
  }
  
  void click() {
    graph.pressed();
    if(graph.setting != 2) {
      boolean meanTemp = mean.pressed();
      if (meanTemp) {
        min.set = false;
        max.set = false;
      }
      else {
        boolean max_b = max.pressed();
        boolean min_b = min.pressed();
        if (max_b || min_b) {
          mean.set = false;
        }
      }
      snow.pressed();
    }
    
    for(Button m: months) {
      m.pressed();
    }
    
    boolean allmon = allMonths.pressed();
    if (allmon) {
      for(Button m: months) {
        m.set = true;
      }
    }
    boolean nomon = noMonths.pressed();
    if (nomon) {
      for (Button m: months) {
        m.set = false;
      }
    }
    
    boolean reset = resetYears.pressed();
    if (reset) {
      start_rng = 0;
      startYear = minYear;
      end_rng = data.size() - 1;
      endYear = maxYear;
    }
    boolean range = yearRange.pressed();
    if (range) {
      startYear = inputYear("Please input the first year (from 1990 - 2019).", minYear, maxYear);
      endYear = inputYear("Please input the last year (from 1990 - 2019).", startYear, maxYear);
      start_rng = findYearIndex(startYear, 1);
      end_rng = findYearIndex(endYear, -1);
    }
  }
  
}
