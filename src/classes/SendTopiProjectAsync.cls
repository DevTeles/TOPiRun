public with sharing class SendTopiProjectAsync {

  @future (callout=true)
  public static void sendProject (List<String> projectIds) {

    ProjectRepository repository = new ProjectRepository();
    List<Project__c> projects = repository.findByIds(projectIds);

    SyncTopiRunProjectOubound service;

    for (Project__c projetc : projects) {

      service = new SyncTopiRunProjectOubound();
      service.sendProject(projetc);

    }

    repository.store (projects);

  }

}