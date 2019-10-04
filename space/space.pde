import gifAnimation.*;
import processing.sound.*;

PImage space;

float x = 720;
float y = 450;
float min_zoom_w = 1440;
float max_zoom_w = 15840;
float w_space= 1440;
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
float vol1 = 0.1;
float vol2 = 0.1;
float vol3 = 0.1;
float vol4 = 0.1;
float vol5 = 0.1;
float vol6 = 0.1;
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

void setup() {
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
  imageMode(CENTER);
  image(space, x, y, w_space, h_space);
  
  if (counter != -1 && symphony == false){
    image(curr_planet, x, y, w_planet, h_planet);
    curr_sound.amp(volume);
  }
  
  if (counter != -1 && symphony == true){
    if (show0 == true){
      image(planets[0], 100, y, w0, h0);
      sounds[0].amp(vol0);
    }
    if (show1 == true){
      image(planets[1], 250, y, w1, h1);
      sounds[1].amp(vol1);
    }
    if (show2 == true){
      image(planets[2], 400, y, w2, h2);
      sounds[2].amp(vol2);
    }
    if (show3 == true){
      image(planets[3], 550, y, w3, h3);
      sounds[3].amp(vol3);
    }
    if (show4 == true){
      image(planets[4], 700, y, w4, h4);
      sounds[4].amp(vol4);
    }
    if (show5 == true){
      image(planets[5], 850, y, w5, h5);
      sounds[5].amp(vol5);
    }
    if (show6 == true){
      image(planets[6], 1000, y, w6, h6);
      sounds[6].amp(vol6);
    }
    if (show7 == true){
      image(planets[7], 1150, y, w7, h7);
      sounds[7].amp(vol7);
    }
  }
}

void keyPressed() {
  if (keyCode == CONTROL) symphony = true;
  if (keyCode == LEFT && symphony == false) x = x + 8;
  if (keyCode == RIGHT && symphony == false) x = x - 8;
  if (keyCode == LEFT && symphony == true){
    x = x + 8;
  }
  if (keyCode == RIGHT && symphony == true){
    x = x - 8;
  }
  if (keyCode == UP && w_space < max_zoom_w && symphony == false){
    w_space = w_space * 1.2;
    h_space = h_space * 1.2;
    w_planet = w_planet * 1.2;
    h_planet = h_planet * 1.2;
    volume = volume + 0.15;
  }
  if (keyCode == DOWN && w_space > min_zoom_w && symphony == false){
    w_space = w_space / 1.2;
    h_space = h_space / 1.2;
    w_planet = w_planet / 1.2;
    h_planet = h_planet / 1.2;
    volume = volume - 0.15;
  }
  if (keyCode == UP && symphony == true){
    w_space = w_space * 1.2;
    h_space = h_space * 1.2;
  }
  if (keyCode == DOWN && symphony == true){
  }
  if (keyCode == SHIFT && symphony == false){
    if (counter == 7) counter = -1;
    if (prev_planet_sound == true) curr_sound.stop();
    prev_planet_sound = false;
    counter++;
    curr_planet = planets[counter];
    curr_sound = sounds[counter];
    curr_sound.loop();
    prev_planet_sound = true;
  }
  if (keyCode == SHIFT && symphony == true){
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
}
