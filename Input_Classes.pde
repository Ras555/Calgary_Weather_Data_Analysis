void mousePressed() {
  myDisplay.mouseClick();
  myDisplay.display();
}

int inputYear(String phrase, int minYear, int maxYear) {
  String input = JOptionPane.showInputDialog(phrase);
  int year = validate(input, minYear, maxYear);
  return year;
}

int validate(String input, int minYear, int maxYear) {
  boolean integer = true;
  boolean range = true;
  int result = 0;
  do {
    range = false;
    try {
      result = Integer.parseInt(input);
    }catch(Exception e) {
      input = JOptionPane.showInputDialog("Invalid Input. Please Try again.");
      integer = false;
    }
    if (integer) {
      if(result <= maxYear && result >= minYear) {
        range = true;
      }
      else {
        input = JOptionPane.showInputDialog("Invalid Input. Please try again.");
      }
    }
  }while(!range && integer);
  return result;
}



int findYearIndex(int year, int type) {
  if (type > 0) {
    for(int i = 0; i < data.size(); i++) {
      if(data.get(i).d.Year == year) {
        return i;
      }
    }
  }
  else {
    for (int i = data.size() - 1; i >= 0; i--) {
      if (data.get(i).d.Year == year) {
        return i;
      }
    }
  }
  return -1;
}
