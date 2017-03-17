import java.util.List;

class ReplacementRule{
  private int minAge, maxAge;
  private AgentFactory agentFactory;
  private ArrayList<Agent> agents;
  private ArrayList<Integer> lifespans;
  
  public ReplacementRule(int minAge, int maxAge, AgentFactory fac){
    this.minAge = minAge;
    this.maxAge = maxAge;
    this.agentFactory = fac;
    this.agents = new ArrayList<Agent>();
    this.lifespans = new ArrayList<Integer>();
  }
  
  //If this is the first time replaceThisOne is run with a, generate a lifespan
  //  for a and store it in a list
  //Returns true if a is not alive or the agent's age exceeds its lifespan
  //Returns false otherwise
  public boolean replaceThisOne(Agent a){
    if(a==null) return false;
    if(!a.isAlive()) return true;
    if(!this.agents.contains(a)){
      int ageRange = this.maxAge - this.minAge + 1;
      int lifespan = (int) (Math.random()*ageRange)+this.minAge;
      this.agents.add(a);
      this.lifespans.add(lifespan);
    }
    else{
      int index = this.agents.indexOf(a);
      int lifespan = this.lifespans.get(index);
      if(a.getAge()>=lifespan){
        a.setAge(a.getAge()+1);
        return true;
      }
    }
    return false;
  }
  
  //Returns a new Agent that is a replacement for Agent a
  public Agent replace(Agent a, List<Agent> others){
    return this.agentFactory.makeAgent();
  }
}