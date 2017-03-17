interface MovementRule{
  public Square move(LinkedList<Square> neighborhood, SugarGrid g, Square middle);
}

import java.util.Collections;

class PollutionMovementRule implements MovementRule{
  
  void PollutionMovementRule(){ }
  
  public Square move(LinkedList<Square> neighborhood, SugarGrid g, Square middle){
    
    //System.out.println("Neighborhood size: " + neighborhood.size());
    
    Collections.shuffle(neighborhood);
    ArrayList<Square> equal = new ArrayList<Square>();
    Square currentBest = new Square(-1,-1,-1,-1);
    currentBest.setPollution(1);
    double currBestRatio = 0.0;
    double currRatio = 1000000000.0;
      
    for(Square s : neighborhood){
      if(s.getPollution()==0&&currentBest.getPollution()==0){
        equal.add(s);
        currentBest = s;
      }
      else if(s.getPollution()==0){
        currentBest = s;
        equal = new ArrayList<Square>();
        equal.add(s);
      }
      else if(currentBest.getPollution()!=0){
        currBestRatio = (currentBest.getSugar()+0.0)/currentBest.getPollution();
        currRatio = (s.getSugar()+0.0)/s.getPollution();
        if(currRatio>currBestRatio){
          currentBest = s;
          equal = new ArrayList<Square>();
          equal.add(s);
        }
      }
    }
    
    Square sugarBest = new Square(-1,-1,-1,-1);
    if(currentBest.getPollution()==0){
      for(Square s : equal){
        if(s.getSugar()>sugarBest.getSugar()){
          equal = new ArrayList<Square>();
          equal.add(s);
          sugarBest = s;
        }
        else if(s.getSugar()==sugarBest.getSugar()) equal.add(s);
      }
    }
    
    Square closestBest = null;
    double currentDist = g.getWidth()*g.getHeight();
    for(Square s : equal){
      double dist = g.euclidianDistance(middle,s);
      if(dist<currentDist){
        closestBest = s;
        currentDist = dist;
      }
    }
    return closestBest;
  }  
}



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
  
  public void growback(Square s){
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