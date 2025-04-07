class TransactionByCategoryModel {
  final String categoryId;
  final String categoryName;
  final String categoryColor;
  final double total;

  TransactionByCategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryColor,
    required this.total,
  });

  factory TransactionByCategoryModel.fromJson(Map<String, dynamic> json) {
    return TransactionByCategoryModel(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      categoryColor: json['categoryColor'],
      total: (json['total'] as num).toDouble(),
    );
  }
}
