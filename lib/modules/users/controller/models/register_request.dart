import 'package:aqueduct/aqueduct.dart';

class RegisterRequest extends Serializable {
  String name;
  String birthDate;
  String email;
  String password;

  @override
  Map<String, dynamic> asMap() {
    return {
      "name": name,
      "birthDate": birthDate,
      "email": email,
      "password": password,
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    name = object["name"] as String;
    birthDate = object["birthDate"] as String;
    email = object["email"] as String;
    password = object["password"] as String;
  }
}
