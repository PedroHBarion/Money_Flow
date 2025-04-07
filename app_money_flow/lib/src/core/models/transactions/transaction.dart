class TransactionModel {
  final String id;
  final String name;
  final double value;
  final String date;
  final String type; // Pode usar um enum depois, se quiser
  final Category? category;

  TransactionModel({
    required this.id,
    required this.name,
    required this.value,
    required this.date,
    required this.type,
    this.category,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      name: json['name'],
      value: (json['value'] as num).toDouble(),
      date: json['date'],
      type: json['type'],
      category: json['category'] != null ? Category.fromJson(json['category']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'date': date,
      'type': type,
      'category': category?.toJson(),
    };
  }
}

class Category {
  final String id;
  final String name;
  final String icon;

  Category({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
    };
  }
}
