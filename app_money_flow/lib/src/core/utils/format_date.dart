import 'package:intl/intl.dart';

String formatDate(String dataOriginal) {
  final dateTime = DateTime.parse(dataOriginal);
  final formatador = DateFormat('dd/MM/yyyy');
  return formatador.format(dateTime);
}
