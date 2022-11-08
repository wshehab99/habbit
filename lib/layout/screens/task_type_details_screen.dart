import 'package:flutter/material.dart';
import 'package:habbit/layout/widgets/task_tail.dart';
import 'package:habbit/models/task_model.dart';
import 'package:habbit/models/task_type_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../widgets/task_details_app_bar.dart';

class TaskTypeDetailsScreen extends StatelessWidget {
  TaskTypeDetailsScreen({super.key, this.taskTypeModel});
  final TaskTypeModel? taskTypeModel;
  final List<TaskModel> tasks = TaskModel.getSchoolTasks();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: TaskDetailsAppBar(
              taskTypeModel: taskTypeModel,
              expandedHeight: 200,
            ),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: ListView.separated(
              itemCount: tasks.length,
              shrinkWrap: true,
              primary: false,
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
          ),
        ],
      ),
    );
  }
}
