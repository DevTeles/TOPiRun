/**
 * @author: rafael.vital - topi
 */

@isTest
public class AccountFixtureFactory {

  public static Account newAccount ( String name, String documentNumber, City__c city, Cnae__c cnae ) {
    Account account = newAccount (name, documentNumber);
    account.BillingCity__c = city.Id;
    account.BillingCity__R = city;
    account.Cnae__c = cnae.Id;
    account.Cnae__r = cnae;

    return account;
  }

  public static Account createAccount ( String name, String documentNumber ) {
    return createAccount ( newAccount(name, documentNumber) );
  }

  public static Account createAccount ( String name, String documentNumber, City__c city, Cnae__c cnae) {
    return createAccount(newAccount(name, documentNumber, city, cnae));
  }

  public static Account createAccount ( Account account ) {
    insert account;
    return account;
  }

  public static Account newAccountPremium ( String name, String category, Decimal annualRevenue ) {
    return new Account ( Name = name, Category__c = category, AnnualRevenue = annualRevenue);
  }

  public static Account createAccountPremium ( String name, String category, Decimal annualRevenue) {
    return createAccount ( newAccountPremium(name, category, annualRevenue) );
  }

  public static Account newDefaultAccount () {
    String payload = '{"attributes":{"type":"Account","url":"/services/data/v51.0/sobjects/Account/0015Y00002bFkghQAC"},"Name":"Bisso 03","BillingState":"SP","BillingAddress":{"city":null,"country":null,"geocodeAccuracy":null,"latitude":null,"longitude":null,"postalCode":null,"state":"SP","street":null},"ShippingAddress":null,"PhotoUrl":"/services/images/photo/0015Y00002bFkghQAC","CreatedDate":"2021-03-10T14:39:43.000+0000","CreatedById":"0055Y00000Fat7lQAB","CleanStatus":"Pending","DocumentNumber__c":"06616854000183"}';
    return fromJson (payload);
  }

  public static fromJson(String payload) {
    return (Account) JSON.deserialize(payload, Account.class);
  }

  public static Map<String, SObject> createIntegratedScenario () {

    Map<String, SObject> records = new Map<String, SObject>();

    City__c city = CityFixtureFactory.createCity();
    records.put ( 'city-sp', city);

    Cnae__c cnae = CnaeFixtureFactory.createCnae();
    records.put ('cnae', cnae);

    Account account = createAccount('Bisso Account', '04908176027', city, cnae);
    records.put ('account', cnae);

    return records;

  }

}