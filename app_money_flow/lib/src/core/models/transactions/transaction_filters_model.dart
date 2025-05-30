class TransactionFiltersModel {
  final int month;
  final int year;
  final String? bankAccountId;
  final String? type;

  TransactionFiltersModel({
    required this.month,
    required this.year,
    this.bankAccountId,
    this.type,
  });

  Map<String, dynamic> toQueryParams() {
    return {
      'month': month,
      'year': year,
      if (bankAccountId != null) 'bankAccountId': bankAccountId,
      if (type != null) 'type': type,
    };
  }
}
