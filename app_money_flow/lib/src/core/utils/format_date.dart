import 'package:intl/intl.dart';

String formatDate(dynamic originalDate) {
  late DateTime dateTime;

  if (originalDate is String) {
    dateTime = DateTime.parse(originalDate);
  } else if (originalDate is DateTime) {
    dateTime = originalDate;
  } else {
    throw ArgumentError('The parameter must be a String or DateTime');
  }

  final formatter = DateFormat('dd/MM/yyyy');
  return formatter.format(dateTime);
}
