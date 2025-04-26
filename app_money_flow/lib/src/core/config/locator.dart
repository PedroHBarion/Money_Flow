import 'package:app_money_flow/src/core/services/categories_service.dart';
import 'package:app_money_flow/src/core/services/message_service.dart';
import 'package:app_money_flow/src/core/services/questions_service.dart';
import 'package:app_money_flow/src/core/services/user_answers_service.dart';
import 'package:app_money_flow/src/widgets/modals/TransactionModal/transaction_modal_controller.dart';
import 'package:get_it/get_it.dart';
import '../services/http/http_client.dart';
import '../services/auth_service.dart';
import '../services/bank_accounts_service.dart';
import '../services/transactions_service.dart';
import '../../pages/home/widgets/accounts/accounts_controller.dart';
import '../../pages/home/widgets/transactions/transactions_controller.dart';
import '../../pages/login/login_page_controller.dart';
import '../../widgets/modals/AccountModal/account_modal_controller.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => HttpClient('http://localhost:3001'));
  getIt.registerLazySingleton(() => AuthService(getIt<HttpClient>()));
  // Registrando os services de chamda da API
  getIt.registerLazySingleton(() => BankAccountsService(getIt<HttpClient>()));
  getIt.registerLazySingleton(() => TransactionService(getIt<HttpClient>()));
  getIt.registerLazySingleton(() => CategoriesService(getIt<HttpClient>()));
  getIt.registerLazySingleton(() => QuestionsService(getIt<HttpClient>()));
  getIt.registerLazySingleton(() => UserAnswersService(getIt<HttpClient>()));
  getIt.registerLazySingleton(() => MessageService());
  // Registrando os controllers
  getIt.registerLazySingleton(
      () => AccountsController(service: getIt<BankAccountsService>()));
  getIt.registerFactory<LoginController>(() => LoginController());
  getIt.registerLazySingleton(
      () => TransactionsController(service: getIt<TransactionService>()));
  getIt.registerFactory(
      () => AccountModalController(getIt<BankAccountsService>()));
  GetIt.I.registerFactory(() => TransactionModalController(
        GetIt.I<TransactionService>(),
        GetIt.I<BankAccountsService>(),
        GetIt.I<CategoriesService>(),
      ));
}
