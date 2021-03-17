/**
 * @author: rafael.vital - topi
 */
public class ZipCodeAddressTransformer {

  public ZipCodeAddress toAddress ( ViaCepAddressResponse viaCepAddress ) {

    ZipCodeAddress address = new ZipCodeAddress ();
    address.street = viaCepAddress.logradouro;
    address.state = viaCepAddress.uf;
    address.city = viaCepAddress.localidade;
    address.zipCode = viaCepAddress.cep;

    return address;
    
  }

}