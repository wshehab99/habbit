import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habbit/models/task_model.dart';

class TaskTail extends StatelessWidget {
  TaskTail({
    super.key,
    this.taskModel,
  });
  final TaskModel? taskModel;
  final List colors = [
    Colors.red[100],
    Colors.blue[100],
    Colors.indigo[100],
    Colors.deepOrange[100],
    Colors.deepPurple[100],
    Colors.amber[100],
    Colors.green[100],
    Colors.teal[100]
  ];
  @override
  Widget build(BuildContext context) {
    int colorIndex1 = Random().nextInt(colors.length);
    int colorIndex2 = Random().nextInt(colors.length);
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          taskModel!.name!,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Icon(
              Icons.access_time_filled_rounded,
              size: 20,
              color: Colors.indigo.shade300,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "${taskModel!.startTime!}, ${taskModel!.date!}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                  color: colors[colorIndex1],
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                taskModel!.type.toString().split(".")[1],
                style: TextStyle(fontSize: 12),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                  color: colors[colorIndex2],
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                taskModel!.status.toString().split(".")[1],
                style: TextStyle(fontSize: 12),
              ),
            )
          ],
        )
      ]),
    );
  }
}
