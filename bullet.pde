private static final float BULLET_SPEED = 10;
private static final int BULLET_LIFE = 100;

private class Bullet{
  private float x, y, dx, dy;
  private float life;
  
  public Bullet(){
    PVector spd = new PVector(BULLET_SPEED, 0).rotate(-playerR);
    x = playerX;
    y = playerY;
    dx = playerDX + spd.x;
    dy = playerDY + spd.y;
  }
  
  public void display(){
    stroke(255);
    line(x, y, x + dx, y + dy);
  }
  
  public void tick(){
    x = (x + dx + width) % width;
    y = (y + dy + height) % height;
    life++;
  }
  
  public boolean done(){
    return life >= BULLET_LIFE;
  }
  
  public void remove(){
    life = BULLET_LIFE;
  }
}
