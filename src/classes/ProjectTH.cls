/**
 * Não pode ser grande !!!
 * 
 * Ela delega !!!
 * 
 * - Filtra (Filter)
 * - Validar (Validator)
 * - Enriquecer (Enricher)
 * - Publicar (Publisher)
 * 
 * @author rafael.vital - topi
 */

public with sharing class ProjectTH extends TriggerHandler {

  List<Project__c> newProjects;
  Map<Id,Project__c> oldProjects;
  
  ProjectFilter filter; 

  SendTopiProjectAsync sendTopiProjectAsync;

  public ProjectTH () {
    this ( (List<Project__c>) Trigger.new, (Map<Id,Project__c>) Trigger.oldMap );
  }

  public ProjectTH (List<Project__c> newProjects, Map<Id,Project__c> oldProjects) {
    this.newProjects = newProjects;
    this.oldProjects = oldProjects;

    filter = new ProjectFilter();      
    sendTopiProjectAsync = new SendTopiProjectAsync();
  }

  override
  public void afterUpdate() {        
    sendProjectsToLegacySystem();
  }

  virtual
  public void sendProjectsToLegacySystem () {
    List<Project__c> filterProjects = filter.filterByEnterpriseProjectStarted(newProjects, oldProjects);

    if (filterProjects.isEmpty()) return;

    // To convert project to list of id;
    sendTopiProjectAsync.sendProject(filter.convertSObjectList(filterProjects, 'Id'));
  } 

}