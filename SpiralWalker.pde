// Global Variables
int UN_RANDOM_BIAS = 2; // A HIGHER NUMBER FORCES THE SPIRAL TO BE LESS RANDOM
int guidedStepsCapIncrement = 10; // This increment causes the spiral to grow in size
int guidedStepsCap = 10;


class SpiralWalker{
  float x=width/2;
  float y=height/2;
  
  
  int guidedDir = 0;
  int guidedStepsCnt = 0;
  
  //direction set in a spiral way to make it easy to toggle in a spiral way in the code
  int dir[][] = {{-1,-1},{-1,0},{-1,1},{0,1},{1,1},{1,0},{1,-1},{0,-1}};
  
  void walk(){
    // choose one of 8 random directions or take the guided dir 
    int choice = int(random(8+UN_RANDOM_BIAS));
    
    // prob = UN_RANDOM_BIAS/(8+UN_RANDOM_BIAS), so more probable
    if(choice>7){
      
      guidedStepsCnt++;
      
      // if number of guided steps are done, then alternate guided dir
      if(guidedStepsCnt>guidedStepsCap){
        guidedStepsCnt=0;
        guidedDir=(guidedDir+1)%8; //go to next dir
        guidedStepsCap+=guidedStepsCapIncrement; // increase the guided dir step range
      }
      
      // update location
      x += dir[guidedDir][0];
      y += dir[guidedDir][1];
    }
    else{ // otherwise just choose a random direction
      // update location
      x += dir[choice][0];
      y += dir[choice][1];
    }
    
  }
  
  // display the SpiralWalker
  void display(){
    fill(0);
    ellipse(x,y,2,2);
  }
  
}


SpiralWalker sw;

void setup(){
  size(1200,800);
  frameRate(120);
  background(240);
  sw = new SpiralWalker();
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
