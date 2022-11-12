import 'package:flutter/material.dart';

class DropDownTaskType extends StatelessWidget {
  const DropDownTaskType({
    super.key,
    this.dropValue,
    this.validator,
    required this.items,
    this.onChanged,
  });
  final String? dropValue;
  final List<String>? items;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      validator: validator,
      value: dropValue,
      decoration: InputDecoration(
        hintText: "Task Type",
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
      items: items!.map<DropdownMenuItem<String>>((element) {
        return DropdownMenuItem(
          child: Text(element),
          value: element,
        );
      }).toList(),
      onChanged: onChanged,
      borderRadius: BorderRadius.circular(15),
    );
  }
}
