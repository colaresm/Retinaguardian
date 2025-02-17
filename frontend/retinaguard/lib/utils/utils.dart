import 'package:intl/intl.dart';

String extractDate(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  return DateFormat("dd/MM/yyyy").format(dateTime);
}

String convertDateToISO(String dateString) {
  DateTime dateTime = DateFormat("dd/MM/yyyy").parse(dateString);
  return DateFormat("yyyy-MM-dd").format(dateTime);
}
