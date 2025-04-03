import 'package:get_it/get_it.dart';
import '../services/http/http_client.dart';
import '../services/auth_service.dart';

final getIt = GetIt.instance; 

void setupLocator() {
  getIt.registerLazySingleton(() => HttpClient('http://localhost:3001'));
  getIt.registerLazySingleton(() => AuthService(getIt<HttpClient>())); 
}
