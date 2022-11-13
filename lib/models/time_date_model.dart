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
        ? DateFormat.jm().format(
            dateTimeExtension(timeOfDay).add(
              Duration(hours: 1),
            ),
          )
        : DateFormat.jm().format(dateTimeExtension(timeOfDay));
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

  static String getWeekday(DateTime date) {
    return DateFormat.E().format(date);
  }

  static List<DateTime> getDateBetween(
      {required DateTime startDate, required DateTime endDate}) {
    List<DateTime> days = [];
    for (int i = 0; i < endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  static String getMonth(DateTime date) {
    return DateFormat.MMM().format(date);
  }

  static DateTime getDateFromString(String date) {
    print(DateFormat("yMMMd").parse(date));
    return DateFormat("yMMMd").parse(date);
  }

  static TimeOfDay getTimeFromString(String time) {
    return TimeOfDay.fromDateTime(DateFormat("jm").parse(time));
  }

  static String subtractTimes(
      {required String startTime, required String endTime}) {
    return dateTimeExtension(getTimeFromString(endTime))
        .difference(dateTimeExtension(getTimeFromString(startTime)))
        .inMinutes
        .toString();
  }
}
