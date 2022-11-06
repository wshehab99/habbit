import 'package:flutter/material.dart';

class TaskSearchTextField extends StatelessWidget {
  const TaskSearchTextField({super.key, this.controller});
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.purple,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.deepPurple.shade100,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.deepPurple.shade100,
                width: 2,
              ),
            ),
            hintText: "Search Tasks Here",
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
            suffixIcon: Icon(Icons.search)),
      ),
    );
  }
}
