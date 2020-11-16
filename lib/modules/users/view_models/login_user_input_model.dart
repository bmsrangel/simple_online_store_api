import 'dart:convert';

class LoginUserInputModel {
  LoginUserInputModel(this.email, this.password);
  final String email;
  final String password;

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory LoginUserInputModel.fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }

    return LoginUserInputModel(
      map['email'] as String,
      map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginUserInputModel.fromJson(String source) =>
      LoginUserInputModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
