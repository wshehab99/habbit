import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HobbitDeleteDialog {
  static showHobbitDialog({
    required BuildContext context,
    required void Function()? deleteMethod,
    required void Function()? cancelMethod,
  }) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              title: Text("Delete this task!"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LottieBuilder.asset(
                    "assets/img/garbage.json",
                    height: 150,
                  ),
                  Text(
                    "Are you sure you want to delete?",
                  )
                ],
              ),
              actions: [
                TextButton(onPressed: cancelMethod, child: Text("Cancel")),
                TextButton(onPressed: deleteMethod, child: Text("Delete")),
              ],
            ));
  }
}
