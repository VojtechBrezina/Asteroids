private static final int STARTING_ASTEROIDS = 3;
private static final int ASTEROIDS_AT_100_SCORE = 20;
private static final int STARTING_SPAWN_TIME = 200;
private static final int SPAWN_TIME_AT_100_SCORE = 100;

private ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
private ArrayList<Bullet> bullets = new ArrayList<Bullet>();

private int spawnTimer;


private void newGame(){
  asteroids.clear();
  bullets.clear();
  for(int i = 0; i < STARTING_ASTEROIDS; i++)
    asteroids.add(new Asteroid());
  
  resetPlayer();
  
  score = 0;
  lives = STARTING_LIVES;
  
  saveStrings("data.txt", new String[]{String.valueOf(highScore)});
  
  lastTick = millis();
}

private void gameTick(){
  for(Asteroid a : asteroids){
    a.tick();
  }
  handlePlayerPhysics();
  handleBullets();
  
  if(isKeyPressed(KEY_FIRE) && bulletReload == 0){
    bullets.add(new Bullet());
    bulletReload = BULLET_RELOAD;
  }else if(bulletReload != 0)
    bulletReload--;
  
  if(isKeyPressed(KEY_TELEPORT) && teleportReload == 0){
    replacePlayer();
    teleportReload = TELEPORT_RELOAD;
  }else if(teleportReload != 0)
    teleportReload--;
  
  handleCollisions();
  handleSpawning();
}

private void handleBullets(){
  for(Bullet b : bullets)
    b.tick();
  for(int i = bullets.size() - 1; i >= 0; i--)
    if(bullets.get(i).done())
      bullets.remove(i);
}

private void handleCollisions(){
  for(int i = asteroids.size() - 1; i >= 0; i--){
    Asteroid a = asteroids.get(i);
    for(Bullet b: bullets){
      if(sq(b.x - a.x) + sq(b.y - a.y) <= sq(a.radius)){
        asteroids.remove(i);
        a.destroy();
        b.remove();
        break;
      }
    }
  }
  
  {
    int ai = checkForPlayerCollisions();
    if(ai != -1){
      asteroids.get(ai).destroy();
      asteroids.remove(ai);
      destroyPlayer();
    }
  }
}

private int getAsteroidCount(){
  return int(map(score, 0, 100, STARTING_ASTEROIDS, ASTEROIDS_AT_100_SCORE));
}

private void resetSpawnTimer(){
  spawnTimer = int(map(score, 0, 100, STARTING_SPAWN_TIME, SPAWN_TIME_AT_100_SCORE));
}

private void handleSpawning(){
  if(asteroids.size() < getAsteroidCount()){
    if(spawnTimer == -1){
      resetSpawnTimer();
    }
  }else{
    spawnTimer = -1;
  }
  
  if(spawnTimer > -1){
    spawnTimer--;
  }
  if(spawnTimer == 0){
    asteroids.add(new Asteroid());
  }
}

private void addScore(int d){
  score += d;
  highScore = max(score, highScore);
}
