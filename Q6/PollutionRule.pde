class PollutionRule{
  private int gatheringPollution, eatingPollution;
  
  public PollutionRule(int gatheringPollution, int eatingPollution){
    this.gatheringPollution = gatheringPollution;
    this.eatingPollution = eatingPollution;
  }
  
  public void pollute(Square s){
    if(s.getAgent()!=null){
      int increase = s.getAgent().getMetabolism()*this.eatingPollution+
                     s.getSugar()*this.gatheringPollution;
      s.setOldPollution(s.getPollution());
      s.setPollution(s.getPollution()+increase);
    }
  }
}