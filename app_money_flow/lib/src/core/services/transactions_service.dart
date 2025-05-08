import 'dart:convert';
import 'package:app_money_flow/src/core/models/transactions/transaction_filters_model.dart';
import './http/http_client.dart';
import '../models/transactions/transaction_by_category_model.dart';
import '../models/transactions/transaction_model.dart';

class TransactionService {
  final HttpClient httpClient;

  TransactionService(this.httpClient);

  Future<dynamic> create(TransactionModel model) async {
    final response = await httpClient.post('/transactions',
        body: jsonEncode(model.toJson()));
    return jsonDecode(response);
  }

  Future<List<TransactionModel>> getAll(TransactionFiltersModel filters) async {
    final response = await httpClient.get('/transactions',
        queryParams: filters.toQueryParams());
    final List data = jsonDecode(response);
    return data.map((item) => TransactionModel.fromJson(item)).toList();
  }

  Future<dynamic> remove(String transactionId) async {
    await httpClient.delete('/transactions/$transactionId');
    return;
  }

  Future<dynamic> update(TransactionModel model) async {
    final response = await httpClient.put('/transactions/${model.id}',
        body: jsonEncode(model.toJson()));
    return jsonDecode(response);
  }

  Future<List<TransactionByCategoryModel>> getExpenseSummaryByCategory({
    required int month,
    required int year,
  }) async {
    final response = await httpClient.get(
      '/transactions/summary/category',
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
