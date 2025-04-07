class CreateTransactionModel {
  final String name;
  final String bankAccountId;
  final String categoryId;
  final double value;
  final String date;
  final String type; 

  CreateTransactionModel({
    required this.name,
    required this.bankAccountId,
    required this.categoryId,
    required this.value,
    required this.date,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'bankAccountId': bankAccountId,
    'categoryId': categoryId,
    'value': value,
    'date': date,
    'type': type,
  };
}

