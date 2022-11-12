import 'package:flutter/material.dart';
import 'package:habbit/layout/widgets/bottom_sheet_widget.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../models/task_type_model.dart';

class TaskDetailsAppBar extends SliverPersistentHeaderDelegate {
  TaskDetailsAppBar({
    this.taskTypeModel,
    required this.expandedHeight,
    this.actions,
  });
  final double expandedHeight;
  final List<Widget>? actions;
  final TaskTypeModel? taskTypeModel;
  double percent = 0;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    if (taskTypeModel!.completedTasks != 0) {
      percent = taskTypeModel!.completedTasks! / taskTypeModel!.taskNo!;
    }
    return Stack(
      fit: StackFit.expand,
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Opacity(
          opacity: 1 - shrinkOffset / expandedHeight,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              gradient: LinearGradient(
                colors: [
                  taskTypeModel!.startColor!,
                  taskTypeModel!.endColor!,
                ],
              ),
            ),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top + 30,
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
            ),
          ),
        ),
        Opacity(
          opacity: shrinkOffset / expandedHeight,
          child: AppBar(
            backgroundColor: taskTypeModel!.startColor,
            title: Text(
              taskTypeModel!.name!,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            actions: actions,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(25))),
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
