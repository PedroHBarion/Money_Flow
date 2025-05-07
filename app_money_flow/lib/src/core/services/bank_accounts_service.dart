import 'dart:convert';
import '../models/bank_account_model.dart';
import './http/http_client.dart';

class BankAccountsService {
  final HttpClient http;

  BankAccountsService(this.http);

  Future<List<BankAccountModel>> getAll() async {
    final response = await http.get('/bank-accounts');
    final List data = jsonDecode(response);
    return data.map((item) => BankAccountModel.fromJson(item)).toList();
  }

  Future<dynamic> create(BankAccountModel model) async {
    final response = await http.post('/bank-accounts',
        body: jsonEncode(model.createAccountToJson()));
    return jsonDecode(response);
  }

  Future<dynamic> update(BankAccountModel model) async {
    final response = await http.put('/bank-accounts/${model.id}',
        body: jsonEncode(model.updateAccountToJson()));
    return jsonDecode(response);
  }

  Future<void> remove(String bankAccountId) async {
    await http.delete('/bank-accounts/$bankAccountId');
  }
}
