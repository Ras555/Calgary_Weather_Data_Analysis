

class FileIO {
  Table dataTable;
  FileIO() {
    dataTable = loadTable("CalgaryWeather.csv", "header");
  }
  
  ArrayList writeData(ArrayList data) {
    for (int i = 0; i < dataTable.getRowCount(); i++) {
      TableRow row = dataTable.getRow(i);
      int Month = row.getInt("Month");
      int Year = row.getInt("Year");
      float minTemp = row.getFloat("Min Temperature");
      float maxTemp = row.getFloat("Max Temperature");
      float snow = row.getFloat("Snow Fall");
      data.add(new TempData(Month, Year, maxTemp, minTemp, snow));
    }
    return data;
  } //<>//
}
