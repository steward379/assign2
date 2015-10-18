//You should implement your assign2 here.

PImage bgOne, bgTwo;
PImage enemyLeft, fighter, treasureE;
PImage healthFrame;
PImage startPlain, startHover;
PImage endPlain, endHover;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;
int gameState;

int scrollRight;

int treasureX;
int treasureY;
int fighterX;
int fighterY;
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
int fighterSpeed;

int hpBar;
final int HP_PERCENT = 2;
final int HP_MAX = 100*HP_PERCENT;

int enemyFlyX;
int enemyFlyY;
int enemySpeed;

void setup () {
  size(640,480);
  
  startPlain = loadImage("img/start2.png");
  startHover = loadImage("img/start1.png");
  bgOne = loadImage("img/bg1.png");
  bgTwo = loadImage("img/bg2.png");
  endPlain = loadImage("img/end2.png");
  endHover = loadImage("img/end1.png");
  fighter = loadImage("img/fighter.png");
  treasureE = loadImage("img/treasure.png");
  healthFrame = loadImage("img/hp.png");
  enemyLeft = loadImage("img/enemy.png");
  
  gameState = 0;
  treasureX = floor(random(50,600));
  treasureY = floor(random(50,420));
  enemyFlyY = floor(random(50,420));
  fighterX = 575;
  fighterY = 240;
  fighterSpeed = 6;
  enemySpeed = 3;
  
  hpBar = 20*HP_PERCENT;
  
}

void draw() {
  background(255); 
  
  switch(gameState){    
    case GAME_START:
      image(startPlain,0,0);
      if(mouseX >200 && mouseX <470 && mouseY > 370 && mouseY <420){
         if(mousePressed){
           if(mouseButton == LEFT){
              gameState = 1;
           }
        }else{
        image(startHover,0,0);
        }
      } 
      break; 
      
    case GAME_RUN:
    
      //BACKGROUND
      scrollRight+=2;
      scrollRight%=1280;
      image(bgTwo,scrollRight,0);
      image(bgOne,scrollRight-640,0);
      image(bgTwo,scrollRight-1280,0);   
      
      //TREASURE
      image(treasureE,treasureX,treasureY);      
      
        /* Avoid Repeatition */  
        if(treasureX >= 545 && treasureX <= 605 && 
           treasureY >= 210 && treasureY <= 270){         
           treasureX = floor(random(50,600));
           treasureY = floor(random(50,420));
           }    
           
      //FIGHTER
      image(fighter,fighterX,fighterY);
        if (upPressed) {
          if(fighterY > 0){
          fighterY -= fighterSpeed;
          }
        }
        if (downPressed) {
          if(fighterY < 430){
          fighterY += fighterSpeed;
          }
        }
        if (leftPressed) {
          if(fighterX > 0){
          fighterX -= fighterSpeed;
          }
        }
        if (rightPressed) {
          if(fighterX <590){
          fighterX += fighterSpeed;
          }
        }  
        
      //HP_BAR
      fill(#FF0000);
      rect(35,15,hpBar,30);
      image(healthFrame,28,15); 
      
        /* HP +10 */         
        if(fighterX >= treasureX -30 && fighterX <= treasureX +30 &&
           fighterY >= treasureY -30 && fighterY <= treasureY +30){
          if(hpBar < HP_MAX){
             hpBar += 10*HP_PERCENT;
             treasureX = floor(random(50,600));         
             treasureY = floor(random(50,420));
          }else if(hpBar >= HP_MAX){
             treasureX = floor(random(50,600));
             treasureY = floor(random(50,420));
          }
        }   
        
        /* HP -20 */    
        if(fighterX >= enemyFlyX -30 && fighterX <= enemyFlyX +30 &&
           fighterY >= enemyFlyY -50 && fighterY <= enemyFlyY +50){
           hpBar -= 20*HP_PERCENT;
           enemyFlyX = -100;
           enemyFlyY = floor(random(50,420));
        }else if(hpBar <= 0){
           gameState = 2;
           hpBar = 20*HP_PERCENT;
           fighterX = 575;
           fighterY = 240;
           }
         
      //ENEMY       
      image(enemyLeft,enemyFlyX,enemyFlyY);
      enemyFlyX += enemySpeed;
      enemyFlyX %= width;
      
      /* Enemy proximity*/
      if(enemyFlyY >= fighterY){
         enemyFlyY -= enemySpeed;
      }
      if(enemyFlyY < fighterY){
         enemyFlyY += enemySpeed;
      }
      
      /* Enemy rush*/
      if(fighterX - enemyFlyX <= 200){
         enemyFlyX += enemySpeed;
      }         
    break;
      
    case GAME_LOSE:     
      image(endPlain,0,0);  
      if(mouseX >200 && mouseX <470 && mouseY > 300 && mouseY <350){
        if(mousePressed){
          if(mouseButton == LEFT){
             gameState = 1;
          }
        }else{
        image(endHover,0,0);
        }
      }
    break;
  }
}

void keyPressed(){
  if (key == CODED) { 
    switch (keyCode) {
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}
  
void keyReleased(){
  if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
