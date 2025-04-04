class Transaction {
  final String name;
  final double value;
  final String category;
  final DateTime date;

  Transaction({
    required this.name,
    required this.value,
    required this.category,
    required this.date,
  });

  // Factory method para criar uma instância de Transaction a partir de um mapa (JSON)
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      name: json['name'],
      value: (json['value'] is int) ? json['value'].toDouble() : json['value'],
      category: json['category'],
      date: DateTime.parse(json['date']),
    );
  }
}
