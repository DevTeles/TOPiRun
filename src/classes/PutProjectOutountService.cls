/**
 * @author: rafael.vital - topi
 */
public class PutProjectOutountService {

  ZipCodeAddressTransformer transformer;

  public PutProjectOutountService () {
    transformer = new ZipCodeAddressTransformer();
  } 

  public ZipCodeAddress updateProject ( List<Project__c> projects) {
    return transformer.toAddress( updateProjectLegacy(projects) );
  }

  public ProjectExternalResponse updateProjectLegacy ( List<Project__c> projects ) {

    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://run.mocky.io/v3/58d750c1-31bf-45ae-b361-bedecacf55a2');
    request.setMethod('PUT');
    request.setHeader('Content-Type', 'application/json');         

    String payload = '{ "name" : "TopiRun2020", "code" : "2424232", "status" : "Iniciado", "startDate" : "2020-01-01", "endDate" : "2020-12-01", "budget" : 200000.00 }';
    request.setBody(payload);

    Http http = new Http();
    HttpResponse response = http.send(request);

    System.debug('getBody: ' + response.getBody());
    System.debug('getStatusCode: ' + response.getStatusCode());

    //ProjectRepository repository = new ProjectRepository();

    //repository.create(projectEnricher.changeProjectStatusSuccess(filterProjects));
    
    return (ProjectExternalResponse) JSON.deserialize( response.getBody(), ProjectExternalResponse.class );
  }

}