private static final float MIN_RADIUS = 20;
private static final float START_RADIUS = 60;
private static final float RADIUS_MODIFIER = 0.71;
private static final float MIN_SPEED = 1;
private static final float MAX_SPEED = 5;
private static final int VERTEX_COUNT = 7;
private static final float INIT_GAP = 50;

private class Asteroid{
  private PShape shape;
  private float[] xVertices, yVertices;
  private float radius;
  private float x, y, dx, dy;
  private float rotation = 0, rotSpeed;
  
   public Asteroid(){
     this(0, 0);
     randomizePosition();
   }
   private void randomizePosition(){
     switch(int(random(4))){
       case 0:
         x = random(INIT_GAP, width - INIT_GAP);
         y = INIT_GAP;
         return;
       case 1:
         x = random(INIT_GAP, width - INIT_GAP);
         y = height - INIT_GAP;
         return;
       case 2:
         y = random(INIT_GAP, height - INIT_GAP);
         x = INIT_GAP;
         return;
       case 3:
         y = random(INIT_GAP, height - INIT_GAP);
         x = width - INIT_GAP;
         return;
     }
   }
  
  public Asteroid(float x, float y){
    radius = START_RADIUS;
    this.x = x;
    this.y = y;
    init();
  }
  
  public Asteroid(Asteroid source){
    x = source.x;
    y = source.y;
    radius = source.radius * RADIUS_MODIFIER;
    init();
  }
  
  private void init(){
    float a = random(TWO_PI);
    float s = map(radius, START_RADIUS, MIN_RADIUS, MIN_SPEED, MAX_SPEED);
    dx = cos(a) * s;
    dy = -sin(a) * s;
    rotSpeed = (s * random(0.8, 1.2)) / 20;
    if(int(random(2)) == 1)
      rotSpeed = -rotSpeed;
    initShape();
  }
  
  private void initShape(){
    float[] a = new float[VERTEX_COUNT];
    float s = 0;
    shape = createShape();
    xVertices = new float[VERTEX_COUNT];
    yVertices = new float[VERTEX_COUNT];
    for(int i = 0; i < VERTEX_COUNT; i++){
      float r = random(1, 5);
      a[i] = r;
      s += r;
    }
    shape.beginShape();
    shape.noFill();
    shape.stroke(255);
    for(int i = 0; i < VERTEX_COUNT; i++){
      a[i] = map(a[i], 0, s, 0, TWO_PI);
      if(i > 0)
        a[i] += a[i - 1];
      xVertices[i] = cos(a[i]) * radius;
      yVertices[i] = -sin(a[i]) * radius;
      shape.vertex(xVertices[i], yVertices[i]);
    }
    shape.endShape(CLOSE);
  }
  
  public void tick(){
    x = (x + dx + width) % width;
    y = (y + dy + height) % height;
    rotation = (rotation + rotSpeed + TWO_PI) % TWO_PI;
  }
  
  public void display(){
    pushMatrix();
    translate(x, y);
    rotate(-rotation);
    shape(shape);
    popMatrix();
  }
  
  public void destroy(){
    if(radius * RADIUS_MODIFIER >= MIN_RADIUS){
      asteroids.add(new Asteroid(this));
      asteroids.add(new Asteroid(this));
    }
    addScore(1);
  }
}
