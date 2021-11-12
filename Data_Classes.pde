class Date {
  
  int Month;
  int Year;
  
  Date (int m, int y) {
    Month = m;
    Year = y;
  }
  
}

class TempData {
  Date d;
  float minTemp;
  float maxTemp;
  float snowFall;
  
  TempData(int m, int y, float max, float min, float snow) {
    d = new Date(m, y);
    minTemp = min;
    maxTemp = max;
    snowFall = snow;
  }
}
