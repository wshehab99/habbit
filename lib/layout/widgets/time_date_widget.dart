import 'package:flutter/material.dart';

class TimeDateWidget extends StatelessWidget {
  const TimeDateWidget({
    super.key,
    this.text,
    this.icon,
    required this.onPressed,
  });
  final String? text;
  final Widget? icon;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(colors: [
              Colors.deepPurple.shade200,
              Colors.indigo.shade300,
            ]),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              icon!,
              Text(
                text!,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const Icon(
                Icons.close,
                size: 10,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
