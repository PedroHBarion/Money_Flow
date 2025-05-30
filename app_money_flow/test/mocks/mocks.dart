import 'package:app_money_flow/src/core/provider/auth_provider.dart';
import 'package:app_money_flow/src/core/services/auth_service.dart';
import 'package:app_money_flow/src/core/services/toast_service.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  AuthService,
  AuthProvider,
  ToastService,
  http.Client,
])
void main() {}
