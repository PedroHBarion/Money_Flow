class CreateBankAccountsModel {
  final String name;
  final double initialBalance;
  final String color;
  final String type; 

  CreateBankAccountsModel({
    required this.name,
    required this.initialBalance,
    required this.color,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'initialBalance': initialBalance,
      'color': color,
      'type': type,
    };
  }
}

