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
    int metRange = this.maxMetabolism-this.minMetabolism + 1;
    int randMet = (int) (Math.random()*metRange) + this.minMetabolism;
    int visRange = this.maxVision-this.minVision + 1;
    int randVis = (int) (Math.random()*visRange) + this.minVision;
    int initSugRange = this.maxInitSugar-this.minInitSugar + 1;
    int randInitSug = (int) (Math.random()*initSugRange) + this.minInitSugar;
    return new Agent(randMet, randVis, randInitSug, this.movementRule);
  }
  
}