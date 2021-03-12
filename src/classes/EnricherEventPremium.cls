/**
 * @author: rafael.vital - topi
 */

public with sharing class EnricherEventPremium {

  virtual
  public List<Event> createEventPremium (List<Account> accountsPremium) {

    List<Event> newEvents = new List<Event>();

    for (Account account : accountsPremium) {

      Event event = new Event();
    
      event.Description = 'Apresentar o portifolio de Produtos para o novo cliente com enfoque em nossa carteira Premium';
      event.Subject = 'Apresentação instucional dos produtos Premium';
      event.StartDateTime = Datetime.now().addDays(1);
      event.EndDateTime = Datetime.now().addDays(1).addHours(1);
      event.WhatId = account.Id;
      event.ContactType__c = 'Telefônico';

      newEvents.add(event);

    }

    return newEvents;
  }

}