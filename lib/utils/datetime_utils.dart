import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formattedDate(DateTime dateTime) =>
      DateFormat('MMM d yyyy').format(dateTime);

  static String formattedDateFromEpoch(int dateTime) =>
      formattedDate(DateTime.fromMillisecondsSinceEpoch(dateTime * 1000));
}
