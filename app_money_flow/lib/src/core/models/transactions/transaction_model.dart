import '../category_model.dart';
import '../../enums/transaction_type.dart'; 

class TransactionModel {
  final String? id;
  final String name;
  final double value;
  final String date;
  final TransactionType type; // ← alterado aqui
  final String? categoryId;
  final String? bankAccountId;
  final CategoryModel? category;

  TransactionModel({
    this.id,
    required this.name,
    required this.value,
    required this.date,
    required this.type,
    this.categoryId,
    this.bankAccountId,
    this.category,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      name: json['name'],
      value: (json['value'] as num).toDouble(),
      date: json['date'],
      type: TransactionType.fromString(json['type']), // ← convertendo string pra enum
      categoryId: json['categoryId'],
      bankAccountId: json['bankAccountId'],
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'date': date,
      'type': type.value, // ← convertendo enum pra string
      'categoryId': categoryId,
      'bankAccountId': bankAccountId,
    };
  }
}
