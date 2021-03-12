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

public virtual with sharing class AccountTH extends TriggerHandler {

  List<Account> newAccounts;

  Map<Id,Account> oldAccounts;
  
  EnricherEventPremium enricherEvent;

  AccountFilter filter;  

  AccountValidator validator;  

  public AccountTH () {
    this ( (List<Account>) Trigger.new, (Map<Id,Account>) Trigger.oldMap );
  }

  public AccountTH (List<Account> newAccounts, Map<Id,Account> oldAccounts) {
    this.newAccounts = newAccounts;
    this.oldAccounts = oldAccounts;

    this.filter = new AccountFilter();
    this.validator = new AccountValidator();

    this.enricherEvent = new EnricherEventPremium();    
  }

  override
  public void beforeInsert() {
    validateDocumentNumber ();    
  }

  override
  public void beforeUpdate() {
    validateDocumentNumber ();        
  }

  override
  public void afterInsert() {
    createEventPremiumAccount ();
  }

  virtual
  public void createEventPremiumAccount () {
    List<Account> filterAccounts = this.filter.filterByCategoryAnnualRevenue(newAccounts, 'Premium', 1000000);
    
    EventRepository repository = new EventRepository();

    repository.create(this.enricherEvent.createEventPremium(filterAccounts));
  }

  virtual  
  public void validateDocumentNumber () {

    List<Account> filterdAccounts = this.filter.filterByChangeDocumentNumber(newAccounts
                                                                              , oldAccounts);
    this.validator.validateDocumentNumber(filterdAccounts);
  }

}