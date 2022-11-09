import 'package:flutter/material.dart';

class TimeDateWidget extends StatelessWidget {
  const TimeDateWidget({
    super.key,
    this.text,
    this.icon,
  });
  final String? text;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(colors: [
            Colors.indigo.shade300,
            Colors.deepPurple.shade300,
          ]),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            icon!,
            Text(
              text!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
            Icon(
              Icons.close,
              size: 10,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
