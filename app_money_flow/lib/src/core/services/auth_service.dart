import 'dart:convert'; // Import necessário para usar jsonDecode
import '../models/login_model.dart';
import '../models/register_model.dart';
import '../services/http/http_client.dart';

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

  Future<bool> validateToken(String token) async {
    try {
      final responseBody = await httpClient.get('/users/me');
      final responseJson = jsonDecode(responseBody);
      return responseJson != null;
    } catch (e) {
      return false;
    }
  }
}
