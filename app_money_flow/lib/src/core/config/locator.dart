import 'package:app_money_flow/src/core/services/ai_service.dart';
import 'package:app_money_flow/src/core/services/categories_service.dart';
import 'package:app_money_flow/src/core/services/message_service.dart';
import 'package:app_money_flow/src/core/services/questions_service.dart';
import 'package:app_money_flow/src/core/services/user_answers_service.dart';
import 'package:app_money_flow/src/pages/expenses/expense_controller.dart';
import 'package:app_money_flow/src/widgets/modals/TransactionModal/transaction_modal_controller.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
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

// ✅ Carrega corretamente as variáveis de ambiente do .env
final apiUrl = dotenv.env['API_URL']!;
final apiKeyIa = dotenv.env['IA_API_KEY']!;

void setupLocator() {
  getIt.registerLazySingleton(() => HttpClient(apiUrl));
  getIt.registerLazySingleton(() => AuthService(getIt<HttpClient>()));
  getIt.registerLazySingleton<AiService>(
    () => AiService(apiKey: apiKeyIa),
  );

  // Services
  getIt.registerLazySingleton(() => BankAccountsService(getIt<HttpClient>()));
  getIt.registerLazySingleton(() => TransactionService(getIt<HttpClient>()));
  getIt.registerLazySingleton(() => CategoriesService(getIt<HttpClient>()));
  getIt.registerLazySingleton(() => QuestionsService(getIt<HttpClient>()));
  getIt.registerLazySingleton(() => UserAnswersService(getIt<HttpClient>()));
  getIt.registerLazySingleton(() => MessageService());

  // Controllers
  getIt.registerLazySingleton(
      () => AccountsController(service: getIt<BankAccountsService>()));
  getIt.registerFactory<LoginController>(() => LoginController());
  getIt.registerLazySingleton(
      () => TransactionsController(service: getIt<TransactionService>()));
  getIt.registerFactory(
      () => AccountModalController(getIt<BankAccountsService>()));

  getIt.registerFactory(() => TransactionModalController(
        getIt<TransactionService>(),
        getIt<BankAccountsService>(),
        getIt<CategoriesService>(),
      ));

  getIt.registerLazySingleton(() => ExpensesController(
        getIt<TransactionService>(),
        getIt<BankAccountsService>(),
        getIt<MessageService>(),
      ));
}
