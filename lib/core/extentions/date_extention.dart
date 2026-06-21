import 'package:intl/intl.dart';

extension DateExtention on DateTime {
  String format() {
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);
    final checkDate = DateTime(year, month, day);

    final difference = today.difference(checkDate).inDays;

    if (difference == 0) {
      // Today → show time
      return DateFormat('HH:mm').format(this);
    } else if (difference == 1) {
      // Yesterday
      return "Yesterday";
    } else if (difference < 7) {
      // Within this week
      return DateFormat('EEEE').format(this); // Monday, Tuesday
    } else {
      // Older
      return DateFormat('dd MMM yyyy').format(this);
    }
  }
}
