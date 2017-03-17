class Agent{
  private int metabolicRate;
  private int vision;
  private int sugarLevel;
  private int age;
  private MovementRule movementRule;
  
  public Agent(int metabolicRate, int vision, int sugarLevel, MovementRule mr){
    this.metabolicRate = metabolicRate;
    this.vision = vision;
    this.sugarLevel = sugarLevel;
    this.age = 0;
    this.movementRule = mr;
  }
  
  public int getMetabolism(){
    return this.metabolicRate;
  }
  public int getVision(){
    return this.vision;
  }
  public int getSugarLevel(){
    return this.sugarLevel;
  }
  public int getAge(){
    return this.age;
  }
  
  public void setAge(int howOld){
    if(howOld>=0) this.age = howOld;
    else assert(1==0);
  }
  
  public MovementRule getMovementRule(){
    return this.movementRule;
  }
  
  public void move(Square source, Square dest){
    source.setAgent(null);
    dest.setAgent(this);
  }
  
  //Agent ages a little
  public void step(){
    this.age++;
    if(this.sugarLevel>=this.metabolicRate){
      this.sugarLevel = this.sugarLevel-this.metabolicRate;
    }
    else if(this.sugarLevel<this.metabolicRate){
      this.sugarLevel = 0;
    }
  }
  
  //true if agent has more than 0 sugar
  public boolean isAlive(){
    return this.sugarLevel>0;
  }
  
  public void eat(Square s){
    this.sugarLevel += s.getSugar();
    s.setSugar(0);
  }
  
  public void display(int x, int y, int scale){
    fill(0);
    ellipse(x,y,3*scale/4,3*scale/4);
  }
}
