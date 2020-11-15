import 'package:aqueduct/aqueduct.dart';

class RegisterRequest extends Serializable {
  String name;
  String username;
  String email;
  String password;

  @override
  Map<String, dynamic> asMap() {
    return {
      "name": name,
      "username": username,
      "email": email,
      "password": password,
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    name = object["name"] as String;
    username = object["username"] as String;
    email = object["email"] as String;
    password = object["password"] as String;
  }
}
