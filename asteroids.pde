import java.util.HashSet;

private static final int KEY_THRUST = 104;
private static final int KEY_LEFT = 100;
private static final int KEY_RIGHT = 102;
private static final int KEY_FIRE = 96;
private static final int KEY_TELEPORT = ENTER;

private static final int TICK_DELAY = 50;
private int lastTick;
private HashSet<Integer> pressedKeys = new HashSet<Integer>();

public void setup(){
  size(800, 600);
  createPlayerShapes();
  highScore = parseInt(loadStrings("data.txt")[0]);
  newGame();
}

public void draw(){
  renderFrame();
  if(millis() - lastTick >= TICK_DELAY){
    lastTick += TICK_DELAY;
    gameTick();
  }
}

public void keyPressed(){
  pressedKeys.add(keyCode);
}

public void keyReleased(){
  pressedKeys.remove(keyCode);
}

private boolean isKeyPressed(int k){
  return pressedKeys.contains(k);
}
