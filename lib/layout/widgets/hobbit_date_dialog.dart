import 'package:flutter/material.dart';

class HobbitDateDialog {
  static Future<DateTime?> showDateDialog({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
  }) async {
    return await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
              dialogTheme: DialogTheme(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35)))),
          child: child!,
        );
      },
    );
  }
}
