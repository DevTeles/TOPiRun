/**
 * @author: rafael.vital - topi
 */
public class ProjectFilter extends Filter {

  public List<Project__c> filterByEnterpriseProjectStarted ( List<Project__c> newProjects
                                                      , Map<Id,Project__c> oldProjects ) {
     
      List<Project__c> filteredProjects = new List<Project__c> ();                                                        

      if (newProjects.isEmpty()) return filteredProjects;

      for ( Project__c project : newProjects ) {

        if (project.Type__c != 'Enterprise' 
           || project.Status__c != 'Iniciado')
          continue;

        if ( oldProjects == null || oldProjects.isEmpty() ) {
          filteredProjects.add(project);
            continue;
        }

        filteredProjects.add( project );
      }

      return filteredProjects;
  }
  
  public List<Project__c> filterByTypeStatus ( List<Project__c> projects, String type, String status ) {
      
    List<Project__c> filterProjects = new List<Project__c>();
 
    if (projects.isEmpty()) return filterProjects;

    for ( Project__c project : projects ) {

      if (project.Type__c == type && project.Status__c == status) {
        filterProjects.add(project);
      }

    }

    return filterProjects;
  }
  
}