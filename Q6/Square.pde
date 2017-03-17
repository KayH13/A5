class Square{
  private int sugarLevel, maxSugarLevel;
  private int pollution;
  private int x, y;
  private Agent agent;
  
  public Square(int sugarLevel, int sugarLevelMax, int x, int y){
    this.sugarLevel = sugarLevel;
    this.maxSugarLevel = sugarLevelMax;
    this.pollution = 0;
    this.x = x;
    this.y = y;
    this.agent = null;
  }
  public int getX(){ return this.x; }
  public int getY(){ return this.y; }
  public int getSugar(){ return this.sugarLevel; }
  public int getMaxSugar(){ return this.maxSugarLevel; }
  public int getPollution(){ return this.pollution; }
  
  public void setPollution(int level){
    this.pollution = level;
  }
  public void setSugar(int desiredAmount){
    if(desiredAmount<0) this.sugarLevel = 0;
    else if(desiredAmount>this.maxSugarLevel) this.sugarLevel = this.maxSugarLevel;
    else this.sugarLevel = desiredAmount;
  }
  public void setMaxSugar(int desiredAmount){
    if(desiredAmount<0) this.maxSugarLevel = 0;
    else this.maxSugarLevel = desiredAmount;
    if(this.sugarLevel>this.maxSugarLevel) this.sugarLevel = this.maxSugarLevel;
  }
  
  public Agent getAgent(){
    return this.agent;
  }
  public void setAgent(Agent a){
    if(this.agent==null || a==null || a==this.agent) this.agent = a;
    else assert(1==0);
  }
  
  public void display(int size){
    strokeWeight(4);
    stroke(255);
    fill(255,255,255-this.sugarLevel/6.0*255);
    rect(size*x, size*y, size, size);
    fill(0);
    stroke(0);
    if(getAgent()!=null && getAgent().isAlive()){
      getAgent().display(size*x+size/2, size*y+size/2,size);
    }
  }
}