import './create_bank_accounts_model.dart';

class UpdateBankAccountsModel extends CreateBankAccountsModel {
  final String id;

  UpdateBankAccountsModel({
    required this.id,
    required super.name,
    required super.initialBalance,
    required super.color,
    required super.type,
  });
}
