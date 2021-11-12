class BarChart {
  Axis barAxis;
  color [] barColors = {color(#FF0313), color(#4539FF), color(#0AA70B), color(255)};
  
  BarChart() {
    barAxis = new Axis();
  }
  
  void display(boolean max, boolean min, boolean mean, boolean snow, int st_rng, int end_rng, boolean [] months) {
    int [] plotData = new int [0];
    if (max)
      plotData = append(plotData, 0);
    if (min)
      plotData = append(plotData, 1);
    if (mean)
      plotData = append(plotData, 2);
    if (snow)
      plotData = append(plotData, 3);
    
    
    
    barAxis.display(snow);
    float increment_x = (width * (26.0/32))/(end_rng + 1 - st_rng);
    float x = width * (5.0/32);
    float y = height * (34.0/64);
    
    for(int i = st_rng; i <= end_rng; i++) { //<>//
      if(months[data.get(i).d.Month - 1 ]) {
        float [] graphData = new float [0];
        for (int j = 0; j < plotData.length; j++) {
          if(plotData[j] == 0)
            graphData = append(graphData, data.get(i).maxTemp);
          if (plotData[j] == 1)
            graphData = append(graphData, data.get(i).minTemp);
          float meanTemp = (data.get(i).maxTemp + data.get(i).minTemp)/2;
          if (plotData[j] == 2)
            graphData = append(graphData, meanTemp);
          if (plotData[j] == 3)
            graphData = append(graphData, -data.get(i).snowFall);
        }
        for (int k = 0; k < graphData.length - 1; k++) {
          for (int j = k + 1; j < graphData.length; j ++) {
            if (graphData[j] > graphData[k]) {
              float temp_a = graphData[j];
              int temp_b = plotData[j];
              graphData[j] = graphData[k];
              plotData[j] = plotData[k];
              graphData[k] = temp_a;
              plotData[k] = temp_b;
            }
          }
        }
  
        float tall;
        for (int j = 0; j < graphData.length; j++) {
          if(graphData[j] > 0) {
            tall = (graphData[j]/barAxis.max) * (height * (3.0/8));
            fill(barColors[plotData[j]]);
            rect(x, y - tall, increment_x, tall);
          }
          else {
            break;
          }
        }
        for (int j = graphData.length - 1; j >= 0; j--) {
          if(graphData[j] < 0) {
            tall = (graphData[j]/barAxis.max) * (height * (3.0/8));
            fill(barColors[plotData[j]]);
            rect(x, y - tall, increment_x, tall);
          }
          else {
            break;
          }
        }
      }
      x += increment_x;
    }
    barAxis.displayXAxis(st_rng, end_rng);
  }
}









class ScatterPointPlot {
  Axis scatterAxis;
  color [] scatterColors = {color(#DB0012), color(#1133B7), color(#0AA70B), color(255)};
  
  ScatterPointPlot() {
    scatterAxis = new Axis();
  }
  
  void display(boolean max, boolean min, boolean mean, boolean snow, int st_rng, int end_rng, boolean [] months) {
    int [] plotData = new int [0];
    if (max)
      plotData = append(plotData, 0);
    if (min)
      plotData = append(plotData, 1);
    if (mean)
      plotData = append(plotData, 2);
    if (snow)
      plotData = append(plotData, 3);
    
    
    
    scatterAxis.display(snow);
    float increment_x = (width * (26.0/32))/(end_rng + 1 - st_rng);
    float x = width * (5.0/32) + increment_x / 2;
    float y = height * (34.0/64);
    
    for(int i = st_rng; i <= end_rng; i++) {
      
      if(months[data.get(i).d.Month - 1 ]) {
  
        float [] graphData = new float [0];
        for (int j = 0; j < plotData.length; j++) {
          if(plotData[j] == 0)
            graphData = append(graphData, data.get(i).maxTemp);
          if (plotData[j] == 1)
            graphData = append(graphData, data.get(i).minTemp);
          float meanTemp = (data.get(i).maxTemp + data.get(i).minTemp)/2;
          if (plotData[j] == 2)
            graphData = append(graphData, meanTemp);
          if (plotData[j] == 3)
            graphData = append(graphData, -data.get(i).snowFall);
        }
        for (int k = 0; k < graphData.length - 1; k++) {
          for (int j = k + 1; j < graphData.length; j ++) {
            if (graphData[j] > graphData[k]) {
              float temp_a = graphData[j];
              int temp_b = plotData[j];
              graphData[j] = graphData[k];
              plotData[j] = plotData[k];
              graphData[k] = temp_a;
              plotData[k] = temp_b;
            }
          }
        }
  
        float tall;
        for (int j = 0; j < graphData.length; j++) {
          if(graphData[j] > 0) {
            tall = (graphData[j]/scatterAxis.max) * (height * (3.0/8)) - increment_x/2;
            noStroke();
            fill(scatterColors[plotData[j]]);
            ellipse(x, y - tall, increment_x * 1.25, increment_x * 1.25);
            stroke(0);
          }
          else {
            break;
          }
        }
        for (int j = graphData.length - 1; j >= 0; j--) {
          if(graphData[j] < 0) {
            tall = (graphData[j]/scatterAxis.max) * (height * (3.0/8)) + increment_x/2;
            noStroke();
            fill(scatterColors[plotData[j]]);
            ellipse(x, y - tall, increment_x * 1.25, increment_x * 1.25);
            stroke(0);
          }
          else {
            break;
          }
        }
      }
      x += increment_x;
    }
    scatterAxis.displayXAxis(st_rng, end_rng);
  }
}










class Axis {
  float maxTemp = findMaxTemp();
  float minTemp = findMinTemp();
  float max;
  float range;
  int bars;
  
  String x_axis = "Year";
  float xstart;
  float xlength;
  float increment_x;
  
  float ymid;
  float ylength;
  float increment_y;
  String y_axis = "Temperature in Celsius";
  
  Axis () {
    maxTemp = 10 * int((maxTemp + 9) / 10);
    minTemp = 10 * int((minTemp + 9) / 10);
    if(maxTemp > abs(minTemp)) {
      max = maxTemp;
    }
    else {
      max = minTemp;
    }
    range = maxTemp - minTemp;    
    
    xstart = width * (5.0/32);
    xlength = width * (26.0/32);
    
    ymid = height * (17.0/32);
    ylength = height * (24.0/32);
    increment_y = (height * 0.75)/10;
    
  }
  
  void display(boolean snow) {
    strokeWeight(1.5);
    textSize(height/50);
    textAlign(CENTER);
    fill(0);
    line (xstart, ymid - ylength/2, xstart, ymid + ylength/2);
    if (snow) {
      line (xstart - width/11, ymid - ylength/2, xstart - width/11, ymid + ylength/2);
    }
    float y = ymid;
    for (int t = 0; t <= max; t += max/5) {
      line(xstart - width * (1.0/32), y, xstart + xlength, y);
      text(t, width * (3.0/32), y);
      y -= increment_y;
    }
    y = ymid + increment_y;
    for (int t = (int)max/5; t <= max; t+= max/5) {
      line(xstart - width * (1.0/32), y, xstart + xlength, y);
      text("-" + t , width * (3.0/32), y);
      if(snow) {
        line(xstart - width/11, y, xstart - width/10, y);
        text(t, width * (3.0/64), y);
      }
      y += increment_y;
    }
    fill(0);
    textSize(height/32);
    textAlign(CENTER);
    text(x_axis, width * (33.0/64), ymid + ylength/2 + height * (2.0/32));
    translate(width * (5.0/64), ymid);
    rotate(-PI/2);
    if (snow) {
      translate(0, -width * (3.0/64));
      textSize(height/64);
      text("Snow in Centimeters", 0, 0);
      translate(0, width * (3.0/64));
    }
    text(y_axis, 0, 0);
    rotate(PI/2);
    translate(-width * (5.0/64), - ymid);
  }
  
  void displayXAxis(int st_rng, int end_rng) {
    bars = end_rng + 1 - st_rng;
    increment_x = xlength/bars;
    float y = ymid + 4 * increment_y;
    float x = xstart;
    textAlign(CENTER);
    textSize(height/64);
    fill(125);
    for (int i = st_rng; i <= end_rng; i +=  12) {
      line (x, y, x, y + (height * (1.0/32)));
      text (data.get(i).d.Year, x, y + (height * (2.0/32)));
      x += increment_x * 12;
    }
  }
}







float findMaxTemp() {
  float max = 0;
  for(int i = 0; i < data.size(); i++) {
    TempData temp = data.get(i);
    if(temp.maxTemp > max) {
      max = temp.maxTemp;
    }
  }
  return max;
}

float findMinTemp() {
  float min = 0;
  for(int i = 0; i < data.size(); i++) {
    TempData temp = data.get(i);
    if(temp.minTemp > min) {
      min = temp.maxTemp;
    }
  }
  return min;
}








class PieChart {
  Legend myLegend;
  color[] monthColors  = {color(#F70011), color(#981D25), color(#F2229C), color(#B92B99), color(#81226C), color(#722DEA), 
                          color(#2A65F5), color(#46BFD3), color(#46D36F), color(#3DB73E), color(#DAF22C), color(#F77314)};
  
  PieChart() {
    myLegend = new Legend();
  }
  
  
  
  void display(boolean [] months, int st_rng, int end_rng, int startYear, int endYear) {
    ellipse(width * (11.0/16), height * (9.0/16), height * (3.0/4), height * (3.0/4));
    int [] monthShown = new int [0];
    for(int i = 0; i < months.length; i++) {
      if(months[i])
        monthShown = append(monthShown, i);
    }
    float [] dataToPlot = new float[monthShown.length];
    float totalSnow = 0;
    for(int i = 0; i < dataToPlot.length; i++) {
      for (int j = st_rng; j <= end_rng; j++) {
        if (data.get(j).d.Month == monthShown[i] + 1) {
          dataToPlot[i] += data.get(j).snowFall;
          totalSnow += data.get(j).snowFall;
        }
      }
    }

    float angle = -PI/2;
    for(int i = 0; i < dataToPlot.length; i++) {
      dataToPlot[i] /= totalSnow;
      fill(monthColors[monthShown[i]]);
      arc(width * (11.0/16), height * (9.0/16), height * (3.0/4), height * (3.0/4), angle, angle + (2 * PI * dataToPlot[i]));
      if(2 * PI * dataToPlot[i] > PI/15) {
        fill(255);
        textSize(height/45);
        text(nf(dataToPlot[i] * 100, 0, 1) + "%", width * (11.0/16) + cos(angle + PI * dataToPlot[i])*(height * 9.0/32), height * (9.0/16) + sin(angle + PI * dataToPlot[i])*(height * 9.0/32));
      }
      angle += (2 * PI * dataToPlot[i]);
    }
    fill(0);
    textSize(width * (1.0/20));
    text("Snow Per Month", width * (1.0/4), height * (1.0/4));
    textSize(width * (1.0/40));
    text("From " + startYear + " - " + endYear, width * (1.0/ 4), height * (5.0/16));
    
    myLegend.display(monthColors);
  } 
  
}



class Legend {
  
  void display(color [] colors) {
    fill(0);
    textSize(width * (1.0/40));
    text("Legend", width * (1.0/10), height * (1.0/2));
    line(width * (1.0/10 - 1.0/20), height * (17.0/32), width * (1.0/10 + 1.0/20), height * (17.0/32));
    String [] names = {"January", "Febuary", "March", "April", "May", "June", "July", "August", "September", "Octorber", "November", "December"};
    float y = height * (18.0/32);
    float x = width * (1.0/20);
    for (int i =0; i < colors.length; i++) {
      textAlign(CORNER);
      fill(colors[i]);
      rect(x, y, height * (1.0/32), height * (1.0/32));
      fill(0);
      text(names[i], x + width * (1.0/40), y + height * (1.0/32));
      y += height * (1.0/16);
      if (i == 5) {
        y = height * (18.0/32);
        x += width * (15.0/80);
      }
    }
  }  
}
