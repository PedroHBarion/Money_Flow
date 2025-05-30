import 'dart:convert';
import 'package:app_money_flow/src/core/enums/transaction_type.dart';
import 'package:app_money_flow/src/core/models/category_model.dart';
import './http/http_client.dart';

class CategoriesService {
  final HttpClient http;

  CategoriesService(this.http);

  Future<List<CategoryModel>> getAll({required TransactionType type}) async {
    final response = await http.get('/categories',queryParams: {'type':type.value});
    final List data = jsonDecode(response);
    return data.map((item) => CategoryModel.fromJson(item)).toList();
  }
}

 