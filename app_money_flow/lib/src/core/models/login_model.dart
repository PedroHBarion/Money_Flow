import 'dart:convert';

class LoginModel {
  String email;
  String password;

  LoginModel({required this.email, required this.password});

  String toJson() {
    return jsonEncode({'email': email, 'password': password});
  }
}
