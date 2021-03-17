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

  public ProjectTH () {
    this ( (List<Project__c>) Trigger.new, (Map<Id,Project__c>) Trigger.oldMap );
  }

  public ProjectTH (List<Project__c> newProjects, Map<Id,Project__c> oldProjects) {
    this.newProjects = newProjects;
    this.oldProjects = oldProjects;

    filter = new AccountFilter();
    validator = new AccountValidator();  
  }

  override
  public void afterUpdate() {    
    sendProjectToLegacySystem();
  }

  virtual
  public void sendProjectToLegacySystem () {
    List<Account> filterAccounts = filter.filterByCategoryAnnualRevenue(newProjects, 'Premium', 1000000);
    
    EventRepository repository = new EventRepository();

    repository.create(this.enricherEvent.createEventPremium(filterAccounts));
  }

  virtual  
  public void validateDocumentNumber () {

    List<Account> filterdAccounts = this.filter.filterByChangeDocumentNumber(newProjects
                                                                              , oldProjects);
    this.validator.validateDocumentNumber(filterdAccounts);
  }

}