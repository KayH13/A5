class AgentFactory{
  private int minMetabolism, maxMetabolism;
  private int minVision, maxVision;
  private int minInitSugar, maxInitSugar;
  private MovementRule movementRule;
  
  public AgentFactory(int minMet, int maxMet, int minVis, int maxVis, int minInitSug, int maxInitSug, MovementRule mr){
    this.minMetabolism = minMet;
    this.maxMetabolism = maxMet;
    this.minVision = minVis;
    this.maxVision = maxVis;
    this.minInitSugar = minInitSug;
    this.maxInitSugar = maxInitSug;
    this.movementRule = mr;
  }
  
  public Agent makeAgent(){
    int randMet = (int) (random(this.minMetabolism,this.maxMetabolism+1));
    int randVis = (int) (random(this.minVision,this.maxVision+1));
    int randInitSug = (int) (random(this.minInitSugar,this.maxInitSugar+1));
    return new Agent(randMet, randVis, randInitSug, this.movementRule);
  }
  
}