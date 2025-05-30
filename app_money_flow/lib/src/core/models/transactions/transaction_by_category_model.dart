class TransactionByCategoryModel {
  final String id;
  final String name;
  final String color;
  final String icon;
  final double total;

  TransactionByCategoryModel({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
    required this.total,
  });

  factory TransactionByCategoryModel.fromJson(Map<String, dynamic> json) {
    return TransactionByCategoryModel(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      icon: json['icon'],
      total: (json['value'] as num).toDouble(),
    );
  }
}
