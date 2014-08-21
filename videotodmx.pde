/**
 * Paletize
 * by Julian Adenauer  
 * 
 * Get a video and divide it into segments. 
 * Get the mean color for each segment and match this color
 * to the closest neighbor in a given palett. 
 */

import processing.video.*;

Movie mov;

PixelBoxArray boxes;

void setup() {
  mov = new Movie(this, "Rolls Royce 01.mov");
  size(1142, 412);
  noStroke();
  
  mov.loop();

  boxes = new PixelBoxArray();

  // numX, numY, offsetX, offsetY, length
  boxes.generate(11, 3, 100, 50, 80);  

  boxes.startRecording();
}

// Display values from movie
void draw() {
  if (mov.available() == true) {
    mov.read();
    mov.loadPixels();
    boxes.update(mov);
  }

  background(255);
  
  // draw the video
  image(mov, 0, 0);
  
  // draw the boxes
  boxes.draw();
  
}

void keyPressed() {
  boxes.stopRecording();
  exit(); // Stops the program
}





