public with sharing class TransformeToSend {

  public TransformerSend toTransformer(Project__c project) {
    
    TransformerSend transformeToSend = new TransformerSend();

    transformeToSend.name = project.Name;

    return transformeToSend;

  } 

}