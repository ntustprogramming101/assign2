 final int GAME_START = 0;
 final int GAME_RUN = 1;
 final int GAME_OVER = 2;
 int gameState=GAME_START;
 
 final int BUTTON_TOP = 360 ;
 final int BUTTON_BOTTOM = 420 ;
 final int BUTTON_LEFT =  248;
 final int BUTTON_RIGHT = 392 ;

 boolean upPressed,downPressed,rightPressed,leftPressed;
 
 int soldierY,cabbageX,cabbageY,groundhogIdleX,groundhogIdleY,groundhogIdleX1,groundhogIdleY1,t;
 int groundhogIdleSpeed = 80 ;
 int speedX = 2;
 int lifeX = 10;
 int lifeY = 10;
 int soldierX = -80;
 int soldierSize = 80;
 int cabbageSize = 80;
 int groundhogSize = 80;


 
 PImage bg,cabbage,gameover,groundhogDown,groundhogIdle,groundhogLeft,groundhogRight;
 PImage life,restartHovered,restartNormal,soil,soldier,startHovered,startNormal,title;
 
 void setup() {
	 size(640, 480, P2D);
   frameRate(60);
 	 bg = loadImage("img/bg.jpg");
   life = loadImage("img/life.png");
   soil = loadImage("img/soil.png");
   title = loadImage("img/title.jpg");
   cabbage = loadImage("img/cabbage.png");
   soldier = loadImage("img/soldier.png");
   soldierY = floor(random(2,6))*80;
   cabbageX = floor(random(3,8))*80;
   cabbageY = floor(random(2,6))*80;
   groundhogIdleX = width/2;
   groundhogIdleY = height/6;
   gameover = loadImage("img/gameover.jpg");
   startNormal = loadImage("img/startNormal.png");
   startHovered = loadImage("img/startHovered.png");
   restartNormal = loadImage("img/restartNormal.png");
   groundhogDown = loadImage("img/groundhogDown.png");
   groundhogIdle = loadImage("img/groundhogIdle.png");
   groundhogLeft = loadImage("img/groundhogLeft.png");
   groundhogRight = loadImage("img/groundhogRight.png");
   restartHovered = loadImage("img/restartHovered.png");
}

void draw() {
    switch(gameState){
    case GAME_START:
    image(title,0,0);
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        image(startHovered,BUTTON_LEFT,BUTTON_TOP);
        if(mousePressed){
          gameState = GAME_RUN;
       }
      }else{
        image(title,0,0);
        image(startNormal,BUTTON_LEFT,BUTTON_TOP);
      }
    break;
    
    case GAME_RUN:
     //background
     image(bg,0,0);
     image(life,lifeX-70,lifeY);
     image(life,lifeX,lifeY);
     image(life,lifeX+70,lifeY);
     image(soil,0,height/3);
     image(cabbage,cabbageX,cabbageY);
   
     //sun
     stroke(255,255,0);
     strokeWeight(5);
     fill(253, 184,19);
     ellipse(width-50,50,120,120);
     
     //grassland
     noStroke();
     fill(124,204,25);
     rect(0,height/3-15,width,15);
  
     image(groundhogIdle,groundhogIdleX,groundhogIdleY);
     
     //groundhog move
        if(downPressed){
        groundhogIdleY += groundhogIdleSpeed;
        if(groundhogIdleY + groundhogSize > height)groundhogIdleY =  height- groundhogSize;
        downPressed = false;
      }
      if(leftPressed){
        groundhogIdleX -= groundhogIdleSpeed;
         if(groundhogIdleX < 0)groundhogIdleX = 0;
          leftPressed = false;
      }
      if(rightPressed){
        groundhogIdleX += groundhogIdleSpeed;
       
         if(groundhogIdleX + groundhogSize > width)groundhogIdleX = width - 80;
          rightPressed = false;
      }

    //GET_GABBAGE
    if(groundhogIdleX<cabbageX+cabbageSize && groundhogIdleX+groundhogSize>cabbageX && groundhogIdleY<cabbageY+cabbageSize && groundhogIdleY+groundhogSize>cabbageY){
      cabbageX = 1000;
      lifeX = lifeX+70;
    }
     
    //soilier
    image(soldier,soldierX,soldierY);
    soldierX+= speedX;
    if(soldierX>720) {
      soldierX=-80;
    }
       
    //TOUCH_SOLDIER
    if(groundhogIdleX<soldierX+soldierSize && groundhogIdleX+groundhogSize>soldierX && groundhogIdleY<soldierY+soldierSize && groundhogIdleY+groundhogSize>soldierY){
      groundhogIdleX = width/2;
      groundhogIdleY = height/6;
      lifeX = lifeX-70;
    }
    if (lifeX < -70){
      gameState = GAME_OVER;
    }
    break;  
    
    case GAME_OVER:
    image(gameover,0,0);
     if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        image(restartHovered,BUTTON_LEFT,BUTTON_TOP);
        if(mousePressed){
          gameState = GAME_RUN;
          lifeX=10;
          cabbageX = floor(random(3,8))*80;
          cabbageY = floor(random(2,6))*80;
          soldierY = floor(random(2,6))*80;
          soldierX = -80;
           }
      }else{
        image(restartNormal,BUTTON_LEFT,BUTTON_TOP);
      }
    break; 
 }
}

void keyPressed(){
  switch(keyCode){
    case DOWN:
    downPressed = true;
    break;
    case RIGHT:
    rightPressed = true;
    break;
    case LEFT:
    leftPressed = true;
    break;
  }
}

void keyReleased(){
  switch(keyCode){
    case DOWN:
    downPressed = false;
    break;
    case RIGHT:
    rightPressed = false;
    break;
    case LEFT:
    leftPressed = false;
    break;
  }
}
