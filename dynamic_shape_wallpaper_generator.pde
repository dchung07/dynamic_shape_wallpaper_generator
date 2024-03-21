Table xy; //the table of values
float rotatingAngle = 0; //look further down to change the rotatingangle variable on line 55
int index = 0;

float xPos;
float yPos;

float x= 600; //rect shape size
float y= 600; //rect shape size

float xSpeed = 0.1; //change this to change the speed at which your screen flashes (how fast the shape moves
float ySpeed = 0.1;
//Adjust these if you want the wallpaper to go slower

color shapeColor = color(random(255), 15, 30);
color bgColor;

void setup() {
  size(1000, 1000);
 
  frameRate(60);
  rectMode(CENTER);
  
  
  xPos = width/2;
  yPos = height/2;
  
  // load the data for a humidity censor in csv format.
  xy = loadTable("https://eif-research.feit.uts.edu.au/api/csv/?rFromDate=2022-08-01T16%3A01%3A17&rToDate=2022-08-08T16%3A01%3A17&rFamily=people_sh&rSensor=CB11.PC00.08.ST12&rSubSensor=CB11.00.CR04.East+In", "csv");
  
}
void draw() {
  bgColor = color(0); //random bg
  noStroke();
  translate(width/2, height/2); 
  for (int i = 0; i < 100; i++) {
    //For the rows in the xy (feit csv), it will increase creating that many number of square/rectangles.
    fill (shapeColor);
    scale(1); //shape size 90%
    rotate(radians(rotatingAngle));

    rect(xPos, yPos, x, y);
    //This rectangle is being created in the for loop above
    
    println("xPos = " + xPos);
    println("yPos = " + yPos);
    
    xPos += xSpeed;
    yPos += ySpeed;
    //keep increasing the position, changing the shape
    
    
  }
  
  //The two if statements below make the shape come back inwards after some mysterious point. If they aren't there then the shape just expands and doesn't come back inwards
  if (xPos > width || xPos < 0) {
    xSpeed *= -1;
    shapeColor = color(random(255), random(255), 255);
  }
  
  if (yPos > height || yPos < 0) {
    ySpeed *= -1;
    shapeColor = color(255, random(255), random(255));
  }
  rotatingAngle += 1;
  

  
  //change the angle to change the way the shape moves. At angle (1), on a second click you can make a sun disc
}

void mousePressed() {
  if(xSpeed != 0 || ySpeed != 0){
  xSpeed -=1;
  ySpeed -=1;
  strokeWeight(1); //how thick the outline is, previously there is no stroke so doing this will add a shape in a sense
  shapeColor = color(random(xy.getInt(index, 1)), random(255), random(255));
  }
  else{
    xSpeed += 1;
    xSpeed += 1;
    shapeColor = color(random(xy.getInt(index, 1)), random(255), random(255)); //use table of values for random color
  }
  //On the click of your mouse, you reverse the shapes spreading nature, which initially spreads eastwards. 
  //It begins to retract, then move in the other direction. Additionally, upon each click of the mouse, the speed at which the shape begins to disperse rapidly increases.
  //The colour of the shape also changes at random. 
}

void keyPressed(){
  if(key == 's'){
  noLoop();
  //freeze
  }
  if(key == 'r'){
    loop();
    //de-freeze
  }
  if (key == 'a'){
    xSpeed = 0.1;
    ySpeed = 0.1;

  }
  if(key == 'q'){
    xPos = -400;
    yPos = -400;
      //Switch to a different position where its rainbow... sun disc...
  }
}
