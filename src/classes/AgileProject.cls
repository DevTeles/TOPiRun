global class AgileProject {

  public String name;
  public Date startDate;
  public Date endDate;
  public String externalId;

  public List<Sprint> sprints;

  public class Sprint {

    public String name;
    public Date startDate;
    public Date endDate;

    public List<UserStory> userStories;

  }

  public class UserStory {
    
    public String name;
    public Integer priority;
    public Integer points;

  }

}