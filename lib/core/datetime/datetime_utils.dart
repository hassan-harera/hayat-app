import 'package:intl/intl.dart';

String timeAgo(String? value) {
  if (value == null || value.isEmpty) {
    return "";
  }
  DateTime dateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(value);
  Duration diff = DateTime.now().difference(dateTime);

  if (diff.inSeconds < 60) {
    return "${diff.inSeconds} seconds ago";
  } else if (diff.inMinutes < 60) {
    return "${diff.inMinutes} minutes ago";
  } else if (diff.inHours < 24) {
    return "${diff.inHours} hours ago";
  } else if (diff.inDays < 30) {
    return "${diff.inDays} days ago";
  } else if (diff.inDays < 365) {
    int months = (diff.inDays / 30).floor();
    return "${months} ${months == 1 ? 'month' : 'months'} ago";
  } else {
    int years = (diff.inDays / 365).floor();
    return "${years} ${years == 1 ? 'year' : 'years'} ago";
  }
}
