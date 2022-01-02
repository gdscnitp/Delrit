// convert timestamp ro human readable timestamp
import 'package:intl/intl.dart';

String timestampToHumanReadable(int timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return DateFormat('MMM dd, yyyy HH:mm').format(dateTime);
}
