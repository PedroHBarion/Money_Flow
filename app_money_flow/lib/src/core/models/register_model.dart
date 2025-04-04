import 'dart:convert';

class RegisterModel {
  String name;
  String email;
  String password;

  RegisterModel(
      {required this.name, required this.email, required this.password});

  String toJson() {
    return jsonEncode({'name': name, 'email': email, 'password': password});
  }
}
