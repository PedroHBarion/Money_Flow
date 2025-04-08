import 'package:get_it/get_it.dart';
import '../services/http/http_client.dart';
import '../services/auth_service.dart';
import '../services/bank_accounts_service.dart';
import '../services/transactions_service.dart';
import '../../pages/home/widgets/accounts/accounts_controller.dart';
import '../../pages/home/widgets/transactions/transactions_controller.dart';
import '../../pages/login/login_page_controller.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => HttpClient('http://localhost:3001'));
  getIt.registerLazySingleton(() => AuthService(getIt<HttpClient>()));
  getIt.registerLazySingleton(() => BankAccountsService(getIt<HttpClient>()));
  getIt.registerLazySingleton(() => TransactionService(getIt<HttpClient>()));
  getIt.registerFactory(
      () => AccountsController(service: getIt<BankAccountsService>()));
  getIt.registerFactory<LoginController>(() => LoginController());
  getIt.registerFactory(
      () => TransactionsController(service: getIt<TransactionService>()));
}
