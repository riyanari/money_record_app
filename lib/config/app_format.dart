import 'package:intl/intl.dart';

class AppFormat {
  static String date(String stringDate) {
    //2022-02-25
    DateTime dateTime = DateTime.parse(stringDate);
    return DateFormat('dd MMM yyyy', 'id_ID').format(dateTime); //25 Feb 2022
  }

  static String currency(String number) {
    return NumberFormat.currency(
      decimalDigits: 2,
      locale: 'id_ID',
      symbol: 'Rp ',
    ).format(double.parse(number));
  }
}
