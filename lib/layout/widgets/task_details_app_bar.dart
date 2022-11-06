import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../models/task_type_model.dart';

class TaskDetailsAppBar extends StatelessWidget {
  TaskDetailsAppBar({
    super.key,
    this.taskTypeModel,
  });

  final TaskTypeModel? taskTypeModel;
  double percent = 0;
  @override
  Widget build(BuildContext context) {
    if (taskTypeModel!.completedTasks != 0) {
      percent = taskTypeModel!.completedTasks! / taskTypeModel!.taskNo!;
    }
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          gradient: LinearGradient(colors: [
            taskTypeModel!.startColor!,
            taskTypeModel!.endColor!,
          ])),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                taskTypeModel!.name!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const Text(
                    "Your Tasks",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Completed Tasks ${taskTypeModel!.completedTasks!} / ${taskTypeModel!.taskNo}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              CircularPercentIndicator(
                radius: 50,
                lineWidth: 12,
                percent: percent,
                animation: true,
                animationDuration: 1500,
                center: Text(
                  "${(percent * 100).round()} %",
                  style: TextStyle(
                    color: Colors.indigo[900],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                progressColor: Colors.indigo[900],
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
