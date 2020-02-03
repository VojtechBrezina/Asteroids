private static final float PLAYER_ACCELERATION = 3;
private static final float PLAYER_DECELERATION = 0.5;
private static final float PLAYER_TOP_SPEED = 30;
private static final float PLAYER_R_FORCE = 0.04;
private static final float PLAYER_R_FALLOF = 0.01;
private static final float PLAYER_TOP_DR = 0.3;
private static final int BULLET_RELOAD = 10;
private static final int STARTING_LIVES = 3;
private static final int TELEPORT_RELOAD = 200;

private float playerX, playerY, playerR;
private float playerDX, playerDY, playerDR;

private int bulletReload, teleportReload;

private int score, highScore;
private int lives;

private void handlePlayerPhysics(){
  
  playerX = (playerX + playerDX + width) % width;
  playerY = (playerY + playerDY + height) % height;
  playerR = (playerR + playerDR + TWO_PI) % TWO_PI;
  
  if(isKeyPressed(KEY_LEFT))
    playerDR = min(PLAYER_TOP_DR, playerDR + PLAYER_R_FORCE);
  
  if(isKeyPressed(KEY_RIGHT))
    playerDR = max(-PLAYER_TOP_DR, playerDR - PLAYER_R_FORCE);
  
  playerDR = playerDR > 0 ? max(0, playerDR - PLAYER_R_FALLOF) : min(0, playerDR + PLAYER_R_FALLOF);
  
  {
    PVector v = new PVector(playerDX, playerDY);
    float m;
    if(isKeyPressed(KEY_THRUST))
      v.add(new PVector(PLAYER_ACCELERATION, 0).rotate(-playerR));
    m = v.mag();
    v.normalize();
    m = max(0, m - PLAYER_DECELERATION);
    m = min(m, PLAYER_TOP_SPEED);
    v.mult(m);
    playerDX = v.x;
    playerDY = v.y;
  }
}

private int checkForPlayerCollisions(){
  for(int i = asteroids.size() - 1; i >= 0; i--){
    Asteroid a = asteroids.get(i);
    if(sq(playerX - a.x) + sq(playerY - a.y) <= sq(a.radius + 10)){
      return i;
    }
  }
  return -1;
}

private void destroyPlayer(){
  lives--;
  if(lives == 0)
    newGame();
  else
    replacePlayer();
}

private void replacePlayer(){
  resetPlayer();
  do{
    playerX = random(100, width - 100);
    playerY = random(100, height - 100);
  }while(checkForPlayerCollisions() != -1);
}

private void resetPlayer(){
  playerX = width / 2;
  playerY = height / 2;
  playerR = HALF_PI;
  
  playerDX = playerDY = playerDR = 0;
  
  bulletReload = teleportReload = 0;
}
