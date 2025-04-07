// lib/models/bank_account_model.dart

class BankAccountModel {
  final String id;
  final String name;
  final double initialBalance;
  final String type;
  final String color;
  final double currentBalance;

  BankAccountModel({
    required this.id,
    required this.name,
    required this.initialBalance,
    required this.type,
    required this.color,
    required this.currentBalance,
  });

  factory BankAccountModel.fromJson(Map<String, dynamic> json) {
    return BankAccountModel(
      id: json['id'],
      name: json['name'],
      initialBalance: json['initialBalance'].toDouble(),
      type: json['type'],
      color: json['color'],
      currentBalance: json['currentBalance'].toDouble(),
    );
  }
}
