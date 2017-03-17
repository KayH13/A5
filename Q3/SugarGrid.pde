import java.util.LinkedList;
import java.util.ArrayList;

//represents entire grid of squares
class SugarGrid{
  private ArrayList<ArrayList<Square>> grid = new ArrayList<ArrayList<Square>>();
  private int gridWidth, gridHeight;
  private int squareSideLength;
  private GrowbackRule growbackRule;
  
  public SugarGrid(int w, int h, int sideLen, GrowbackRule g){
    this.gridWidth = w;
    this.gridHeight = h;
    this.squareSideLength = sideLen;
    this.growbackRule = g;
    
    for(int col=0; col<this.gridWidth; col++){
      this.grid.add(new ArrayList<Square>());
      for(int row=0; row<this.gridHeight; row++){
        this.grid.get(col).add(new Square(0,0,col,row));
      }
    }
  }
  
  public int getWidth(){
    return this.gridWidth;
  }
  public int getHeight(){
    return this.gridHeight;
  }
  public int getSquareSize(){
    return this.squareSideLength;
  }
  public int getSugarAt(int i, int j){
    if(i>=0&&i<this.gridWidth&&j>=0&&j<this.gridHeight){
      return this.grid.get(i).get(j).getSugar();
    }
    return -1;
  }
  public int getMaxSugarAt(int i, int j){
    if(i>=0&&i<this.gridWidth&&j>=0&&j<this.gridHeight){
      return this.grid.get(i).get(j).getMaxSugar();
    }
    return -1;
  }
  public Agent getAgentAt(int i, int j){
    if(i>=0&&i<this.gridWidth&&j>=0&&j<this.gridHeight){
      return this.grid.get(i).get(j).getAgent();
    }
    return null;
  }
  
  public void placeAgent(Agent a, int x, int y){
    if(x>=0&&x<this.gridWidth&&y>=0&&y<this.gridHeight){
      if(a==null || this.grid.get(x).get(y).getAgent()==null || this.grid.get(x).get(y).getAgent()==a){
         this.grid.get(x).get(y).setAgent(a);
      }
      else assert(1==0);
    }
  }
  
  //computes the euclidian distance of 2 squares on the grid
  //tricky because the grid is tiroidal (if go off above the grid, come at bottom)
  //                                     if go off left, come at right)
  public double euclidianDistance(Square a, Square b){
    int tempX=a.getX();
    int tempX1=b.getX();
    int tempY=a.getY();
    int tempY1=b.getY();
    
    int diffX = tempX1-tempX;
    int diffY = tempY1-tempY;
    if(a.getX()<this.gridWidth && a.getX()>=0 && b.getX()<this.gridWidth && b.getX()>=0 && a.getY()<this.gridHeight && a.getY()>=0 && b.getY()<this.gridHeight && b.getY()>=0){
      if(abs(diffX)<=this.gridWidth/2){
        //stub
      }
      else if(abs(diffX)>this.gridWidth/2){
        if(tempX1>tempX){
          tempX1 = tempX1-this.gridWidth;
          diffX = tempX1-tempX;
        }
        else{
          tempX = tempX-this.gridWidth;
          diffX = tempX-tempX1;
        }
      }
      if(abs(diffY)<=this.gridHeight/2){
        //stub
      }
      else if(abs(diffY)>this.gridHeight/2){
        if(tempY1>tempY){
          tempY1 = tempY1-this.gridHeight;
          diffY = tempY1-tempY;
        }
        else{
          tempY = tempY-this.gridHeight;
          diffY = tempY-tempY1;
        }
      }
      double dist = Math.sqrt(diffX*diffX+diffY*diffY);
      return dist;
    }
    return -1.0; //shouldn't get here
  }
  
  
  //takes a middle (x,y), radius, and max, everything at the middle gets max
  //  amount of sugar, everything everything within radius get one less
  //  every thing within 2 radii get 2 less
  public void addSugarBlob(int x, int y, int radius, int max){
    if(x<this.gridWidth && x>=0 && y<this.gridHeight && y>=0){
      int counter=1;
      
      Square middle = this.grid.get(x).get(y);
      if(middle.getMaxSugar()<max){
        middle.setMaxSugar(max);
        middle.setSugar(max);
      }
      
      while(max-counter>0){
        for(int col=0; col<this.gridWidth; col++){
          //System.out.println("In loop, column: " + col);
          for(int row=0; row<this.gridHeight; row++){
            //System.out.println("In loop, row: " + row);
            Square current = this.grid.get(col).get(row);
            double dist = euclidianDistance(current, middle);
            //System.out.println("Dist: " + dist + " Radius: " + radius);
            if(dist<=counter*radius && current.getMaxSugar()<max-counter){
              current.setMaxSugar(max-counter);
              current.setSugar(max-counter);
              //System.out.println("middle" + middle.getX() + "," + middle.getY() + " current: " + current.getX() + "," + current.getY() + " Max sugar: " + current.getMaxSugar());
            } 
          }
        }
        counter++;
      }
    }
  }
  
  public LinkedList<Square> generateVision(int x, int y, int radius){
    if(x>=0 && x<this.gridWidth && y>=0 && y<this.gridHeight){
      LinkedList<Square> neighborhood = new LinkedList<Square>();
      Square middle = this.grid.get(x).get(y);
      neighborhood.add(middle);
      
      for(int col=0; col<this.gridWidth; col++){
        Square current = this.grid.get(col).get(y);
        double dist = euclidianDistance(current,middle);
        if(dist<=radius && dist!=0){
          neighborhood.add(current);
        }
      }
      for(int row=0; row<this.gridHeight; row++){
        Square current = this.grid.get(x).get(row);
        double dist = euclidianDistance(current,middle);
        if(dist<=radius && dist!=0){
          neighborhood.add(current);
        }
      }
      return neighborhood;
    }
    return null;
  }
  
  //handles all the changes that happen over time in the simulation
  //look at every square in grid, apply GrowbackRule to every square
  //look at each square and see whether there's an agent on the square or not
  // if yes, agent has to decide where it wants to go, move there, see if it
  //    has enough food left to be alive, if it's still alive, eats food there
  //create a LinkedList of agents, everytime an agent is processed, add it to
  //   the list, and everytime before we process an agent, check to see if it's
  //   already been processed (so it's not processed again)
  public void update(){
    LinkedList<Agent> processedAgents = new LinkedList<Agent>();
    for(int col=0; col<this.gridWidth; col++){
      for(int row=0; row<this.gridHeight; row++){
        Square current = this.grid.get(col).get(row);
        growbackRule.growBack(current);
        Agent currAgent = current.getAgent();
        if(currAgent!=null && !processedAgents.contains(currAgent)){
          int visionRadius = current.getAgent().getVision();
          LinkedList<Square> neighborhood = generateVision(current.getX(), current.getY(), visionRadius);
          MovementRule mr = currAgent.getMovementRule();
          Square whereNext = mr.move(neighborhood, this, current);
          if(whereNext.getAgent()==null) currAgent.move(current, whereNext);
          currAgent.step();
          if(!currAgent.isAlive()) current.setAgent(null);
          else currAgent.eat(whereNext);
          processedAgents.add(currAgent);
        }
      }
    }
  }
  
  //displays all squares in grid with agents on them if appropriate
  public void display(){
    for(int col=0; col<this.gridWidth; col++){
      for(int row=0; row<this.gridHeight; row++){
        Square current = this.grid.get(col).get(row);
        current.display(this.squareSideLength);
      }
    }
  }
  
  public void addAgentAtRandom(Agent a){
    int randX = (int) (Math.random()*this.gridWidth); //this.gridWidth because x starts at 0
    int randY = (int) (Math.random()*this.gridHeight);//this.gridHeight because y starts at 0
    if(getAgentAt(randX,randY)==null){
      placeAgent(a,randX,randY);
      //System.out.println("Agent " + a + " placed successfully. X: " + randX + " Y: " + randY + " Grid (X,Y): " + this.gridWidth +","+this.gridHeight);
    }
    else {
      //System.out.println("X: " + randX + " Y: " + randY);
      //System.out.println("Trying to find a place for agent " + a);
      addAgentAtRandom(a);
    }
  }
  
}