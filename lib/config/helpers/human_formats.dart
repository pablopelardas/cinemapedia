import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double number, {int decimalDigits = 0}) {
    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: decimalDigits,
      symbol: '',
      locale: 'en',
    );
    return formatterNumber.format(number);
  }
}
