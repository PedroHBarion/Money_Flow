String getCategoryIconPath({
  required String type,       
  String? subcategory,        
}) {
  const incomePath = 'assets/icons/categories/income';
  const expensePath = 'assets/icons/categories/expense';

  print(subcategory);

  switch (type) {
    case 'INCOME':
      return '$incomePath/income.svg';

    case 'EXPENSE':
      final knownSubcategories = [
        'food',
        'fun',
        'grocery',
        'home',
        'education',
        'clothes',
        'transport',
        'travel',
      ];

      if (subcategory != null && knownSubcategories.contains(subcategory)) {
        return '$expensePath/$subcategory.svg';
      } else {
        return '$expensePath/default.svg';
      }

    default:
      throw Exception('Tipo de categoria inválido: $type');
  }
}



