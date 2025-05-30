enum BankAccountType {
  checking,
  investment,
  cash;

  String get label {
    switch (this) {
      case BankAccountType.checking:
        return 'Conta Corrente';
      case BankAccountType.investment:
        return 'Investimentos';
      case BankAccountType.cash:
        return 'Dinheiro Físico';
    }
  }

  String get value {
    return toString().split('.').last.toUpperCase();
  }

  static BankAccountType fromString(String value) {
    switch (value.toUpperCase()) {
      case 'CHECKING':
        return BankAccountType.checking;
      case 'INVESTMENT':
        return BankAccountType.investment;
      case 'CASH':
        return BankAccountType.cash;
      default:
        throw Exception('Tipo de conta inválido: $value');
    }
  }
}
