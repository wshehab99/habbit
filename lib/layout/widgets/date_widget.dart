import 'package:flutter/material.dart';
import 'package:habbit/models/time_date_model.dart';

class DateDayWidget extends StatelessWidget {
  const DateDayWidget({
    super.key,
    required this.date,
    required this.isSelected,
  });
  final DateTime date;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      width: 65,
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        gradient: LinearGradient(
          colors: [
            isSelected ? Colors.amber.shade400 : Colors.white54,
            isSelected ? Colors.deepOrange.shade400 : Colors.white60,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${TimeDateModel.getMonth(date)}",
            style: TextStyle(
              fontSize: 16,
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "${date.day}",
            style: TextStyle(
              fontSize: 26,
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "${TimeDateModel.getWeekday(date)}",
            style: TextStyle(
              fontSize: 16,
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
