import 'package:app_money_flow/src/core/services/questions_service.dart';
import 'package:app_money_flow/src/core/services/transactions_service.dart';
import 'package:app_money_flow/src/core/services/user_answers_service.dart';
import 'package:app_money_flow/src/core/services/bank_accounts_service.dart';
import 'package:app_money_flow/src/core/services/message_service.dart';
import 'package:app_money_flow/src/core/services/auth_service.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  UserAnswersService,
  QuestionsService,
  http.Client,
  TransactionService,
  BankAccountsService,
  MessageService,
  AuthService
])
void main() {}
