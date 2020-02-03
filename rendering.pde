private PShape playerShape, flameShape;

private void renderFrame(){
  background(0);
  for(Asteroid a : asteroids)
    a.display();
  for(Bullet b : bullets)
    b.display();
  displayPlayer();
  displayGUI();
}

private void displayPlayer(){
  pushMatrix();
  translate(playerX, playerY);
  rotate(-playerR);
  shape(playerShape);
  if(isKeyPressed(KEY_THRUST))
    shape(flameShape);
  popMatrix();
}

private void displayGUI(){
  fill(255, 50);
  noStroke();
  rect(0, 0, 395, 100);
  rect(0, 0, 395 * (score / float(highScore)), 50);
  rect(405, 0, 395, 50);
  rect(405, 50, 190, 50);
  rect(605, 50, 195, 50);
  rect(405, 50, 190 * (1 - bulletReload / float(BULLET_RELOAD)), 50);
  rect(605, 50, 195 * (1 - teleportReload / float(TELEPORT_RELOAD)), 50);
  textSize(40);
  fill(255);
  textAlign(LEFT);
  text("Score:", 10, 40);
  text("High:", 10, 90);
  text("Lives:", 415, 40);
  textAlign(RIGHT);
  text(score, 385, 40);
  text(highScore, 385, 90);
  textAlign(CENTER);
  text("Fire", 500, 90);
  text("Teleport", 700, 90);
  
  for(int i = 0; i < lives; i++){
    pushMatrix();
    translate(800 - i * 50 - 25, 25);
    rotate(-HALF_PI);
    scale(0.8, 0.8);
    shape(playerShape);
    popMatrix();
  }
}

private void  createPlayerShapes(){
  playerShape = createShape();
  playerShape.beginShape(LINES);
  playerShape.noFill();
  playerShape.stroke(255);
  playerShape.vertex(20, 0);
  playerShape.vertex(-20, -10);
  playerShape.vertex(20, 0);
  playerShape.vertex(-20, 10);
  playerShape.vertex(-10, -7.5);
  playerShape.vertex(-10, 7.5);
  playerShape.endShape();
  
  flameShape = createShape();
  flameShape.beginShape(LINES);
  flameShape.noFill();
  flameShape.stroke(255);
  flameShape.vertex(-10, -7.5);
  flameShape.vertex(-25, 0);
  flameShape.vertex(-10, 7.5);
  flameShape.vertex(-25, 0);
  flameShape.endShape();
}
