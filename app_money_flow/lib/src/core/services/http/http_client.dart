import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Simula delay de rede (somente para ambiente de desenvolvimento)
Future<void> simulateNetworkDelay() async {
  await Future.delayed(const Duration(milliseconds: 500));
}


class HttpClient {
  final String baseUrl;
  final _storage = const FlutterSecureStorage();

  HttpClient(this.baseUrl);

  Future<Map<String, String>> _getHeaders() async {
    String? token = await _storage.read(key: 'accessToken');
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Uri _buildUri(String path, [Map<String, dynamic>? queryParams]) {
    final stringParams = queryParams?.map((key, value) => MapEntry(key, value.toString()));
    return Uri.parse(baseUrl + path).replace(queryParameters: stringParams);
  }


  Future<dynamic> get(String path, {Map<String, dynamic>? queryParams}) async {
    return _makeRequest(path, 'GET', queryParams: queryParams);
  }

  Future<dynamic> post(String path, {dynamic body}) async {
    return _makeRequest(path, 'POST', body: body);
  }

  Future<dynamic> put(String path, {dynamic body}) async {
    return _makeRequest(path, 'PUT', body: body);
  }

  Future<dynamic> delete(String path) async {
    return _makeRequest(path, 'DELETE');
  }

  Future<dynamic> _makeRequest(
    String path, 
    String method, 
    {dynamic body,
    Map<String, dynamic>? queryParams,}
    ) async {
    await simulateNetworkDelay();
    final uri = _buildUri(path, queryParams);
    final headers = await _getHeaders();

    final response = http.Request(method, uri)
      ..headers.addAll(headers)
      ..body = body ?? '';

    final streamedResponse = await response.send();
    final responseData = await http.Response.fromStream(streamedResponse);

    return _handleResponse(responseData);
  }

 dynamic _handleResponse(http.Response response) {
  if (response.statusCode >= 200 && response.statusCode < 300) {
    return response.body; // Retorna o corpo da resposta como String
  } else {
    throw Exception('Erro na requisição: ${response.statusCode}');
  }
}
}


