/**
 * @author: rafael.vital - topi
 */
public with sharing class SyncTopiRunProjectOubound {

  public static final String END_POINT_URL = 'https://run.mocky.io/v3/58d750c1-31bf-45ae-b361-bedecacf55a2';

  TopiRunProjectTransformer transformer;

  ProjectRepository repository;

  public SyncTopiRunProjectOubound () {
    transformer = new TopiRunProjectTransformer();
    repository = new ProjectRepository();
  }

  public Project__c sendProject (Project__c project) {

    Http http = new Http();

    HttpResponse response; // = http.send( buildRequest(project) );

    if (response.getStatusCode() != 200) {
      TopiRunErrorResponse errorResponse = (TopiRunErrorResponse) JSON.deserialize( response.getBody(), TopiRunErrorResponse.class);

      project = transformer.toProject(project, errorResponse);
    }

    TopiRunProjectResponse topiRunProjectResponse = (TopiRunProjectResponse) JSON.deserialize(response.getBody(), TopiRunProjectResponse.class);

    project = transformer.toProject(project, topiRunProjectResponse);

    return project;
  }

  private HttpRequest buildRequest (Projetc__c project) {

    HttpRequest request = new HttpRequest ();
    request.setEndpoint(END_POINT_URL);
    request.setMethod('PUT');
    request.setHeader('Content-Type', 'application/json');

    TopiRunProjectRequest projectRequest = transformer.toTopiRunProject(project);

    String payload = JSON.serialize(projectRequest);

    request.setBody(payload);

    return request;
  }

}