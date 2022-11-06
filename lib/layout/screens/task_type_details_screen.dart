import 'package:flutter/material.dart';
import 'package:habbit/layout/widgets/task_tail.dart';
import 'package:habbit/models/task_model.dart';
import 'package:habbit/models/task_type_model.dart';

import '../widgets/task_details_app_bar.dart';

class TaskTypeDetailsScreen extends StatelessWidget {
  TaskTypeDetailsScreen({super.key, this.taskTypeModel});
  final TaskTypeModel? taskTypeModel;
  final List<TaskModel> tasks = TaskModel.getSchoolTasks();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: PreferredSize(
        child: TaskDetailsAppBar(
          taskTypeModel: taskTypeModel,
        ),
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          200,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListView.separated(
                itemCount: tasks.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return TaskTail(
                    taskModel: tasks[index],
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
