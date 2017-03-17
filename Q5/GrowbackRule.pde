interface GrowthRule{
  public void growBack(Square s);
}

//============================================

// represent G rules in Axel and Epstein's book
// rate at which sugar grows back on the sugarscape
//    g(infinite) rule (each iteration results in the square's sugar = maxCapacity)
//    g(1) rule rule (each iteration results in the sugar level increasing by 1 for each square)
class GrowbackRule implements GrowthRule{
  private int rate;
  
  public GrowbackRule(int r){
    this.rate = r;
  }
  
  public void growBack(Square s){
    s.setSugar(s.getSugar()+this.rate);
  } 
}

//============================================

class SeasonalGrowbackRule implements GrowthRule{
  private int alpha, beta, gamma, equator, numSquares;
  private boolean northSummer;
  private int numTimesCalled;
  
  public SeasonalGrowbackRule(int alpha, int beta, int gamma, int equator, 
                              int numSquares){
    this.alpha = alpha;
    this.beta = beta;
    this.gamma = gamma;
    this.equator = equator;
    this.numSquares = numSquares;
    this.northSummer = true;
    this.numTimesCalled = 0;
  }
  
  public int getAlpha(){ return this.alpha; }
  public int getBeta(){ return this.beta; }
  public int getGamma(){ return this.gamma; }
  public int getEquator(){ return this.equator; }
  public int getNumSquares(){ return this.numSquares; }
  public int getNumTimesCalled(){ return this.numTimesCalled; }
  
  public void growBack(Square s){
    this.numTimesCalled++;
    if(numTimesCalled==this.gamma*this.numSquares){
      this.northSummer = !this.northSummer;
      numTimesCalled=0;
    }
    if((s.getY()<=this.equator&&northSummer)||(s.getY()>this.equator&&!northSummer)){
      s.setSugar(s.getSugar()+this.alpha);
    }
    else{
      s.setSugar(s.getSugar()+this.beta);
    }
  }
  
  public boolean isNorthSummer(){
    return this.northSummer;
  }
}