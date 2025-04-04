import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage();

  static Future<void> writeToken(String token) async {
    await _storage.write(key: 'accessToken', value: token);
  }

  static Future<String?> readToken() async {
    return await _storage.read(key: 'accessToken');
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: 'accessToken');
  }
}
