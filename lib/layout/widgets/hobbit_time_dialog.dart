import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/material.dart';

class HobbitTimeDialog {
  static showTimeDialog({
    required BuildContext context,
    required TimeOfDay value,
    required void Function(TimeOfDay) onChange,
  }) {
    Navigator.of(context).push(
      showPicker(
        borderRadius: 35,
        context: context,
        value: value,
        onChange: onChange,
        accentColor: Colors.deepPurple[300],
        unselectedColor: Colors.deepPurple[200],
        cancelStyle:
            TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.w600),
        okStyle:
            TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.w600),
        blurredBackground: true,
      ),
    );
  }
}
