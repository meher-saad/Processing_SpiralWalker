// Global Variables
int UN_RANDOM_BIAS = 0; // A HIGHER NUMBER FORCES THE SPIRAL TO BE LESS RANDOM
float guidedAngleIncrement = 15; // This increment causes the spiral to grow in size
int guidedStepsCap = 20;
int guidedStepsCapIncrement = 1;
float speed = 0.6;

class RandomSpiralWalker{
  float x=width/2;
  float y=height/2;
  
  
  float guidedDirAngle = 0;
  int guidedStepsCnt = 0;
  //direction set in a spiral way to make it easy to toggle in a spiral way in the code
  float dir[] = {speed*sin(guidedDirAngle*3.1415/180),speed*cos(guidedDirAngle*3.1415/180)};
  
  void walk(){
    // decide whether it'll be guided or not
    int guidedOrNot = int(random(2+UN_RANDOM_BIAS));
    
    float dirAngle;
    
    // prob = UN_RANDOM_BIAS/(2+UN_RANDOM_BIAS), so more probable
    if(guidedOrNot>0){
      
      
      // if number of guided steps are done, then alternate guided dir
      if(guidedStepsCnt>guidedStepsCap){
        guidedStepsCnt=0;
        guidedDirAngle = (guidedDirAngle + guidedAngleIncrement) % 360; //change dir
        guidedStepsCap += guidedStepsCapIncrement; // increase the guided dir step range
      }
      
      guidedStepsCnt++;
      
      
      
      dirAngle = guidedDirAngle;
      
      dir[0] = speed*sin(dirAngle*3.1415/180);
      dir[1] = speed*cos(dirAngle*3.1415/180);
      
      // update location
      x += dir[0];
      y += dir[1];
    }
    else{ // otherwise just choose a random direction
      // choose random direction
      float choice = random(0,360);
      
      dirAngle = choice;
      
      dir[0] = speed*sin(dirAngle*3.1415/180);
      dir[1] = speed*cos(dirAngle*3.1415/180);
      
      //update location
      x += dir[0];
      y += dir[1];
    }
    
  }
  
  // display the SpiralWalker
  void display(){
    fill(0);
    ellipse(x,y,2,2);
  }
  
}


RandomSpiralWalker sw;

void setup(){
  size(1200,800);
  frameRate(120);
  background(240);
  sw = new RandomSpiralWalker();
}



void draw(){
  sw.walk();
  sw.display();
}


// Short code to preserve my screenshots
// Double press 'S' to get a screenshot, saved in an "img" folder, will create one if non-existent 
int timeOfFirstKey = 0;

void keyPressed(){
    if (keyCode == 83){ // When S is pressed
        if(timeOfFirstKey == 0 || millis()-timeOfFirstKey > 1000){ //the time when the S key is pressed first 
            timeOfFirstKey=millis();
        }
        else if(millis()-timeOfFirstKey < 1000){ //When the next time S is pressed, 'i.e. double pressed' it compares if it is within a second or not
                saveFrame("img/ss#####.jpg"); // if so then save the screenshot
                timeOfFirstKey = 0; // reset the timer
        }
    }
}
