/**
 * @author: rafael.vital - topi
 */

public class GetAddressOubountService {

  ZipCodeAddressTransformer transformer;

  public GetAddressOubountService () {
    transformer = new ZipCodeAddressTransformer();
  }

  public ZipCodeAddress findAddress ( String zipCode ) {
    return transformer.toAddress( findViaCepAddress(zipCode) );
  }

  public ViaCepAddressResponse findViaCepAddress ( String zipCode ) {

    HttpRequest request = new HttpRequest();
    request.setEndpoint('http://viacep.com.br/ws/'+ zipCode +'/json/');
    request.setMethod('GET');
    request.setHeader('Content-Type', 'application/json');         

    Http http = new Http();
    HttpResponse response = http.send(request);

    String payload = response.getBody();

    System.debug('payload: ' + payload);

    return (ViaCepAddressResponse) JSON.deserialize( payload, ViaCepAddressResponse.class );

  }

}