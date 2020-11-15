import 'dart:convert';

class LoginUserInputModel {
  LoginUserInputModel(this.username, this.password);
  final String username;
  final String password;

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  factory LoginUserInputModel.fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }

    return LoginUserInputModel(
      map['username'] as String,
      map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginUserInputModel.fromJson(String source) =>
      LoginUserInputModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
