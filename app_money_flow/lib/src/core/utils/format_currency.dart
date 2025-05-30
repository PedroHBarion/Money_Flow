import 'package:intl/intl.dart';

String formatCurrency(dynamic value) {
  late double number;

  if (value is String) {
    number = double.tryParse(value.replaceAll(',', '.')) ?? 0.0;
  } else if (value is num) {
    number = value.toDouble();
  } else {
    throw ArgumentError('The value must be a String or a number');
  }

  final formatter = NumberFormat.decimalPattern('pt_BR');
  return formatter.format(number);
}
