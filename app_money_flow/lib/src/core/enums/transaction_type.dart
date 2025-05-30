enum TransactionType {
  income,
  expense;

  String get label {
    switch (this) {
      case TransactionType.income:
        return 'Receita';
      case TransactionType.expense:
        return 'Despesa';
    }
  }

  String get value {
    return toString().split('.').last.toUpperCase();
  }

  static TransactionType fromString(String value) {
    switch (value.toUpperCase()) {
      case 'INCOME':
        return TransactionType.income;
      case 'EXPENSE':
        return TransactionType.expense;
      default:
        throw Exception('Tipo de conta inválido: $value');
    }
  }
}
