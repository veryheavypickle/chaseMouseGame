boolean gameOver;
boolean gameStarted;
float gravity;
float defaultMaxVelocity;
float defaultResistance;
int initialTime;
int currentTime;
int previousBestTime;
String textTime;
Object character;

void setup() {
  fullScreen();
  //size(1200, 800);
  frameRate(60);
  gravity = 1;
  defaultResistance = 0.8;
  character = new Object(width/2, height/2, gravity, 2, 0.8, defaultResistance, 40, 60, 1.5);
  gameOver = false;
  gameStarted = false;
  previousBestTime = 0;
  currentTime = 0;
  rectMode(CENTER);
}

void draw() {
  background(255);
  mouse();
  character.display();
  game();
  timer();
}

void timer() {
  int minutes = 0;
  int seconds = 0;
  int milliseconds = 0;
  if (gameStarted && !gameOver) {
    currentTime = millis() - initialTime;
  }
  milliseconds = currentTime - 1000 * floor(currentTime/1000);
  seconds = floor(currentTime/1000) - 60 * floor(currentTime/60000);
  minutes = floor(currentTime/60000);
  textTime = minutes + ":" + seconds + ":" + milliseconds;
  textSize(15);
  fill(0);
  textAlign(RIGHT);
  text(textTime, width - 20, 20);
  if (previousBestTime > 0) {
    text("Previous Best: " + previousBestTime + " ms", width - 20, 40);
  }
}
void caught() {
  textSize(100);
  fill(#9E1A1A);
  textAlign(CENTER, CENTER);
  text("YOU DIED", width/2, height/2);
  textAlign(BASELINE);
  textSize(15);
  text("Click anywhere to start again", 10, height - 12);
}

void game() {  // this adds the characteristics of the game
  // if the game hasn't started, show the start screen
  // and set the velocities to 0.
  if (!gameStarted) {
    splashScreen();
    character.velocityX = 0;
    character.velocityY = 0;
  }
  // if the game is over, that implies you are caught.
  // update the target to the mouse or to the center
  // depending on whether the game is over.
  if (gameOver) {
    caught();
    character.targetX = width/2;
    character.targetY = height/3;
    character.g = 0.1;
    character.resistance = 0;
  } else {
    character.targetX = mouseX;
    character.targetY = mouseY;
    character.g = gravity;
    character.resistance = defaultResistance;
  }

  // if the character is out of the frame, show a triangle
  if (character.posY < 0) {
    fill(0);
    triangle(character.posX - 20, 30, character.posX + 20, 30, character.posX, 0);
    textAlign(CENTER);
    text(round(character.objectHeight - height) + " m", width/2, 30);
    textAlign(RIGHT);
  }
}

void splashScreen() {
  textSize(100);
  fill(#9E1A1A);
  textAlign(CENTER, CENTER);
  text("NEW GAME", width/2, height/2);
  character.posX = width/2;
  character.posY = height/3;
  textAlign(BASELINE);
  textSize(15);
  text("Don't get caught", 10, height - 30);
  text("Click anywhere to start game", 10, height - 12);
}

void characterFunction() {
  //legs
  noStroke();
  fill(#78A834);
  rect(character.posX - 25, character.posY + 30, 5, 60);
  rect(character.posX + 25, character.posY + 30, 5, 60);
  //horns
  fill(#C5B196);
  triangle(character.posX - 20, character.posY - 45, character.posX - 18, character.posY - 33, character.posX - 22, character.posY - 33);
  triangle(character.posX + 20, character.posY - 45, character.posX + 18, character.posY - 33, character.posX + 22, character.posY - 33);
  //body
  fill(#96C006);
  ellipse(character.posX, character.posY, 80, 80);
  //arms
  ellipse(character.posX - 40, character.posY + 4, 5, 5);
  ellipse(character.posX + 40, character.posY + 4, 5, 5);
  rect(character.posX - 40, character.posY + 25, 5, 40);
  rect(character.posX + 40, character.posY + 25, 5, 40);
  ellipse(character.posX - 40, character.posY + 44, 7, 7);
  ellipse(character.posX + 40, character.posY + 44, 7, 7);
  //face
  fill(#4A620A);
  triangle(character.posX + 7, character.posY - 5, character.posX - 7, character.posY - 5, character.posX, character.posY - 12);
  rect(character.posX, character.posY + 10, 20, 2);
  stroke(#4A620A);
  fill(255);
  ellipse(character.posX - 6, character.posY - 20, 12, 12);
  ellipse(character.posX + 6, character.posY - 20, 12, 12);
  fill(#96C006);
  noStroke();
  quad(character.posX - 12, character.posY - 32, character.posX, character.posY - 30, character.posX, character.posY - 22, character.posX - 12, character.posY - 20);
  quad(character.posX + 12, character.posY - 32, character.posX, character.posY - 30, character.posX, character.posY - 22, character.posX + 12, character.posY - 20);
  fill(#4A620A);
  stroke(#4A620A);
  ellipse(character.posX + 6, character.posY - 20, 3, 3);
  ellipse(character.posX - 6, character.posY - 20, 3, 3);
}

void mouseClicked() {
  initialTime = millis();
  if (gameOver) {
    gameOver = false;
  }
  if (!gameStarted) {
    gameStarted = true;
  }
}

void mouse() {
  fill(#AF3131);
  noStroke();
  ellipse(mouseX, mouseY, 15, 15);
  noCursor();
}
