import 'package:flutter/material.dart';

class DropDownTaskType extends StatelessWidget {
  DropDownTaskType({
    super.key,
    this.dropValue,
    this.validator,
    required this.items,
  });
  String? dropValue;
  final List<String>? items;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButtonFormField(
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

        //  [
        //   DropdownMenuItem<String>(
        //     value: "school",
        //     child: Text("School"),
        //   ),
        //   DropdownMenuItem<String>(
        //     value: "Work",
        //     child: Text("Work"),
        //   ),
        //   DropdownMenuItem<String>(
        //     value: "Health",
        //     child: Text("Health"),
        //   ),
        //   DropdownMenuItem<String>(
        //     value: "Other",
        //     child: Text("Other"),
        //   ),
        // ],
        onChanged: (value) {
          dropValue = value;
        },
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
