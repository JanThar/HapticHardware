
#include <Wire.h>
#include <Adafruit_PWMServoDriver.h>
#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
  #include <avr/power.h>
#endif

// PIN of neopixel matrix
#define PIN_NEO         6
// How many NeoPixels
#define NUMPIXELS      8*8*2

// Board mapping
#define BOARD_HEIGHT    2
#define BOARD_WIDTH     8

#define STEP_TIME_MS    75
#define SLIDER_UPDATE   5

// Vest actuator driver and pin mapping
uint8_t map_matrix_left[2][8] =  {{ 9,10,11,12,13,14,15,16},
                  { 1, 2, 3, 4, 5, 6, 7, 8}};
uint8_t map_matrix_right[2][8] = {{ 1, 2, 3, 4, 5, 6, 7, 8},
                  { 9,10,11,12,13,14,15,16}};
Adafruit_PWMServoDriver board_matrix[4][2] = {{Adafruit_PWMServoDriver(0x45), Adafruit_PWMServoDriver(0x40)},
                                              {Adafruit_PWMServoDriver(0x46), Adafruit_PWMServoDriver(0x41)},
                                              {Adafruit_PWMServoDriver(0x47), Adafruit_PWMServoDriver(0x43)},
                                              {Adafruit_PWMServoDriver(0x48), Adafruit_PWMServoDriver(0x42)}};

// Init neopixel
Adafruit_NeoPixel pixels = Adafruit_NeoPixel(NUMPIXELS, PIN_NEO, NEO_GRB + NEO_KHZ800);

////////////////////////

// General Game settings
#define POINTS_TO_WIN   5

#define HEIGHT          8       // Game field height
#define WIDTH           16      // Game field width

// The players bar width (or better "height")
#define BAREXT          1       // Extends the bar X up and X down, bar 1 => BARSIZE = 3
#define BARHEIGHT       (BAREXT*2)+1

#define UP              0
#define DOWN            1
#define LEFT            0
#define RIGHT           1

#define PIN_SP1         A0
#define PIN_SP2         A1



// Init the internal matrix
int mat[WIDTH][HEIGHT];

// Pong ball settings
int pongPosX;       // Pong position coordinate X
int pongPosY;      // Pong position coordinate Y
int pongStepSize = 1;           // How many fields the pong moves in one step

bool pongStepDirLR = 0;         // Horizontal movement direction: 0 = left, 1 = right
bool pongStepDirUD = 0;         // Vertical movement direction:   0 = up,   1 = down
bool pongStepStraigth = 0;

// The individual bar positions of the players:
//    It is NOT the y coordinate. The value of a bars position is defined
//    by a number from 0 to (HEIGHT - BARHEIGHT)-1
int P1_barPos;
int P2_barPos;

int P1_points;
int P2_points;


// Sets the pwm signal of a certain vibration motor on the west
void setPWM(int x, int y, int val){
  int board_x = (x>=8);
  int board_y = (y/2);

  int map_x = (x % 8);
  int map_y = (y % 2);

  //Serial.print("bX: ");Serial.print(board_x);Serial.print(", bY: ");Serial.println(board_y);
  //Serial.print("mX: ");Serial.print(map_x);Serial.print(", mY: ");Serial.println(map_y);

  if ((x>=8)) {
    board_matrix[board_y][board_x].setPin(map_matrix_right[map_y][map_x]-1, val, false);
  }
  else{
    board_matrix[board_y][board_x].setPin(map_matrix_left[map_y][map_x]-1, val, false);
  }
}

// Sets pixel on 16x8 neopixel matrix (green only)
void setPixel(int x, int y, int val){  
  int index = ((x+1)%2)*(8*x+y) + (x%2)*(8*x+(8-y)-1) ;
  pixels.setPixelColor(index, pixels.Color(0,val,0)); // Moderately bright green color.
  pixels.show(); // This sends the updated pixel color to the hardware.
}

// Sets pixel on 16x8 neopixel matrix with rgb variables
void setPixel(int x, int y, int r, int g, int b){  
  int index = ((x+1)%2)*(8*x+y) + (x%2)*(8*x+(8-y)-1) ;
  pixels.setPixelColor(index, pixels.Color(r,g,b)); // Moderately bright green color.
  pixels.show(); // This sends the updated pixel color to the hardware.
}

// Prints the internal matrix on the serial port
void printMat(){
  Serial.println();
  Serial.println();
  Serial.print("P1 Score: ");
  Serial.print(P1_points);
  Serial.print("\t   \t");
  Serial.print("P2 Score: ");
  Serial.print(P2_points);
  Serial.println("\n");
  
  for (int i=0; i<HEIGHT; i++){
    for (int j=0; j<WIDTH; j++){
      if(mat[WIDTH-1-j][i] == 1)
        Serial.print("0");
      else if(mat[WIDTH-1-j][i] == 2)
        Serial.print("|");
      else
        Serial.print("-");
      Serial.print("  ");
    }
    Serial.println();
  }
}


// Sets a certain field of the game to a value
// And updates the corresponding output 
void setGameField(int x, int y, int val){
  // Check if indicies are within bounds
  if ((x >= 0 && x < WIDTH) && (y >= 0 && y < HEIGHT)){
    // Set local matrix
    mat[x][y] = val;

    // Set actuators
    setPWM(x,y,val*4095);
    
    // Set neopixels
    if(val == 1)
      setPixel(x, y, 20, 0, 0);
    else
      setPixel(x, y, val*20);
    
  }
  else{
    Serial.println("Error: Exceeding index.");
  }
}

// Returns true if the y coordinate belongs to the bar of player 1
bool isInRangeOfBarP1(int y){
  return (y >= P1_barPos && y < (P1_barPos + BARHEIGHT));
}

// Returns true if the y coordinate belongs to the bar of player 2
bool isInRangeOfBarP2(int y){
  return (y >= P2_barPos && y < (P2_barPos + BARHEIGHT));
}

// Sets the bar position for player 1
// pos - the new position to set the bar to,
//       a number from 0 to (HEIGHT - BARHEIGHT)-1
void setBarPosP1(int pos){
  if(pos >= 0 && pos < (HEIGHT-BARHEIGHT)){
    // Update barpos for player 1
    P1_barPos = pos;
    
    // Update bar column
    for (int i = 0; i<HEIGHT; i++){
      setGameField(0, i, isInRangeOfBarP1(i) * 2);
    }
  } else {
    Serial.println("Error: Non valid bar position");
  }
}

// Sets the bar position for player 1
// pos - the new position to set the bar to,
//       a number from 0 to (HEIGHT - BARHEIGHT)-1
void setBarPosP2(int pos){
  if(pos >= 0 && pos < (HEIGHT-BARHEIGHT)){
    // Update barpos for player 1
    P2_barPos = pos;
    
    // Update bar column
    for (int i = 0; i<HEIGHT; i++){
      setGameField(WIDTH-1, i, isInRangeOfBarP2(i) * 2);
    }
  } else {
    Serial.println("Error: Non valid bar position");
  }
}

// Only sets pong position, doesnt check for logic
void setPongPos(int x, int y){
  if ((x >= 0 && x < WIDTH) && (y >= 0 && y < HEIGHT)){
    // Reset previous field
    setGameField(pongPosX, pongPosY, 0);

    // Set new position and update corresponding field
    pongPosX = x;
    pongPosY = y;
    setGameField(pongPosX, pongPosY, 1);
  } else {
    Serial.println("Error: Pong position exceeding index.");
  }
}

// Performs a relative movement of the pong ball
void movePongRelative(int x, int y){
  setPongPos(pongPosX + x, pongPosY + y);
}

// Increases the score of player 1 and checks for win.
void p1_scores(){
  P1_points = P1_points + 1;

  // Restart the game if won
  if(P1_points >= POINTS_TO_WIN){
    restartGame();
  }
  else{ // Setup a new round else
    newRound();
  }
}

// Increases the score of player 2 and checks for win.
void p2_scores(){
  P2_points = P2_points + 1;

  // Restart the game if won
  if(P2_points >= POINTS_TO_WIN){
    restartGame();
  }
  else{ // Setup a new round else
    newRound();
  }
}

// Performs one pong step in the current direction with
// the set step size and checks for collisions and resulting
// effects. (Pong Logic)
void performPongStep(){
  bool scored = false;
  bool hitsBar = false;
  // Check vertical movements:
  // If pong collides with horizontal (top/bottom) wall 
  if(pongPosY > HEIGHT-2 || pongPosY < 1){
    // invert vertical direction
    pongStepDirUD = !pongStepDirUD;
  }
  
  // Check horizontal movements:
  
  // If pong moves to the left
  if ( pongStepDirLR == 0 ){

    // If it collides with a wall player 2 scores
    if(pongPosX < 1){
      p2_scores();
      scored = true;
    }
    else if (pongPosX < 2) {
      // As we check the collision before the step we have to consider 
      // the movement depending on the direction.
      if(pongStepStraigth && isInRangeOfBarP1(pongPosY)){
        // If moving straight it simply hits bar
        hitsBar = true;

        // Give ball a spin if it doesnt hit bar in center:
        if(pongPosY < (P1_barPos + (BARHEIGHT-1) / 2)){
          pongStepStraigth = false;
          pongStepDirUD = UP;
        } else if(pongPosY > (P1_barPos + (BARHEIGHT-1) / 2)){
          pongStepStraigth = false;
          pongStepDirUD = DOWN;
        }
      }
      else if (!pongStepStraigth){
        if(pongStepDirUD == UP){
          // If moving up check one step ahead up
          hitsBar = isInRangeOfBarP1(pongPosY-1);
        }
        else{
          // If moving down check one step ahead down
          hitsBar = isInRangeOfBarP1(pongPosY+1);
        }
      }
    }
    
  } else { // If pong moves to the right

    // If it collides with a wall player 1 scores
    if(pongPosX > WIDTH-2){
      p1_scores();
    }
    else if (pongPosX > WIDTH-3) {
      // As we check the collision before the step we have to consider 
      // the movement depending on the direction.
      if(pongStepStraigth && isInRangeOfBarP2(pongPosY)){
        // If moving straight it simply hits bar
        hitsBar = true;

        // Give ball a spin if it doesnt hit bar in center:
        if(pongPosY < (P2_barPos + (BARHEIGHT-1) / 2)){
          pongStepStraigth = false;
          pongStepDirUD = UP;
        } else if(pongPosY > (P2_barPos + (BARHEIGHT-1) / 2)){
          pongStepStraigth = false;
          pongStepDirUD = DOWN;
        }
      }
      else if (!pongStepStraigth){
        if(pongStepDirUD == UP){
          // If moving up check one step ahead up
          hitsBar = isInRangeOfBarP2(pongPosY-1);
        }
        else{
          // If moving down check one step ahead down
          hitsBar = isInRangeOfBarP2(pongPosY+1);
        }
      }
    }
  }

  // If it hits the bar change the horizontal direction
  if (hitsBar){
    pongStepDirLR = !pongStepDirLR; 
  }

  // If nobody scored.. (so the next round wont be affected):
  if(!scored){ 
    // Move the pong according to current direciton and stepsize
    int relX = (pongStepDirLR ? pongStepSize : -pongStepSize);
    int relY = (1-pongStepStraigth)*(pongStepDirUD ? pongStepSize : -pongStepSize);
    
    movePongRelative(relX, relY);
  }
}

// Restarts the game by simply resetting the points and starting a new round
void restartGame(){
  P1_points = 0;
  P2_points = 0;

  newRound();
}

// Initializes a new round
void newRound(){
  // Initialize game field with 0
  for (int i=0; i<WIDTH; i++)
    for (int j=0; j<HEIGHT; j++)
      setGameField(i, j, 0);

  // Set pong ball and bar positions
  setPongPos(WIDTH / 2, HEIGHT / 2);
  setBarPosP1((HEIGHT-BARHEIGHT) / 2);
  setBarPosP2((HEIGHT-BARHEIGHT) / 2);

  // Set a random direction for the pong ball
  pongStepDirLR = random(2);
  pongStepDirUD = random(2);
  pongStepStraigth = random(2);

  setBarPosP1(2);
  setBarPosP2(4);
}

void setup() {
  Serial.begin(115200);

  // Init pins for reading players sliders
  pinMode(PIN_SP1, INPUT);
  pinMode(PIN_SP2, INPUT);

  // This initializes the NeoPixel library.
  pixels.begin();

  // Init the pwm drivers for the haptic vest
  for(int i = 0; i < 4; i++){
    for(int j = 0; j < 2; j++){
      board_matrix[i][j].begin();
      board_matrix[i][j].setPWMFreq(1600);
    }
  }
  Wire.setClock(400000);
  
  // Init random Seed
  randomSeed(analogRead(0));

  // Setup a new game
  restartGame();
}

void checkSliderInputP1(){
  int value = analogRead(PIN_SP1);
  setBarPosP1(map(value, 0, 1024, 0, (HEIGHT-BARHEIGHT)-1));
}

void checkSliderInputP2(){
  int value = analogRead(PIN_SP2);
  setBarPosP2(map(value, 0, 1024, 0, (HEIGHT-BARHEIGHT)-1));
}


long laststep = 0;
void loop() {
  checkSliderInputP1();
  checkSliderInputP2();
  delay(SLIDER_UPDATE);

  long currentStep = millis();
  if(currentStep > laststep + STEP_TIME_MS){
    //printMat();
    performPongStep();
    laststep = currentStep;
  }
  
}
