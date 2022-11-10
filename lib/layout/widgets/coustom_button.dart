import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
  });
  final Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(colors: [
              Colors.deepOrange.shade400,
              Colors.pink.shade400,
            ])),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(text),
          style: ButtonStyle(
              maximumSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width, 40),
              ),
              minimumSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width, 40),
              ),
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)))),
        ),
      ),
    );
  }
}
