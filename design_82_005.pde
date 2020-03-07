// Design from page 82 of Islamic Geometric Patterns by Eric Broug
// Thames & Hudson 
// ISBN 978-0-500-28721-7
// Code by Rupert Russell
// 07 March 2020
// Thanks to: COLLISION DETECTION by Jeff Thompson  
// http://jeffreythompson.org/collision-detection/index.php

int i = 0;
float scale = 600;
int designWeight = 3;

float[] saveIntersectionX;
float[] saveIntersectionY;

float[] saveCircleX;
float[] saveCircleY;

boolean displayGuideLines = true;
float[] xx, yy; // used to store working intersection test lines

// use the Lineline class to create multiple myLine objects
Lineline myLineline0;
Lineline myLineline1;
Lineline myLineline2;
Lineline myLineline3;
Lineline myLineline4;
Lineline myLineline5;
Lineline myLineline6;
Lineline myLineline7;
Lineline myLineline8;
Lineline myLineline9;
Lineline myLineline10;
Lineline myLineline11;
Lineline myLineline12;
Lineline myLineline13;
Lineline myLineline14;
Lineline myLineline15;
Lineline myLineline16;
Lineline myLineline17;
Lineline myLineline18;
Lineline myLineline19;
Lineline myLineline20;


// use the CalculatePoints class to create multiple myCircle objects
CalculatePoints myCircle1;
CalculatePoints myCircle2;
CalculatePoints myCircle3;
import processing.pdf.*;

void setup() {
  background(255);

  noFill();
  noLoop(); 
  size(900, 900); 
  smooth();
  noFill();
  rectMode(CENTER);
  ellipseMode(CENTER);
  noFill();
  //  beginRecord(PDF, "design_82_v005.pdf");

  saveIntersectionX = new float[100]; // store x Points for the intersections
  saveIntersectionY = new float[100]; // store y Points for the intersections

  saveCircleX = new float[100]; // store x Points for the circles
  saveCircleY = new float[100]; // store y Points for the circles

  xx = new float[100];
  yy = new float[100];
}

void draw() {
  background(255);

  translate(width/2, height/2);
  strokeWeight(1);
  step1(displayGuideLines);
  step2(displayGuideLines);
  step2a(displayGuideLines);
  step3(displayGuideLines);
  step6(displayGuideLines);
  step7(true);

  //// showTestPoint();
  numberCircles();
  numberIntersections();

  //strokeWeight(designWeight);
  save("design_82_v005.png");
  //endRecord();
  // exit();
}

// Construct the Lineline object
class Lineline {
  int index;  // hold the index numbers for the intersection use to store points in array
  float x1;
  float y1;
  float x2;
  float y2;
  float x3;
  float y3;
  float x4;
  float y4;
  boolean displayLine;
  boolean displayInterection;
  char colour;
  float weight;
  float intersectionX;
  float intersectionY;

  // The Constructor is defined with arguments.
  Lineline(int tempIndex, float tempX1, float tempY1, float tempX2, float tempY2, float tempX3, float tempY3, float tempX4, float tempY4, boolean tempDisplayLine, boolean tempDisplayInterection, char tempColour, float tempWeight) {
    index =tempIndex;
    x1 = tempX1;
    y1 = tempY1;
    x2 = tempX2;
    y2 = tempY2;
    x3 = tempX3;
    y3 = tempY3;
    x4 = tempX4;
    y4 = tempY4;
    displayLine = tempDisplayLine;
    displayInterection = tempDisplayInterection;
    colour = tempColour;
    weight = tempWeight;
  }

  boolean displayIntersection() {
    // LINE/LINE 
    // Thanks to: COLLISION DETECTION by Jeff Thompson  
    // http://jeffreythompson.org/collision-detection/index.php
    // from http://jeffreythompson.org/collision-detection/line-line.php

    // calculate the distance to intersection point
    float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

    // if uA and uB are between 0-1, lines are colliding
    if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {

      // optionally, draw a circle where the lines meet
      intersectionX = x1 + (uA * (x2-x1));
      intersectionY = y1 + (uA * (y2-y1));
      noFill();

      switch(colour) {
      case 'r': 
        stroke(255, 0, 0);
        break;
      case 'g': 
        stroke(0, 255, 0);
        break;
      case 'b': 
        stroke(0, 0, 255);
        break;        
      case 'm': 
        stroke(255, 0, 255);
        break;    
      default:
        stroke(0, 0, 0); // black
        break;
      }

      if (displayLine) {
        strokeWeight(weight);
        line(x1, y1, x2, y2);
        line(x3, y3, x4, y4);
      }

      saveIntersectionX[index] = intersectionX;
      saveIntersectionY[index] = intersectionY;

      if (displayInterection) {
        circle(intersectionX, intersectionY, 10);
      }

      strokeWeight(designWeight);
      stroke(0, 0, 0);  // colour of final design uncomment to use 'case' to set individual design elements to different colours 

      return true ;
    }
    return false;
  }
}
//  end of constructor for Lineline class

// Start of Constructor for CalculatePoints defined with arguments
// calculate points around a circle and store n points around a circle
class CalculatePoints {
  int numPoints;
  float scale;
  float h;
  float k;
  int counterStart;
  boolean displayCrcles;

  // The Constructor is defined with arguments and sits inside the class 
  CalculatePoints(int tempCounterStart, int tempNumPoints, float tempScale, float tempH, float tempK, boolean tmpDisplayCrcles) {
    numPoints = tempNumPoints;
    scale = tempScale;
    h = tempH;
    k = tempK;
    counterStart = tempCounterStart;
    displayCrcles = tmpDisplayCrcles;

    int counter = counterStart;

    double step = radians(360/numPoints); 
    float r =  scale / 2 ;
    for (float theta=0; theta < 2 * PI; theta += step) {
      float x = h + r * cos(theta);
      float y = k - r * sin(theta); 

      // store the calculated coordinates
      saveCircleX[counter] = x;
      saveCircleY[counter] = y;
      if (displayCrcles) {
        circle(saveCircleX[counter], saveCircleY[counter], 10);  // draw small circles to show points
      }
      counter ++;
    }
  }
} // End of Constructor for CalculatePoints

void step1(boolean displayGuideLines) {
  // Guide Lines
  myCircle1 = new CalculatePoints(0, 12, scale, 0, 0, displayGuideLines);

  //Spokes
  if (displayGuideLines) {
    for (int i=0; i < 13; i ++) { 
      line(saveCircleX[0 + i], saveCircleY[0 + i], saveCircleX[6 + i], saveCircleY[6 + i]);
    }
  }

  // Circle Circle inside the square
  if (displayGuideLines) {
    circle(0, 0, scale);
  }
} // end step1

void step2(boolean displayGuideLines) {
  // inner Hexagon 1
  strokeWeight(2);
  if (displayGuideLines) {
    line(saveCircleX[0], saveCircleY[0], saveCircleX[2], saveCircleY[2]); 
    line(saveCircleX[2], saveCircleY[2], saveCircleX[4], saveCircleY[4]); 
    line(saveCircleX[4], saveCircleY[4], saveCircleX[6], saveCircleY[6]); 
    line(saveCircleX[6], saveCircleY[6], saveCircleX[8], saveCircleY[8]); 
    line(saveCircleX[8], saveCircleY[8], saveCircleX[10], saveCircleY[10]);   
    line(saveCircleX[10], saveCircleY[10], saveCircleX[0], saveCircleY[0]);
  }


  // inner Hexagon 2
  if (displayGuideLines) {
    line(saveCircleX[1], saveCircleY[1], saveCircleX[3], saveCircleY[3]); 
    line(saveCircleX[3], saveCircleY[3], saveCircleX[5], saveCircleY[5]); 
    line(saveCircleX[5], saveCircleY[5], saveCircleX[7], saveCircleY[7]); 
    line(saveCircleX[7], saveCircleY[7], saveCircleX[9], saveCircleY[9]); 
    line(saveCircleX[9], saveCircleY[9], saveCircleX[11], saveCircleY[11]);   
    line(saveCircleX[11], saveCircleY[11], saveCircleX[1], saveCircleY[1]);
  }
} // end step2

void step2a(boolean displayGuideLines) {
  // inner Triangles
  strokeWeight(1);
  if (displayGuideLines) {
    line(saveCircleX[11], saveCircleY[11], saveCircleX[3], saveCircleY[3]); 
    line(saveCircleX[3], saveCircleY[3], saveCircleX[7], saveCircleY[7]); 
    line(saveCircleX[7], saveCircleY[7], saveCircleX[11], saveCircleY[11]); 
    line(saveCircleX[1], saveCircleY[1], saveCircleX[5], saveCircleY[5]); 
    line(saveCircleX[5], saveCircleY[5], saveCircleX[9], saveCircleY[9]);   
    line(saveCircleX[9], saveCircleY[9], saveCircleX[1], saveCircleY[1]);
  }
}

void step3(boolean displayGuideLines) {
  // calculate the 12 ringed intersections
  float x1, y1, x2, y2, x3, y3, x4, y4;

  x1 = saveCircleX[0];
  y1 = saveCircleY[0];
  x2 = saveCircleX[6];
  y2 = saveCircleY[6];
  x3 = saveCircleX[1];
  y3 = saveCircleY[1];
  x4 = saveCircleX[11];
  y4 = saveCircleY[11];
  myLineline0 = new Lineline(0, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline0.displayIntersection();

  x1 = saveCircleX[1];
  y1 = saveCircleY[1];
  x2 = saveCircleX[7];
  y2 = saveCircleY[7];
  x3 = saveCircleX[0];
  y3 = saveCircleY[0];
  x4 = saveCircleX[2];
  y4 = saveCircleY[2];
  myLineline1 = new Lineline(1, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline1.displayIntersection();

  x1 = saveCircleX[2];
  y1 = saveCircleY[2];
  x2 = saveCircleX[8];
  y2 = saveCircleY[8];
  x3 = saveCircleX[1];
  y3 = saveCircleY[1];
  x4 = saveCircleX[3];
  y4 = saveCircleY[3];
  myLineline2 = new Lineline(2, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline2.displayIntersection();

  x1 = saveCircleX[3];
  y1 = saveCircleY[3];
  x2 = saveCircleX[9];
  y2 = saveCircleY[9];
  x3 = saveCircleX[2];
  y3 = saveCircleY[2];
  x4 = saveCircleX[4];
  y4 = saveCircleY[4];
  myLineline3 = new Lineline(3, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline3.displayIntersection();

  x1 = saveCircleX[3];
  y1 = saveCircleY[3];
  x2 = saveCircleX[5];
  y2 = saveCircleY[5];
  x3 = saveCircleX[4];
  y3 = saveCircleY[4];
  x4 = saveCircleX[10];
  y4 = saveCircleY[10];
  myLineline4 = new Lineline(4, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline4.displayIntersection();

  x1 = saveCircleX[4];
  y1 = saveCircleY[4];
  x2 = saveCircleX[6];
  y2 = saveCircleY[6];
  x3 = saveCircleX[5];
  y3 = saveCircleY[5];
  x4 = saveCircleX[11];
  y4 = saveCircleY[11];
  myLineline5 = new Lineline(5, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline5.displayIntersection();

  x1 = saveCircleX[5];
  y1 = saveCircleY[5];
  x2 = saveCircleX[7];
  y2 = saveCircleY[7];
  x3 = saveCircleX[6];
  y3 = saveCircleY[6];
  x4 = saveCircleX[0];
  y4 = saveCircleY[0];
  myLineline6 = new Lineline(6, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline6.displayIntersection();

  x1 = saveCircleX[6];
  y1 = saveCircleY[6];
  x2 = saveCircleX[8];
  y2 = saveCircleY[8];
  x3 = saveCircleX[7];
  y3 = saveCircleY[7];
  x4 = saveCircleX[1];
  y4 = saveCircleY[1];
  myLineline7 = new Lineline(7, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline7.displayIntersection();

  x1 = saveCircleX[7];
  y1 = saveCircleY[7];
  x2 = saveCircleX[9];
  y2 = saveCircleY[9];
  x3 = saveCircleX[8];
  y3 = saveCircleY[8];
  x4 = saveCircleX[2];
  y4 = saveCircleY[2];
  myLineline8 = new Lineline(8, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline8.displayIntersection();

  x1 = saveCircleX[8];
  y1 = saveCircleY[8];
  x2 = saveCircleX[10];
  y2 = saveCircleY[10];
  x3 = saveCircleX[9];
  y3 = saveCircleY[9];
  x4 = saveCircleX[3];
  y4 = saveCircleY[3];
  myLineline9 = new Lineline(9, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline9.displayIntersection();

  x1 = saveCircleX[9];
  y1 = saveCircleY[9];
  x2 = saveCircleX[11];
  y2 = saveCircleY[11];
  x3 = saveCircleX[10];
  y3 = saveCircleY[10];
  x4 = saveCircleX[4];
  y4 = saveCircleY[4];
  myLineline10 = new Lineline(10, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'b', 1);  // top of line
  myLineline10.displayIntersection();

  x1 = saveCircleX[10];
  y1 = saveCircleY[10];
  x2 = saveCircleX[0];
  y2 = saveCircleY[0];
  x3 = saveCircleX[11];
  y3 = saveCircleY[11];
  x4 = saveCircleX[5];
  y4 = saveCircleY[5];
  myLineline11 = new Lineline(11, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline11.displayIntersection();

  // join the 12 ringed intersections //
  strokeWeight(1);
  if (displayGuideLines) {
    for ( i = 0; i < 11; i++) {
      line(saveIntersectionX[i], saveIntersectionY[i], saveIntersectionX[i+1], saveIntersectionY[i+1]);
    }
    line(saveIntersectionX[11], saveIntersectionY[11], saveIntersectionX[0], saveIntersectionY[0]);
  }
  stroke(0, 0, 0); // black
} //end step 3

void step6(boolean displayGuideLines) {
  strokeWeight(1);
  // inner Star
  if (displayGuideLines) {
    line(saveCircleX[0], saveCircleY[0], saveCircleX[4], saveCircleY[4]);
    line(saveCircleX[4], saveCircleY[4], saveCircleX[8], saveCircleY[8]);
    line(saveCircleX[8], saveCircleY[8], saveCircleX[0], saveCircleY[0]);
    line(saveCircleX[2], saveCircleY[2], saveCircleX[6], saveCircleY[6]); 
    line(saveCircleX[6], saveCircleY[6], saveCircleX[10], saveCircleY[10]); 
    line(saveCircleX[10], saveCircleY[10], saveCircleX[2], saveCircleY[2]);
  }
}


void step7(boolean displayGuideLines) {
  float x1, y1, x2, y2, x3, y3, x4, y4;
  strokeWeight(1);
  // anged Parallel Lines 
  // Calculate intersection Points
  x1 = saveCircleX[1];
  y1 = saveCircleY[1];
  x2 = saveCircleX[5];
  y2 = saveCircleY[5];
  x3 = saveCircleX[2];
  y3 = saveCircleY[2];
  x4 = saveCircleX[10];
  y4 = saveCircleY[10];
  myLineline12 = new Lineline(12, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline12.displayIntersection();

  x1 = saveCircleX[0];
  y1 = saveCircleY[0];
  x2 = saveCircleX[8];
  y2 = saveCircleY[8];
  x3 = saveCircleX[9];
  y3 = saveCircleY[9];
  x4 = saveCircleX[5];
  y4 = saveCircleY[5];
  myLineline13 = new Lineline(13, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline13.displayIntersection();

  x1 = saveCircleX[4];
  y1 = saveCircleY[4];
  x2 = saveCircleX[8];
  y2 = saveCircleY[8];
  x3 = saveCircleX[7];
  y3 = saveCircleY[7];
  x4 = saveCircleX[11];
  y4 = saveCircleY[11];
  myLineline14 = new Lineline(14, x1, y1, x2, y2, x3, y3, x4, y4, true, true, 'r', 1);  // top of line
  myLineline14.displayIntersection();

  x1 = saveCircleX[2];
  y1 = saveCircleY[2];
  x2 = saveCircleX[6];
  y2 = saveCircleY[6];
  x3 = saveCircleX[3];
  y3 = saveCircleY[3];
  x4 = saveCircleX[11];
  y4 = saveCircleY[11];
  myLineline15 = new Lineline(15, x1, y1, x2, y2, x3, y3, x4, y4, true, true, 'r', 1);  // top of line
  myLineline15.displayIntersection();




  float deltaX;
  float deltaY;
  // Extend parallel pairs 
  deltaX = saveIntersectionX[12] - saveIntersectionX[13];
  deltaY = saveIntersectionY[12] - saveIntersectionY[13];
  saveIntersectionX[12] =  saveIntersectionX[12] + deltaX;
  saveIntersectionY[12] =  saveIntersectionY[12] + deltaY;
  saveIntersectionX[13] =  saveIntersectionX[13] - deltaX;
  saveIntersectionY[13] =  saveIntersectionY[13] - deltaY;

  deltaX = saveIntersectionX[15] - saveIntersectionX[14];
  deltaY = saveIntersectionY[15] - saveIntersectionY[14];
  saveIntersectionX[15] =  saveIntersectionX[15] + deltaX;
  saveIntersectionY[15] =  saveIntersectionY[15] + deltaY;
  saveIntersectionX[14] =  saveIntersectionX[14] - deltaX;
  saveIntersectionY[14] =  saveIntersectionY[14] - deltaY;

  // Re-Calculate intersection Points for extended lines
  x1 = saveIntersectionX[12];
  y1 = saveIntersectionY[12];
  x2 = saveIntersectionX[13];
  y2 = saveIntersectionY[13];
  x3 = saveIntersectionX[1];
  y3 = saveIntersectionY[1];
  x4 = saveIntersectionX[2];
  y4 = saveIntersectionY[2];
  myLineline12 = new Lineline(12, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline12.displayIntersection();

  x1 = saveIntersectionX[12];
  y1 = saveIntersectionY[12];
  x2 = saveIntersectionX[13];
  y2 = saveIntersectionY[13];
  x3 = saveIntersectionX[8];
  y3 = saveIntersectionY[8];
  x4 = saveIntersectionX[9];
  y4 = saveIntersectionY[9];
  myLineline13 = new Lineline(13, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline13.displayIntersection();

  x1 = saveIntersectionX[14];
  y1 = saveIntersectionY[14];
  x2 = saveIntersectionX[15];
  y2 = saveIntersectionY[15];
  x3 = saveIntersectionX[8];
  y3 = saveIntersectionY[8];
  x4 = saveIntersectionX[7];
  y4 = saveIntersectionY[7];
  myLineline14 = new Lineline(14, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline14.displayIntersection();

  x1 = saveIntersectionX[14];
  y1 = saveIntersectionY[14];
  x2 = saveIntersectionX[15];
  y2 = saveIntersectionY[15];
  x3 = saveIntersectionX[2];
  y3 = saveIntersectionY[2];
  x4 = saveIntersectionX[3];
  y4 = saveIntersectionY[3];
  myLineline15 = new Lineline(15, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  // top of line
  myLineline15.displayIntersection();
  
  if (displayGuideLines) {
    stroke(255, 0, 0); // red
    strokeWeight(3); 

    line(saveIntersectionX[12], saveIntersectionY[12], saveIntersectionX[13], saveIntersectionY[13]);
    line(saveIntersectionX[14], saveIntersectionY[14], saveIntersectionX[15], saveIntersectionY[15]);
  }

  stroke(0, 0, 0); // black
  strokeWeight(1);
}

void numberCircles() {
  textSize(32);
  fill(0);
  for (int i = 0; i < 12; i = i+1) {
    text(i, saveCircleX[i], saveCircleY[i]);
  }
  noFill();
}



void numberIntersections() {
  textSize(32);
  fill(255, 0, 0);
  for (int i = 0; i < 16; i = i+1) {
    text(i, saveIntersectionX[i], saveIntersectionY[i]);
  }
  noFill();
}



void showTestPoint() {

  println("i = " + i);
  circle(saveIntersectionX[i], saveIntersectionY[i], 25);
  noFill();
}


void mousePressed() {
  if (mouseButton == LEFT) {
    i = i + 1;
  }
}
