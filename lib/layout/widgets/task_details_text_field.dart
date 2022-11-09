import 'package:flutter/material.dart';

class TaskDetailsTextField extends StatelessWidget {
  const TaskDetailsTextField({
    super.key,
    this.maxLines = 1,
    this.hint,
    this.controller,
    this.validator,
  });
  final int maxLines;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
        controller: controller,
        validator: validator,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.purple,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.deepPurple.shade100,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.deepPurple.shade100,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
