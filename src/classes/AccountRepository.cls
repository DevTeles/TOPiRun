/**
 * @author rafael.vital - topi
 */

public virtual class AccountRepository {
  
  virtual
  public List<Account> findByName ( String name ) {

    return [ SELECT Id, Name, Type, BillingCity, BillingState, BillingPostalCode, BillingCountry, BillingLatitude, BillingLongitude, CreatedDate
    FROM Account 
    WHERE Name like :name ];
  }

  virtual
  public List<Account> findWithContactsByName ( String name ) {

    return [ SELECT Id, Name, Type, BillingCity, BillingState, BillingPostalCode 
                    , BillingCountry, BillingLatitude, BillingLongitude, CreatedDate, CreatedBy.Name
                    , ( SELECT Id, FirstName, LastName FROM Contacts)
    FROM Account 
    WHERE Name like :name ];
  }

  virtual
  public List<Account> create (List<Account> accounts) {
    insert accounts;
    return accounts;
  }

  virtual
  public List<Account> store (List<Account> accounts) {
    update accounts;
    return accounts;
  }

  virtual
  public void remove (List<Account> accounts) {
    delete accounts;    
  }
}