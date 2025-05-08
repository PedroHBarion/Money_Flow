// lib/models/bank_account_model.dart

class BankAccountModel {
  final String? id;
  final String name;
  final double initialBalance;
  final String type;
  final String color;
  final double? currentBalance;

  BankAccountModel({
    this.id,
    required this.name,
    required this.initialBalance,
    required this.type,
    required this.color,
    this.currentBalance,
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

  Map<String, dynamic> createAccountToJson() {
    return {
      'name': name,
      'initialBalance': initialBalance,
      'color': color,
      'type': type,
    };
  }

  Map<String, dynamic> updateAccountToJson() {
    return {
      'id': id,
      'name': name,
      'initialBalance': initialBalance,
      'color': color,
      'type': type,
      'currentBalance': currentBalance,
    };
  }
}
