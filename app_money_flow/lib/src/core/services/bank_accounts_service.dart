import 'dart:convert';
import '../../core/models/bank_accounts/create_bank_accounts_model.dart';
import '../../core/models/bank_accounts/update_bank_accounts_model.dart';
import '../../core/models/bank_accounts/bank_account_model.dart';
import './http/http_client.dart';

class BankAccountsService {
  final HttpClient http;

  BankAccountsService(this.http);

  Future<List<BankAccountModel>> getAll() async {
    final response = await http.get('/bank-accounts');
    final List data = jsonDecode(response);
    return data.map((item) => BankAccountModel.fromJson(item)).toList();
  }

  Future<dynamic> create(CreateBankAccountsModel model) async {
    final response = await http.post('/bank-accounts', body: model.toJson());
     return jsonDecode(response);
  }

  Future<dynamic> update(UpdateBankAccountsModel model) async {
    final response = await http.put('/bank-accounts/${model.id}', body: model.toJson());
     return jsonDecode(response);
  }

  Future<void> remove(String bankAccountId) async {
    await http.delete('/bank-accounts/$bankAccountId');
  }
}
