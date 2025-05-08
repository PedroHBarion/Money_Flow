import 'dart:convert'; 
import '../models/login_model.dart';
import '../models/register_model.dart';
import '../services/http/http_client.dart';

class UserModel {

  final String name;
  final String email;

  UserModel({ required this.name, required this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
    );
  }
}


class AuthService {
  final HttpClient httpClient;

  AuthService(this.httpClient);

  Future<String> signin(LoginModel login) async {
    final responseBody =
        await httpClient.post('/auth/signin', body: login.toJson());
    final responseJson = jsonDecode(responseBody);
    return responseJson['accessToken'];
  }

  Future<String> signup(RegisterModel register) async {
    final responseBody =
        await httpClient.post('/auth/signup', body: register.toJson());
    final responseJson = jsonDecode(responseBody);
    return responseJson['accessToken'];
  }

 Future<UserModel?> validateToken(String token) async {
  try {
    final responseBody = await httpClient.get('/users/me');
    final responseJson = jsonDecode(responseBody);
    return UserModel.fromJson(responseJson);
  } catch (e) {
    return null;
  }
}
}
