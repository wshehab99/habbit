import 'package:flutter/material.dart';

class TaskDetailsTextField extends StatelessWidget {
  const TaskDetailsTextField({
    super.key,
    this.maxLines = 1,
    this.hint,
    this.validator,
    this.onChanged,
    this.value,
  });
  final int maxLines;
  final String? hint;

  final String? Function(String?)? validator;
  final String? value;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      validator: validator,
      onChanged: onChanged,
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
    );
  }
}
