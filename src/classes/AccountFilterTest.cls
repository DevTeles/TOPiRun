@isTest
public class AccountFilterTest {
 
  @isTest
  static void filterAccountsByDocumentNumberTest() {
    
    List<Account> accounts = new List<Account>();

    accounts.add ( AccountFixtureFactory.newAccount('Teste 01', '37618054037' ) );
    accounts.add ( AccountFixtureFactory.newAccount('Teste 02', '25059536009' ) );    
    insert accounts;

    AccountFilter filter = new AccountFilter();

    List<Account> filteredAccounts = filter.filterByChangeDocumentNumber(accounts, null);

    System.assertEquals(accounts.size(), filteredAccounts.size());

    filteredAccounts = filter.filterByChangeDocumentNumber(accounts, new Map<Id,Account>());

    System.assertEquals(accounts.size(), filteredAccounts.size());

    Map<Id,Account> oldAccounts = new Map<Id,Account> (accounts);

    Account changedAccount = accounts.get(0).clone(true, true, true, true);
    changedAccount.DocumentNumber__c = 'X';
    oldAccounts.put(changedAccount.Id, changedAccount);

    filteredAccounts = filter.filterByChangeDocumentNumber(accounts, oldAccounts);

    System.assertNotEquals(accounts.size(), filteredAccounts.size());
    System.assert( filteredAccounts.size() == 1 );

    accounts = new List<Account>();
    accounts.add (new Account (Name = 'Teste 01') );
    accounts.add (new Account (Name = 'Teste 02') );
    filteredAccounts = filter.filterByChangeDocumentNumber(accounts, null);

    System.assert( filteredAccounts.isEmpty() );

  }

  @isTest
  static void filterByCategoryAnnualRevenueTest() {
    
    AccountFilter filter = new AccountFilter();
    
    List<Account> newAccounts = new List<Account>();

    newAccounts.add( AccountFixtureFactory.newAccountPremium('Teste 7', 'Premium', 1000000) );
    newAccounts.add( AccountFixtureFactory.newAccountPremium('Teste 9', 'Standard', 600000) );
    insert newAccounts;
    
    List<Account> filterAccounts = filter.filterByCategoryAnnualRevenue(newAccounts, 'Premium', 1000000);            

    System.assertNotEquals(newAccounts.size(), filterAccounts.size());
  }

}