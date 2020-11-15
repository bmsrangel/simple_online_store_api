import 'package:aqueduct/aqueduct.dart';

class LoginRequest extends Serializable {
  String username;
  String password;

  @override
  Map<String, dynamic> asMap() {
    return {
      "username": username,
      "password": password,
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    username = object["username"] as String;
    password = object["password"] as String;
  }
}
