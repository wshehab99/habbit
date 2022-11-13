import 'package:flutter/material.dart';
import 'package:habbit/layout/screens/search_screen.dart';

class TaskSearchTextField extends StatelessWidget {
  const TaskSearchTextField({
    super.key,
    this.controller,
    this.isSearch = false,
    this.searchMethod,
  });
  final TextEditingController? controller;
  final bool isSearch;
  final Function(String)? searchMethod;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isSearch ? 60 : 40,
      child: TextField(
        onChanged: searchMethod,
        readOnly: !isSearch,
        autofocus: isSearch,
        onTap: () {
          if (!isSearch) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchScreen(),
              ),
            );
          }
        },
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
