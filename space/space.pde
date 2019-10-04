import processing.serial.*;

import gifAnimation.*;
import processing.sound.*;

// variables for arduino
Serial myPort;
String input;
int xPos;
int yPos;
int onOff;
int button;

PImage space;

float x = 720;
float y = 450;
float min_zoom_w = 1440;
float max_zoom_w = 15840;
float w_space= 3000;
float h_space = 900;
float w_planet = 150;
float h_planet = 150;

// order of planets: mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
boolean symphony = false;
Gif planets[] = new Gif[8];
SoundFile sounds[] = new SoundFile[8];
Gif curr_planet;
SoundFile curr_sound;
boolean prev_planet_sound = false;
float volume = 0.1;
int counter = -1;

// variables for symphony mode
boolean show0 = false;
boolean show1 = false;
boolean show2 = false;
boolean show3 = false;
boolean show4 = false;
boolean show5 = false;
boolean show6 = false;
boolean show7 = false;
float vol0 = 0.1;
float vol1 = 0.3;
float vol2 = 0.5;
float vol3 = 0.7;
float vol4 = 1;
float vol5 = 0.6;
float vol6 = 0.3;
float vol7 = 0.1;
float w0 = 150;
float w1 = 150;
float w2 = 150;
float w3 = 150;
float w4 = 150;
float w5 = 150;
float w6 = 150;
float w7 = 150;
float h0 = 150;
float h1 = 150;
float h2 = 150;
float h3 = 150;
float h4 = 150;
float h5 = 150;
float h6 = 150;
float h7 = 150;
float x0 = -550;
float x1 = -350;
float x2 = -200;
float x3 = 0;
float x4 = 400;
float x5 = 700;
float x6 = 1200;
float x7 = 1800;

void setup() {
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[3], 115200);

  fullScreen();
  background(0);
  
  space = loadImage("space.jpg");
  for (int i = 0; i < 8; i++) {
    String planet = "p" + i + ".gif";
    String sound = "p" + i + ".wav";
    planets[i] = new Gif(this, planet);
    planets[i].play();
    sounds[i] = new SoundFile(this, sound);
  }
}

void draw() {
  // read input
  if (myPort.available() > 0){
    input = myPort.readString();
    String[] inputList = split(input, ",");
    xPos = int(inputList[0]);
    yPos = int(inputList[1]);
    button = int(inputList[2]);
    onOff = int(inputList[3]);
    print(xPos + "," + yPos + "," + button + "," + onOff + '\n');
  }
    
  imageMode(CENTER);
  image(space, x, y, w_space, h_space);
  
  if (counter != -1 && symphony == false){
    image(curr_planet, x, y, w_planet, h_planet);
    curr_sound.amp(volume);
  }
  
  if (counter != -1 && symphony == true){
    if (show0 == true){
      vol0 = 1 - (abs(700-x0)/1300);
      image(planets[0], x0, y, w0, h0);
      sounds[0].amp(vol0);
    }
    if (show1 == true){
      vol1 = 1 - (abs(700-x1)/1300);
      image(planets[1], x1, y, w1, h1);
      sounds[1].amp(vol1);
    }
    if (show2 == true){
      vol2 = 1 - (abs(700-x2)/1300);
      image(planets[2], x2, y, w2, h2);
      sounds[2].amp(vol2);
    }
    if (show3 == true){
      vol3 = 1 - (abs(700-x3)/1300);
      image(planets[3], x3, y, w3, h3);
      sounds[3].amp(vol3);
    }
    if (show4 == true){
      vol4 = 1 - (abs(700-x4)/1300);
      image(planets[4], x4, y, w4, h4);
      sounds[4].amp(vol4);
    }
    if (show5 == true){
      vol5 = 1 - (abs(700-x5)/1300);
      image(planets[5], x5, y, w5, h5);
      sounds[5].amp(vol5);
    }
    if (show6 == true){
      vol6 = 1 - (abs(700-x6)/1300);
      image(planets[6], x6, y, w6, h6);
      sounds[6].amp(vol6);
    }
    if (show7 == true){
      vol7 = 1 - (abs(700-x7)/1300);
      image(planets[7], x7, y, w7, h7);
      sounds[7].amp(vol7);
    }
  }
  
   if (xPos < 1600 && symphony == false) x = x + 8;
  if (xPos > 1900 && symphony == false) x = x - 8;
  if (xPos < 1600 && symphony == true){
    x = x + 8;
    x0 = x0 + 8;
    x1 = x1 + 8;
    x2 = x2 + 8;
    x3 = x3 + 8;
    x4 = x4 + 8;
    x5 = x5 + 8;
    x6 = x6 + 8;
    x7 = x7 + 8;
  }
  if (xPos > 1900 && symphony == true){
    x = x - 8;
    x0 = x0 - 8;
    x1 = x1 - 8;
    x2 = x2 - 8;
    x3 = x3 - 8;
    x4 = x4 - 8;
    x5 = x5 - 8;
    x6 = x6 - 8;
    x7 = x7 - 8;
  }
  
  // for some reason it is backwards for y..
  if (yPos < 1700 && w_space < max_zoom_w && symphony == false){
    w_space = w_space * 1.2;
    h_space = h_space * 1.2;
    w_planet = w_planet * 1.2;
    h_planet = h_planet * 1.2;
    volume = volume + 0.15;
  }
  if (yPos > 2000 && w_space > min_zoom_w && symphony == false){
    w_space = w_space / 1.2;
    h_space = h_space / 1.2;
    w_planet = w_planet / 1.2;
    h_planet = h_planet / 1.2;
    volume = volume - 0.15;
  }
  if (yPos < 1700 && symphony == true){
    w_space = w_space * 1.2;
    h_space = h_space * 1.2;
  }
  if (yPos > 2000 && symphony == true){
    w_space = w_space / 1.2;
    h_space = h_space / 1.2;
  }
   
  if (button == 1 && symphony == false){
    if (counter == 7) counter = -1;
    if (prev_planet_sound == true) curr_sound.stop();
    prev_planet_sound = false;
    counter++;
    curr_planet = planets[counter];
    curr_sound = sounds[counter];
    curr_sound.loop();
    prev_planet_sound = true;
  }
  if (button == 1  && symphony == true){
    if (counter == 7) counter = -1;
    counter++;
    if (counter == 0){
      show0 = true;
      sounds[0].loop();
    }
    if (counter == 1){
      show1 = true;
      sounds[1].loop();
    }
    if (counter == 2){
      show2 = true;
      sounds[2].loop();
    }
    if (counter == 3){
      show3 = true;
      sounds[3].loop();
    }
    if (counter == 4){
      show4 = true;
      sounds[4].loop();
    }
    if (counter == 5){
      show5 = true;
      sounds[5].loop();
    }
    if (counter == 6){
      show6 = true;
      sounds[6].loop();
    }
    if (counter == 7){
      show7 = true;
      sounds[7].loop();
    }
  }
  if (onOff > 0) symphony = true;
}
