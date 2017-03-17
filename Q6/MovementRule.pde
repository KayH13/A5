import java.util.Collections;


interface MovementRule{
  public Square move(LinkedList<Square> neighborhood, SugarGrid g, Square middle);
}

//=======================================================//

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
      //if(neighborhood.size()<10) System.out.println("Current pollution level: " + s.getPollution());
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
        //if(neighborhood.size()<10) System.out.println("I'm here.  Current best pollution level: " + currentBest.getPollution());
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
      //System.out.println("In: " + s.getPollution());
    }
    //System.out.println("After: " + closestBest);
    return closestBest;
  }   
}

//=======================================================//

class SugarSeekingMovementRule implements MovementRule{
   
  public SugarSeekingMovementRule(){ }
  
  //want to find the square with the most sugar, if there's a tie, return
  //   the square that's closest to the agent
  public Square move(LinkedList<Square> neighbourhood, SugarGrid g, Square middle){
    //neighbourhood: everything it can see
    //middle: where the agent is right now
    
    Collections.shuffle(neighbourhood); //the contents of the LinkedList will be randomized
    ArrayList<Square> equal = new ArrayList<Square>();
    Square currentBest = new Square(-1,-1,-1,-1);
    //System.out.println("1: " + currentBest.getX() + "," + currentBest.getY() + " maxSugar: " + currentBest.getMaxSugar());
    for(Square s : neighbourhood){
      if(s.getSugar()==currentBest.getSugar()){
        equal.add(s);
      }
      if(s.getSugar()>currentBest.getSugar()){
        currentBest = s;
        equal = new ArrayList<Square>();
        equal.add(s);
      }
    }
    //for(Square s : equal){
    //  System.out.println("2: " + s.getX() + "," + s.getY() + " maxSugar: " + s.getMaxSugar());  
    //}
    
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