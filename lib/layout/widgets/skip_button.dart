import 'package:flutter/material.dart';
import 'package:habbit/layout/screens/home_screen.dart';

class Skipbutton extends StatelessWidget {
  const Skipbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 144, 149, 232),
            Color.fromARGB(255, 182, 147, 216),
          ],
        ),
      ),
      child: IconButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        },
        icon: Text(
          "Skip",
        ),
      ),
    );
  }
}
