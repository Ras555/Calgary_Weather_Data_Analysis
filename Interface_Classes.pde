class Button {
  float x;
  float y;
  float tall;
  float wide;
  String Shape;
  boolean set;
  color bcolor;
  String title;
  
  Button(float tempx, float tempy, float w, float t, boolean start, String tempt) {
    x = tempx;
    y = tempy;
    tall = t;
    wide = w;
    Shape = "rect";
    set = start;
    title = tempt;
  }
  
  Button(float tempx, float tempy, float d, boolean start, String tempt) {
    x = tempx;
    y = tempy;
    tall = d;
    Shape = "circ";
    set = start;
    title = tempt;
  }
  
  void display() {
    if (set)
      bcolor = color(#4BCE73);
    else {
      bcolor = color(#238641);
    }
    if (Shape.equals("rect")) {
      fill(bcolor);
      rect(x, y, wide, tall);
      fill(0);
      textAlign(CENTER);
      textSize(width * (1.0/64));
      text(title, x + wide/2, y + tall/1.5);
    }
    else if (Shape.equals("circ")) {
      fill(bcolor);
      ellipse(x, y, tall, tall);
      fill(0);
      textAlign(CENTER);
      textSize(width * (1.0/128));
      text(title, x, y);
    }
  }
  
  boolean pressed() {
    if (Shape.equals("rect")) {
      if (mouseX > x && mouseX < x + wide && mouseY > y && mouseY < y + tall) {
        set = !set;
        if (set) {
          bcolor = color(#4BCE73);
        }
        else {
          bcolor = color(#238641);
        }
        return true;
      }
    }
    else {
      if (mouseX > -sqrt((6*tall)- sq(mouseY - y)) + x && mouseX < sqrt((6*tall) - sq(mouseY - y)) + x && mouseY > -sqrt((6*tall)- sq(mouseX - x)) + y && mouseY < sqrt((6*tall)- sq(mouseX - x)) + y) {
        set = !set;
        if (set) {
          bcolor = color(#4BCE73);
        }
        else {
          bcolor = color(#238641);
        }
        return true;
      }
    }
    return false;
  }
}










class Switch {
  
  Button [] buttons;
  float x;
  float y;
  float wide;
  float tall;
  int setting;
  String [] names;
  
  Switch(float tempx, float tempy, float w, float t, String [] n) {
    setting = 0;
    names = n;
    buttons = new Button [names.length];
    x = tempx;
    y = tempy;
    wide = w;
    tall = t;
    float xpos = x;
    float ypos = y;
    for(int i = 0; i < buttons.length; i++) {
      boolean start = false;
      if (i == 0) {
        start = true;
      }
      buttons[i] = new Button(xpos, ypos, wide, tall/buttons.length, start, names[i]);
      ypos += tall/buttons.length;
    }
  }
  
  void display() {
    for (Button b: buttons) {
      b.display();
    }    
  }
  
  void pressed() {
    int pressed = 0;
    boolean trigger = false;
    for(int i = 0; i < buttons.length; i++) {
      trigger = buttons[i].pressed();
      if(trigger) {
        pressed = i;
        setting = i;
        break;
      }
    }
    if (trigger) {
      for(int i = 0; i < buttons.length; i++) {
        if (i != pressed) {
          buttons[i].set = false;
        }
      }
      buttons[pressed].set = true;
    }
      
  }
}







class Trigger {
  float x;
  float y;
  float tall;
  float wide;
  String title;
  
  Trigger(float tempx, float tempy, float w, float t, String tempt) {
    x = tempx;
    y = tempy;
    tall = t;
    wide = w;
    title = tempt;
  }
  
  void display() {
    fill(#238641);
    rect(x, y, wide, tall);
    fill(0);
    textAlign(CENTER);
    textSize(width * (1.0/64));
    text(title, x + wide/2, y + tall/1.5);
  }
  
  boolean pressed() {
    if (mouseX > x && mouseX < x + wide && mouseY > y && mouseY < y + tall) {
      return true;
    }
    return false;
  }
}
