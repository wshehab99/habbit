import 'dart:math';

import 'package:flutter/material.dart';

import 'package:habbit/models/task_model.dart';

class TaskTail extends StatelessWidget {
  TaskTail({super.key, this.taskModel, this.onPressed});
  final void Function()? onPressed;
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
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black12,
          width: 0.2,
          strokeAlign: 0.5,
        ),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: InkWell(
        onTap: onPressed,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            taskModel!.name!,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Icon(
                Icons.access_time_filled_rounded,
                size: 20,
                color: Colors.indigo.shade300,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "${taskModel!.startTime!}, ${taskModel!.date!}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                    color: colors[colorIndex1],
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  taskModel!.type!,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                    color: colors[colorIndex2],
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  taskModel!.status!,
                  style: const TextStyle(fontSize: 14),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
