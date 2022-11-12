import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeDateModel {
  static String formatDate(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }

  static String formatTime(
    TimeOfDay timeOfDay, {
    bool isEnd = false,
  }) {
    return isEnd
        ? DateFormat.jm().format(dateTimeExtension(timeOfDay))
        : DateFormat.jm().format(
            dateTimeExtension(timeOfDay).add(
              Duration(hours: 1),
            ),
          );
  }

  static DateTime dateTimeExtension(TimeOfDay time) {
    return DateTime(
      2000,
      1,
      1,
      time.hour,
      time.minute,
    );
  }
}
