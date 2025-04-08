import 'dart:convert';
import './http/http_client.dart';
import '../models/transactions/create_transaction_model.dart';
import '../models/transactions/update_transaction_model.dart';
import '../models/transactions/transaction_by_category_model.dart';
import '../models/transactions/transaction_filters_model.dart';
import '../models/transactions/transaction.dart';

class TransactionService {
  final HttpClient httpClient;

  TransactionService(this.httpClient);

  Future<dynamic> create(CreateTransactionModel model) async {
    final response =
        await httpClient.post('/transactions', body: model.toJson());
    return jsonDecode(response);
  }

  Future<List<TransactionModel>> getAll(
      {required int month, required int year}) async {
    final response = await httpClient
        .get('/transactions', queryParams: {'month': month, 'year': year});
    final List data = jsonDecode(response);
    return data.map((item) => TransactionModel.fromJson(item)).toList();
  }

  Future<dynamic> remove(String transactionId) async {
    final response = await httpClient.delete('/transaction/$transactionId');
    return jsonDecode(response);
  }

  Future<dynamic> update(UpdateTransactionModel model) async {
    final response =
        await httpClient.put('/transactions/${model.id}', body: model.toJson());
    return jsonDecode(response);
  }

  Future<List<TransactionByCategoryModel>> getExpenseSummaryByCategory({
    required int month,
    required int year,
  }) async {
    final response = await httpClient.get(
      '/transactions/summary/by-category',
      queryParams: {
        'type': 'EXPENSE',
        'month': month,
        'year': year,
      },
    );

    final List<dynamic> decoded = jsonDecode(response);
    return decoded
        .map((item) => TransactionByCategoryModel.fromJson(item))
        .toList();
  }
}
