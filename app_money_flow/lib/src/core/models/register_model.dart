import 'dart:convert';

class RegisterModel {
  String name;
  String email;
  String password;
  String confirmPassword;

  RegisterModel({required this.name, required this.email, required this.password, required this.confirmPassword});

  String toJson() {
    return jsonEncode({'name': name, 'email': email, 'password': password, 'confirmPassword': confirmPassword});
  }
}
