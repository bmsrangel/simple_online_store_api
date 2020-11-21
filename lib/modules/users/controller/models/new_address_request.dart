import 'package:aqueduct/aqueduct.dart';

class NewAddressRequest extends Serializable {
  String street;
  String number;
  String complement;
  String zipCode;
  String city;
  String state;
  String country;

  @override
  Map<String, dynamic> asMap() {
    return {
      'street': street,
      'number': number,
      'complement': complement,
      'zip_code': zipCode,
      'city': city,
      'state': state,
      'country': country,
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    street = object['street'] as String;
    number = object['number'] as String;
    complement = object['complement'] as String;
    zipCode = object['zip_code'] as String;
    city = object['city'] as String;
    state = object['state'] as String;
    country = object['country'] as String;
  }
}
