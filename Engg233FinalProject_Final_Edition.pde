import javax.swing.JOptionPane;
ArrayList <TempData> data = new ArrayList<TempData>(0);
Display myDisplay;

void setup() {
  fullScreen();
  FileIO file = new FileIO();
  data = file.writeData(data);
  myDisplay = new Display();
  
  myDisplay.display();
}



void draw() {
}
