class Object {
  float posX, posY, g, mass, maxAcceleration, resistance; // how much energy is lost
  float distanceX, distanceY, velocityX, velocityY, objectHeight; // height from ground
  float characterWidth, characterHeight, objectBorders; // the hitbox relative to size
  float targetX, targetY;  // the target for the creature
  Object(float x, float y, float G, float m, float a, float r, float chW, float chH, float objB) {
    posX = x;
    posY = y;
    g = G;
    mass = m;
    maxAcceleration = a;
    resistance = r;
    characterWidth = chW;
    characterHeight = chH;
    objectBorders = objB;
  }

  void display() {
    characterFunction();  // draw the character
    physics();  // apply physics
    follow();   // follow the target
  }

  void physics() {
    velocityY = velocityY + g;
    posX = posX + velocityX;
    posY = posY + velocityY;
    // if the y position is below the floor,
    // it teleports the object up and inverts the velocity
    // velocityX looses energy
    if (posY > height - characterHeight) {
      posY = height - characterHeight;
      velocityY = - velocityY * resistance;
      velocityX = velocityX * resistance;
    }
    // if the y position is above the ceiling.
    // and game is over
    // it teleports the object down and inverts the velocity
    // velocityX looses energy
    if (posY < 0 && gameOver) {
      posY = 0;
      velocityY = - velocityY * resistance;
      velocityX = velocityX * resistance;
    }
    // if the position x is outside of the borders, invert
    // the velocity and loose some energy.
    if (posX > width - characterWidth) {
      posX = width - characterWidth;
      velocityX = - velocityX * resistance;
    } else if (posX < characterWidth) {
      posX = characterWidth;
      velocityX = - velocityX * resistance;
    }
  }

  void follow() {
    boolean boolDisplayStats = false;  //change to true or false
    if (boolDisplayStats) {
      displayStats();
    }
    objectHeight = height - posY - characterHeight;
    distanceX = targetX - posX;
    distanceY = targetY - posY;
    // if the distance between the mouse and the creature is bigger
    // than the character height (with a weighting)
    // change the direction and velocity with a proportional acceleration
    float len = dist(0, 0, distanceX, distanceY);
    if (len > objectBorders * characterHeight) {
      velocityX = velocityX + maxAcceleration * (distanceX/len);
      // if the creature is not on the ground, the creature
      // cannot attempt to jump higher
      if (objectHeight == 0) {
        velocityY = velocityY + maxAcceleration * (distanceY/len) * 10;
      }
    } else {                // the else statement adds some game functions
      if (gameStarted) {    // if the game hasn't started then you cannot loose.
        gameOver = true;
        if (currentTime > previousBestTime) {
          previousBestTime = currentTime;
        }
      }
    }
    posX = posX + velocityX;
    posY = posY + velocityY;
  }

  void displayStats() {
    String displayVelocityX = "Velocity X = " + round(velocityX);
    String displayVelocityY = "Velocity Y = " + round(velocityY);
    String displayPosX = "Position X = " + round(posX);
    String displayPosY = "Position Y = " + round(posY);
    String displayG = "g = " + g;
    float energyK = 0.5 * mass * (pow(velocityX, 2) + pow(velocityY, 2)); 
    float energyG = mass * g * objectHeight;
    float totalEnergy = energyG + energyK;
    String displayEnergyK = "Kinetic energy = " + round(energyK) + " j";
    String displayEnergyG = "Potential energy = " + round(energyG) + " j";
    String displayEnergy = "Total energy = " + round(totalEnergy) + " j";
    String displayObjectHeight = "Object height = " + round(objectHeight) + " m";
    textAlign(LEFT);
    textSize(10);
    fill(0);
    text(displayVelocityX, 10, 15);
    text(displayVelocityY, 10, 27);
    text(displayPosX, 10, 39);
    text(displayPosY, 10, 51);
    text("Physics", 10, 75);
    text(displayObjectHeight, 10, 87);
    text(displayEnergyK, 10, 99);
    text(displayEnergyG, 10, 111);
    text(displayEnergy, 10, 123);
    text(displayG, 10, 135);
    String displayDistanceX = "Distance X = " + round(distanceX);
    String displayDistanceY = "Distance Y = " + round(distanceY);
    float compoundVelocity = sqrt(pow(velocityX, 2) + pow(velocityY, 2));
    String displayVelocity = "velocity = " + round(compoundVelocity) + " m/s";
    textSize(10);
    fill(0);
    text(displayDistanceX, 100, 15);
    text(displayDistanceY, 100, 27);
    text(displayVelocity, 100, 39);
  }
}
