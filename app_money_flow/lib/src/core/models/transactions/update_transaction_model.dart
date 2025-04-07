import './create_transaction_model.dart';

class UpdateTransactionModel extends CreateTransactionModel {
  final String id;

  UpdateTransactionModel({
    required this.id,
    required super.name,
    required super.bankAccountId,
    required super.categoryId,
    required super.value,
    required super.date,
    required super.type,
  });
}
