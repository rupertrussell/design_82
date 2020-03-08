// Design from page 82 of Islamic Geometric Patterns by Eric Broug
// Thames & Hudson 
// ISBN 978-0-500-28721-7
// Code by Rupert Russell
// 07 March 2020
// Thanks to: COLLISION DETECTION by Jeff Thompson  
// http://jeffreythompson.org/collision-detection/index.php

int i = 0;
float scale = 600;
int designWeight = 6;

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

Lineline myLineline21;
Lineline myLineline22;
Lineline myLineline23;
Lineline myLineline24;
Lineline myLineline25;
Lineline myLineline26;
Lineline myLineline27;
Lineline myLineline28;
Lineline myLineline29;
Lineline myLineline30;

Lineline myLineline31;
Lineline myLineline32;
Lineline myLineline33;
Lineline myLineline34;
Lineline myLineline35;
Lineline myLineline36;
Lineline myLineline37;
Lineline myLineline38;
Lineline myLineline39;
Lineline myLineline40;

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
  step7a(true);
  step7b(true);
  step8a(true);
  step8b(true);

  step9a(true);
  step9b(true);

  //// showTestPoint();
  numberCircles();
  numberIntersections();

  strokeWeight(designWeight);
  save("design_82_v014.png");
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

      // strokeWeight(designWeight);
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
  strokeWeight(1);
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
  myLineline0 = new Lineline(0, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline0.displayIntersection();

  x1 = saveCircleX[1];
  y1 = saveCircleY[1];
  x2 = saveCircleX[7];
  y2 = saveCircleY[7];
  x3 = saveCircleX[0];
  y3 = saveCircleY[0];
  x4 = saveCircleX[2];
  y4 = saveCircleY[2];
  myLineline1 = new Lineline(1, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline1.displayIntersection();

  x1 = saveCircleX[2];
  y1 = saveCircleY[2];
  x2 = saveCircleX[8];
  y2 = saveCircleY[8];
  x3 = saveCircleX[1];
  y3 = saveCircleY[1];
  x4 = saveCircleX[3];
  y4 = saveCircleY[3];
  myLineline2 = new Lineline(2, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline2.displayIntersection();

  x1 = saveCircleX[3];
  y1 = saveCircleY[3];
  x2 = saveCircleX[9];
  y2 = saveCircleY[9];
  x3 = saveCircleX[2];
  y3 = saveCircleY[2];
  x4 = saveCircleX[4];
  y4 = saveCircleY[4];
  myLineline3 = new Lineline(3, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline3.displayIntersection();

  x1 = saveCircleX[3];
  y1 = saveCircleY[3];
  x2 = saveCircleX[5];
  y2 = saveCircleY[5];
  x3 = saveCircleX[4];
  y3 = saveCircleY[4];
  x4 = saveCircleX[10];
  y4 = saveCircleY[10];
  myLineline4 = new Lineline(4, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline4.displayIntersection();

  x1 = saveCircleX[4];
  y1 = saveCircleY[4];
  x2 = saveCircleX[6];
  y2 = saveCircleY[6];
  x3 = saveCircleX[5];
  y3 = saveCircleY[5];
  x4 = saveCircleX[11];
  y4 = saveCircleY[11];
  myLineline5 = new Lineline(5, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline5.displayIntersection();

  x1 = saveCircleX[5];
  y1 = saveCircleY[5];
  x2 = saveCircleX[7];
  y2 = saveCircleY[7];
  x3 = saveCircleX[6];
  y3 = saveCircleY[6];
  x4 = saveCircleX[0];
  y4 = saveCircleY[0];
  myLineline6 = new Lineline(6, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline6.displayIntersection();

  x1 = saveCircleX[6];
  y1 = saveCircleY[6];
  x2 = saveCircleX[8];
  y2 = saveCircleY[8];
  x3 = saveCircleX[7];
  y3 = saveCircleY[7];
  x4 = saveCircleX[1];
  y4 = saveCircleY[1];
  myLineline7 = new Lineline(7, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline7.displayIntersection();

  x1 = saveCircleX[7];
  y1 = saveCircleY[7];
  x2 = saveCircleX[9];
  y2 = saveCircleY[9];
  x3 = saveCircleX[8];
  y3 = saveCircleY[8];
  x4 = saveCircleX[2];
  y4 = saveCircleY[2];
  myLineline8 = new Lineline(8, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline8.displayIntersection();

  x1 = saveCircleX[8];
  y1 = saveCircleY[8];
  x2 = saveCircleX[10];
  y2 = saveCircleY[10];
  x3 = saveCircleX[9];
  y3 = saveCircleY[9];
  x4 = saveCircleX[3];
  y4 = saveCircleY[3];
  myLineline9 = new Lineline(9, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline9.displayIntersection();

  x1 = saveCircleX[9];
  y1 = saveCircleY[9];
  x2 = saveCircleX[11];
  y2 = saveCircleY[11];
  x3 = saveCircleX[10];
  y3 = saveCircleY[10];
  x4 = saveCircleX[4];
  y4 = saveCircleY[4];
  myLineline10 = new Lineline(10, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'b', 1);  
  myLineline10.displayIntersection();

  x1 = saveCircleX[10];
  y1 = saveCircleY[10];
  x2 = saveCircleX[0];
  y2 = saveCircleY[0];
  x3 = saveCircleX[11];
  y3 = saveCircleY[11];
  x4 = saveCircleX[5];
  y4 = saveCircleY[5];
  myLineline11 = new Lineline(11, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline11.displayIntersection();

  // join the 12 ringed intersections //
  strokeWeight(1);
  stroke(255, 0, 0); // red
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

void step7a(boolean displayGuideLines) {
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
  myLineline12 = new Lineline(12, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline12.displayIntersection();

  x1 = saveCircleX[0];
  y1 = saveCircleY[0];
  x2 = saveCircleX[8];
  y2 = saveCircleY[8];
  x3 = saveCircleX[9];
  y3 = saveCircleY[9];
  x4 = saveCircleX[5];
  y4 = saveCircleY[5];
  myLineline13 = new Lineline(13, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline13.displayIntersection();

  x1 = saveCircleX[4];
  y1 = saveCircleY[4];
  x2 = saveCircleX[8];
  y2 = saveCircleY[8];
  x3 = saveCircleX[7];
  y3 = saveCircleY[7];
  x4 = saveCircleX[11];
  y4 = saveCircleY[11];
  myLineline14 = new Lineline(14, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline14.displayIntersection();

  x1 = saveCircleX[2];
  y1 = saveCircleY[2];
  x2 = saveCircleX[6];
  y2 = saveCircleY[6];
  x3 = saveCircleX[3];
  y3 = saveCircleY[3];
  x4 = saveCircleX[11];
  y4 = saveCircleY[11];
  myLineline15 = new Lineline(15, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
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
  myLineline12 = new Lineline(12, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline12.displayIntersection();

  x1 = saveIntersectionX[12];
  y1 = saveIntersectionY[12];
  x2 = saveIntersectionX[13];
  y2 = saveIntersectionY[13];
  x3 = saveIntersectionX[8];
  y3 = saveIntersectionY[8];
  x4 = saveIntersectionX[9];
  y4 = saveIntersectionY[9];
  myLineline13 = new Lineline(13, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline13.displayIntersection();

  x1 = saveIntersectionX[14];
  y1 = saveIntersectionY[14];
  x2 = saveIntersectionX[15];
  y2 = saveIntersectionY[15];
  x3 = saveIntersectionX[8];
  y3 = saveIntersectionY[8];
  x4 = saveIntersectionX[7];
  y4 = saveIntersectionY[7];
  myLineline14 = new Lineline(14, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline14.displayIntersection();

  x1 = saveIntersectionX[14];
  y1 = saveIntersectionY[14];
  x2 = saveIntersectionX[15];
  y2 = saveIntersectionY[15];
  x3 = saveIntersectionX[2];
  y3 = saveIntersectionY[2];
  x4 = saveIntersectionX[3];
  y4 = saveIntersectionY[3];
  myLineline15 = new Lineline(15, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline15.displayIntersection();

  if (displayGuideLines) {
    strokeWeight(1);
    line(saveIntersectionX[12], saveIntersectionY[12], saveIntersectionX[13], saveIntersectionY[13]);
    line(saveIntersectionX[14], saveIntersectionY[14], saveIntersectionX[15], saveIntersectionY[15]);
  }
  stroke(0, 0, 0); // black
  strokeWeight(1);
} // End Step7a

void step7b(boolean displayGuideLines) {
  float x1, y1, x2, y2, x3, y3, x4, y4;
  strokeWeight(1);
  // 2nd set of angled Parallel Lines 
  // Calculate intersection Points
  x1 = saveCircleX[1];
  y1 = saveCircleY[1];
  x2 = saveCircleX[5];
  y2 = saveCircleY[5];
  x3 = saveCircleX[4];
  y3 = saveCircleY[4];
  x4 = saveCircleX[8];
  y4 = saveCircleY[8];
  myLineline16 = new Lineline(16, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline16.displayIntersection();

  x1 = saveCircleX[0];
  y1 = saveCircleY[0];
  x2 = saveCircleX[8];
  y2 = saveCircleY[8];
  x3 = saveCircleX[3];
  y3 = saveCircleY[3];
  x4 = saveCircleX[11];
  y4 = saveCircleY[11];
  myLineline17 = new Lineline(17, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline17.displayIntersection();

  x1 = saveCircleX[2];
  y1 = saveCircleY[2];
  x2 = saveCircleX[6];
  y2 = saveCircleY[6];
  x3 = saveCircleX[5];
  y3 = saveCircleY[5];
  x4 = saveCircleX[9];
  y4 = saveCircleY[9];
  myLineline18 = new Lineline(18, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline18.displayIntersection();

  x1 = saveCircleX[2];
  y1 = saveCircleY[2];
  x2 = saveCircleX[10];
  y2 = saveCircleY[10];
  x3 = saveCircleX[7];
  y3 = saveCircleY[7];
  x4 = saveCircleX[11];
  y4 = saveCircleY[11];
  myLineline19 = new Lineline(19, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline19.displayIntersection();

  float deltaX;
  float deltaY;
  // Extend parallel pairs 
  deltaX = saveIntersectionX[16] - saveIntersectionX[17];
  deltaY = saveIntersectionY[16] - saveIntersectionY[17];

  saveIntersectionX[16] =  saveIntersectionX[16] + deltaX;
  saveIntersectionY[16] =  saveIntersectionY[16] + deltaY;
  saveIntersectionX[17] =  saveIntersectionX[17] - deltaX;
  saveIntersectionY[17] =  saveIntersectionY[17] - deltaY;

  deltaX = saveIntersectionX[19] - saveIntersectionX[18];
  deltaY = saveIntersectionY[19] - saveIntersectionY[18];

  saveIntersectionX[19] =  saveIntersectionX[19] + deltaX;
  saveIntersectionY[19] =  saveIntersectionY[19] + deltaY;
  saveIntersectionX[18] =  saveIntersectionX[18] - deltaX;
  saveIntersectionY[18] =  saveIntersectionY[18] - deltaY;

  // Re-Calculate intersection Points for extended lines
  x1 = saveIntersectionX[16];
  y1 = saveIntersectionY[16];
  x2 = saveIntersectionX[17];
  y2 = saveIntersectionY[17];
  x3 = saveIntersectionX[4];
  y3 = saveIntersectionY[4];
  x4 = saveIntersectionX[5];
  y4 = saveIntersectionY[5];
  myLineline16 = new Lineline(16, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'g', 1);  
  myLineline16.displayIntersection();

  x1 = saveIntersectionX[16];
  y1 = saveIntersectionY[16];
  x2 = saveIntersectionX[17];
  y2 = saveIntersectionY[17];
  x3 = saveIntersectionX[0];
  y3 = saveIntersectionY[0];
  x4 = saveIntersectionX[11];
  y4 = saveIntersectionY[11];
  myLineline17 = new Lineline(17, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline17.displayIntersection();

  x1 = saveIntersectionX[18];
  y1 = saveIntersectionY[18];
  x2 = saveIntersectionX[19];
  y2 = saveIntersectionY[19];
  x3 = saveIntersectionX[5];
  y3 = saveIntersectionY[5];
  x4 = saveIntersectionX[6];
  y4 = saveIntersectionY[6];
  myLineline18 = new Lineline(18, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline18.displayIntersection();

  x1 = saveIntersectionX[18];
  y1 = saveIntersectionY[18];
  x2 = saveIntersectionX[19];
  y2 = saveIntersectionY[19];
  x3 = saveIntersectionX[10];
  y3 = saveIntersectionY[10];
  x4 = saveIntersectionX[11];
  y4 = saveIntersectionY[11];
  myLineline19 = new Lineline(19, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline19.displayIntersection();

  if (displayGuideLines) {
    stroke(0, 0, 0); // black
    strokeWeight(1);
    line(saveIntersectionX[16], saveIntersectionY[16], saveIntersectionX[17], saveIntersectionY[17]);
    line(saveIntersectionX[18], saveIntersectionY[18], saveIntersectionX[19], saveIntersectionY[19]);
  }
}  // End Step7b


void step8a(boolean displayGuideLines) {
  float x1, y1, x2, y2, x3, y3, x4, y4;
  strokeWeight(1);
  // Vertical Parallel Lines s 
  // Calculate intersection Points
  x1 = saveCircleX[4];
  y1 = saveCircleY[4];
  x2 = saveCircleX[0];
  y2 = saveCircleY[0];
  x3 = saveCircleX[3];
  y3 = saveCircleY[3];
  x4 = saveCircleX[7];
  y4 = saveCircleY[7];
  myLineline20 = new Lineline(20, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline20.displayIntersection();

  x1 = saveCircleX[9];
  y1 = saveCircleY[9];
  x2 = saveCircleX[5];
  y2 = saveCircleY[5];
  x3 = saveCircleX[8];
  y3 = saveCircleY[8];
  x4 = saveCircleX[0];
  y4 = saveCircleY[0];
  myLineline21 = new Lineline(21, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline21.displayIntersection();

  x1 = saveCircleX[2];
  y1 = saveCircleY[2];
  x2 = saveCircleX[6];
  y2 = saveCircleY[6];
  x3 = saveCircleX[3];
  y3 = saveCircleY[3];
  x4 = saveCircleX[11];
  y4 = saveCircleY[11];
  myLineline22 = new Lineline(22, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline22.displayIntersection();

  x1 = saveCircleX[10];
  y1 = saveCircleY[10];
  x2 = saveCircleX[6];
  y2 = saveCircleY[6];
  x3 = saveCircleX[9];
  y3 = saveCircleY[9];
  x4 = saveCircleX[1];
  y4 = saveCircleY[1];
  myLineline23 = new Lineline(23, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline23.displayIntersection();

  float deltaX;
  float deltaY;
  // Extend parallel pairs 
  deltaX = saveIntersectionX[20] - saveIntersectionX[21];
  deltaY = saveIntersectionY[20] - saveIntersectionY[21];

  saveIntersectionX[20] =  saveIntersectionX[20] + deltaX;
  saveIntersectionY[20] =  saveIntersectionY[20] + deltaY;
  saveIntersectionX[21] =  saveIntersectionX[21] - deltaX;
  saveIntersectionY[21] =  saveIntersectionY[21] - deltaY;

  deltaX = saveIntersectionX[23] - saveIntersectionX[22];
  deltaY = saveIntersectionY[23] - saveIntersectionY[22];

  saveIntersectionX[23] =  saveIntersectionX[23] + deltaX;
  saveIntersectionY[23] =  saveIntersectionY[23] + deltaY;
  saveIntersectionX[22] =  saveIntersectionX[22] - deltaX;
  saveIntersectionY[22] =  saveIntersectionY[22] - deltaY;

  // Re-Calculate intersection Points for extended lines
  x1 = saveIntersectionX[20];
  y1 = saveIntersectionY[20];
  x2 = saveIntersectionX[21];
  y2 = saveIntersectionY[21];
  x3 = saveIntersectionX[4];
  y3 = saveIntersectionY[4];
  x4 = saveIntersectionX[3];
  y4 = saveIntersectionY[3];
  myLineline20 = new Lineline(20, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline20.displayIntersection();

  x1 = saveIntersectionX[20];
  y1 = saveIntersectionY[20];
  x2 = saveIntersectionX[21];
  y2 = saveIntersectionY[21];
  x3 = saveIntersectionX[8];
  y3 = saveIntersectionY[8];
  x4 = saveIntersectionX[9];
  y4 = saveIntersectionY[9];
  myLineline21 = new Lineline(21, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline21.displayIntersection();

  x1 = saveIntersectionX[22];
  y1 = saveIntersectionY[22];
  x2 = saveIntersectionX[23];
  y2 = saveIntersectionY[23];
  x3 = saveIntersectionX[2];
  y3 = saveIntersectionY[2];
  x4 = saveIntersectionX[3];
  y4 = saveIntersectionY[3];
  myLineline22 = new Lineline(22, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline22.displayIntersection();

  x1 = saveIntersectionX[22];
  y1 = saveIntersectionY[22];
  x2 = saveIntersectionX[23];
  y2 = saveIntersectionY[23];
  x3 = saveIntersectionX[9];
  y3 = saveIntersectionY[9];
  x4 = saveIntersectionX[10];
  y4 = saveIntersectionY[10];
  myLineline23 = new Lineline(23, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline23.displayIntersection();

  if (displayGuideLines) {
    line(saveIntersectionX[20], saveIntersectionY[20], saveIntersectionX[21], saveIntersectionY[21]);
    line(saveIntersectionX[22], saveIntersectionY[22], saveIntersectionX[23], saveIntersectionY[23]);
  }
}  // End Step8a



void step8b(boolean displayGuideLines) {
  float x1, y1, x2, y2, x3, y3, x4, y4;
  strokeWeight(1);
  // Horizontal Parallel Lines 
  // Calculate intersection Points
  x1 = saveCircleX[5];
  y1 = saveCircleY[5];
  x2 = saveCircleX[9];
  y2 = saveCircleY[9];
  x3 = saveCircleX[6];
  y3 = saveCircleY[6];
  x4 = saveCircleX[2];
  y4 = saveCircleY[2];
  myLineline24 = new Lineline(24, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline24.displayIntersection();

  x1 = saveCircleX[1];
  y1 = saveCircleY[1];
  x2 = saveCircleX[9];
  y2 = saveCircleY[9];
  x3 = saveCircleX[4];
  y3 = saveCircleY[4];
  x4 = saveCircleX[0];
  y4 = saveCircleY[0];
  myLineline25 = new Lineline(25, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline25.displayIntersection();

  x1 = saveCircleX[6];
  y1 = saveCircleY[6];
  x2 = saveCircleX[10];
  y2 = saveCircleY[10];
  x3 = saveCircleX[3];
  y3 = saveCircleY[3];
  x4 = saveCircleX[7];
  y4 = saveCircleY[7];
  myLineline26 = new Lineline(26, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline26.displayIntersection();

  x1 = saveCircleX[3];
  y1 = saveCircleY[3];
  x2 = saveCircleX[11];
  y2 = saveCircleY[11];
  x3 = saveCircleX[0];
  y3 = saveCircleY[0];
  x4 = saveCircleX[8];
  y4 = saveCircleY[8];
  myLineline27 = new Lineline(27, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline27.displayIntersection();

  float deltaX;
  float deltaY;
  // Extend parallel pairs 
  deltaX = saveIntersectionX[24] - saveIntersectionX[25];
  deltaY = saveIntersectionY[24] - saveIntersectionY[25];

  saveIntersectionX[24] =  saveIntersectionX[24] + deltaX;
  saveIntersectionY[24] =  saveIntersectionY[24] + deltaY;
  saveIntersectionX[25] =  saveIntersectionX[25] - deltaX;
  saveIntersectionY[25] =  saveIntersectionY[25] - deltaY;

  deltaX = saveIntersectionX[27] - saveIntersectionX[26];
  deltaY = saveIntersectionY[27] - saveIntersectionY[26];

  saveIntersectionX[27] =  saveIntersectionX[27] + deltaX;
  saveIntersectionY[27] =  saveIntersectionY[27] + deltaY;
  saveIntersectionX[26] =  saveIntersectionX[26] - deltaX;
  saveIntersectionY[26] =  saveIntersectionY[26] - deltaY;

  // Re-Calculate intersection Points for extended lines
  x1 = saveIntersectionX[24];
  y1 = saveIntersectionY[24];
  x2 = saveIntersectionX[25];
  y2 = saveIntersectionY[25];
  x3 = saveIntersectionX[5];
  y3 = saveIntersectionY[5];
  x4 = saveIntersectionX[6];
  y4 = saveIntersectionY[6];
  myLineline24 = new Lineline(24, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline24.displayIntersection();

  x1 = saveIntersectionX[24];
  y1 = saveIntersectionY[24];
  x2 = saveIntersectionX[25];
  y2 = saveIntersectionY[25];
  x3 = saveIntersectionX[0];
  y3 = saveIntersectionY[0];
  x4 = saveIntersectionX[1];
  y4 = saveIntersectionY[1];
  myLineline25 = new Lineline(25, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline25.displayIntersection();

  x1 = saveIntersectionX[26];
  y1 = saveIntersectionY[26];
  x2 = saveIntersectionX[27];
  y2 = saveIntersectionY[27];
  x3 = saveIntersectionX[6];
  y3 = saveIntersectionY[6];
  x4 = saveIntersectionX[7];
  y4 = saveIntersectionY[7];
  myLineline26 = new Lineline(26, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline26.displayIntersection();

  x1 = saveIntersectionX[26];
  y1 = saveIntersectionY[26];
  x2 = saveIntersectionX[27];
  y2 = saveIntersectionY[27];
  x3 = saveIntersectionX[11];
  y3 = saveIntersectionY[11];
  x4 = saveIntersectionX[0];
  y4 = saveIntersectionY[0];
  myLineline27 = new Lineline(27, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline27.displayIntersection();

  if (displayGuideLines) {
    line(saveIntersectionX[24], saveIntersectionY[24], saveIntersectionX[25], saveIntersectionY[25]);
    line(saveIntersectionX[26], saveIntersectionY[26], saveIntersectionX[27], saveIntersectionY[27]);
  }

  stroke(0, 0, 0); // black
  strokeWeight(1);
}  // End Step8b



/// 9a
void step9a(boolean displayGuideLines) {
  float x1, y1, x2, y2, x3, y3, x4, y4;
  strokeWeight(1);
  // 3rd set of angled Parallel Lines 
  // Calculate intersection Points
  x1 = saveCircleX[2];
  y1 = saveCircleY[2];
  x2 = saveCircleX[10];
  y2 = saveCircleY[10];
  x3 = saveCircleX[1];
  y3 = saveCircleY[1];
  x4 = saveCircleX[5];
  y4 = saveCircleY[5];
  myLineline28 = new Lineline(28, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline28.displayIntersection();

  x1 = saveCircleX[10];
  y1 = saveCircleY[10];
  x2 = saveCircleX[6];
  y2 = saveCircleY[6];
  x3 = saveCircleX[7];
  y3 = saveCircleY[7];
  x4 = saveCircleX[3];
  y4 = saveCircleY[3];
  myLineline29 = new Lineline(29, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline29.displayIntersection();

  x1 = saveCircleX[0];
  y1 = saveCircleY[0];
  x2 = saveCircleX[4];
  y2 = saveCircleY[4];
  x3 = saveCircleX[1];
  y3 = saveCircleY[1];
  x4 = saveCircleX[9];
  y4 = saveCircleY[9];
  myLineline30 = new Lineline(30, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline30.displayIntersection();

  x1 = saveCircleX[4];
  y1 = saveCircleY[4];
  x2 = saveCircleX[8];
  y2 = saveCircleY[8];
  x3 = saveCircleX[7];
  y3 = saveCircleY[7];
  x4 = saveCircleX[11];
  y4 = saveCircleY[11];
  myLineline31 = new Lineline(31, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline31.displayIntersection();

  float deltaX;
  float deltaY;
  // Extend parallel pairs 
  deltaX = saveIntersectionX[28] - saveIntersectionX[29];
  deltaY = saveIntersectionY[28] - saveIntersectionY[29];

  saveIntersectionX[28] =  saveIntersectionX[28] + deltaX;
  saveIntersectionY[28] =  saveIntersectionY[28] + deltaY;
  saveIntersectionX[29] =  saveIntersectionX[29] - deltaX;
  saveIntersectionY[29] =  saveIntersectionY[29] - deltaY;

  deltaX = saveIntersectionX[31] - saveIntersectionX[30];
  deltaY = saveIntersectionY[31] - saveIntersectionY[30];

  saveIntersectionX[31] =  saveIntersectionX[31] + deltaX;
  saveIntersectionY[31] =  saveIntersectionY[31] + deltaY;
  saveIntersectionX[30] =  saveIntersectionX[30] - deltaX;
  saveIntersectionY[30] =  saveIntersectionY[30] - deltaY;

  // Re-Calculate intersection Points for extended lines
  x1 = saveIntersectionX[28];
  y1 = saveIntersectionY[28];
  x2 = saveIntersectionX[29];
  y2 = saveIntersectionY[29];
  x3 = saveIntersectionX[1];
  y3 = saveIntersectionY[1];
  x4 = saveIntersectionX[2];
  y4 = saveIntersectionY[2];
  myLineline28 = new Lineline(28, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline28.displayIntersection();

  x1 = saveIntersectionX[28];
  y1 = saveIntersectionY[28];
  x2 = saveIntersectionX[29];
  y2 = saveIntersectionY[29];
  x3 = saveIntersectionX[6];
  y3 = saveIntersectionY[6];
  x4 = saveIntersectionX[7];
  y4 = saveIntersectionY[7];
  myLineline29 = new Lineline(29, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline29.displayIntersection();

  x1 = saveIntersectionX[30];
  y1 = saveIntersectionY[30];
  x2 = saveIntersectionX[31];
  y2 = saveIntersectionY[31];
  x3 = saveIntersectionX[0];
  y3 = saveIntersectionY[0];
  x4 = saveIntersectionX[1];
  y4 = saveIntersectionY[1];
  myLineline30 = new Lineline(30, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline30.displayIntersection();

  x1 = saveIntersectionX[30];
  y1 = saveIntersectionY[30];
  x2 = saveIntersectionX[31];
  y2 = saveIntersectionY[31];
  x3 = saveIntersectionX[7];
  y3 = saveIntersectionY[7];
  x4 = saveIntersectionX[8];
  y4 = saveIntersectionY[8];
  myLineline31 = new Lineline(31, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline31.displayIntersection();

  if (displayGuideLines) {
    line(saveIntersectionX[28], saveIntersectionY[28], saveIntersectionX[29], saveIntersectionY[29]);
    line(saveIntersectionX[30], saveIntersectionY[30], saveIntersectionX[31], saveIntersectionY[31]);
  }
}// end step9a

void step9b(boolean displayGuideLines) {
  float x1, y1, x2, y2, x3, y3, x4, y4;
  strokeWeight(1);
  // 3rd set of angled Parallel Lines 
  // Calculate intersection Points
  x1 = saveCircleX[7];
  y1 = saveCircleY[7];
  x2 = saveCircleX[11];
  y2 = saveCircleY[11];
  x3 = saveCircleX[10];
  y3 = saveCircleY[10];
  x4 = saveCircleX[2];
  y4 = saveCircleY[2];
  myLineline32 = new Lineline(32, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline32.displayIntersection();

  x1 = saveCircleX[3];
  y1 = saveCircleY[3];
  x2 = saveCircleX[7];
  y2 = saveCircleY[7];
  x3 = saveCircleX[4];
  y3 = saveCircleY[4];
  x4 = saveCircleX[0];
  y4 = saveCircleY[0];
  myLineline33 = new Lineline(33, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline33.displayIntersection();

  x1 = saveCircleX[1];
  y1 = saveCircleY[1];
  x2 = saveCircleX[5];
  y2 = saveCircleY[5];
  x3 = saveCircleX[4];
  y3 = saveCircleY[4];
  x4 = saveCircleX[8];
  y4 = saveCircleY[8];
  myLineline34 = new Lineline(34, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline34.displayIntersection();

  x1 = saveCircleX[10];
  y1 = saveCircleY[10];
  x2 = saveCircleX[6];
  y2 = saveCircleY[6];
  x3 = saveCircleX[9];
  y3 = saveCircleY[9];
  x4 = saveCircleX[1];
  y4 = saveCircleY[1];
  myLineline35 = new Lineline(35, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'g', 1);  
  myLineline35.displayIntersection();

  float deltaX;
  float deltaY;
  // Extend parallel pairs 
  deltaX = saveIntersectionX[32] - saveIntersectionX[33];
  deltaY = saveIntersectionY[32] - saveIntersectionY[33];

  saveIntersectionX[32] =  saveIntersectionX[32] + deltaX;
  saveIntersectionY[32] =  saveIntersectionY[32] + deltaY;
  saveIntersectionX[33] =  saveIntersectionX[33] - deltaX;
  saveIntersectionY[33] =  saveIntersectionY[33] - deltaY;

  deltaX = saveIntersectionX[35] - saveIntersectionX[34];
  deltaY = saveIntersectionY[35] - saveIntersectionY[34];

  saveIntersectionX[35] =  saveIntersectionX[35] + deltaX;
  saveIntersectionY[35] =  saveIntersectionY[35] + deltaY;
  saveIntersectionX[34] =  saveIntersectionX[34] - deltaX;
  saveIntersectionY[34] =  saveIntersectionY[34] - deltaY;

  // Re-Calculate intersection Points for extended lines
  x1 = saveIntersectionX[32];
  y1 = saveIntersectionY[32];
  x2 = saveIntersectionX[33];
  y2 = saveIntersectionY[33];
  x3 = saveIntersectionX[10];
  y3 = saveIntersectionY[10];
  x4 = saveIntersectionX[11];
  y4 = saveIntersectionY[11];
  myLineline32 = new Lineline(32, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline32.displayIntersection();

  x1 = saveIntersectionX[32];
  y1 = saveIntersectionY[32];
  x2 = saveIntersectionX[33];
  y2 = saveIntersectionY[33];
  x3 = saveIntersectionX[3];
  y3 = saveIntersectionY[3];
  x4 = saveIntersectionX[4];
  y4 = saveIntersectionY[4];
  myLineline33 = new Lineline(33, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline33.displayIntersection();

  x1 = saveIntersectionX[34];
  y1 = saveIntersectionY[34];
  x2 = saveIntersectionX[35];
  y2 = saveIntersectionY[35];
  x3 = saveIntersectionX[4];
  y3 = saveIntersectionY[4];
  x4 = saveIntersectionX[5];
  y4 = saveIntersectionY[5];
  myLineline34 = new Lineline(34, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline34.displayIntersection();

  x1 = saveIntersectionX[34];
  y1 = saveIntersectionY[34];
  x2 = saveIntersectionX[35];
  y2 = saveIntersectionY[35];
  x3 = saveIntersectionX[9];
  y3 = saveIntersectionY[9];
  x4 = saveIntersectionX[10];
  y4 = saveIntersectionY[10];
  myLineline35 = new Lineline(35, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 1);  
  myLineline35.displayIntersection();

  if (displayGuideLines) {
    line(saveIntersectionX[32], saveIntersectionY[32], saveIntersectionX[33], saveIntersectionY[33]);
    line(saveIntersectionX[34], saveIntersectionY[34], saveIntersectionX[35], saveIntersectionY[35]);
  }
}// end step9b
// ]]]]


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
  for (int i = 0; i < 36; i = i+1) {
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
