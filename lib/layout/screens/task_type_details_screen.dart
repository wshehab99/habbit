import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habbit/cubit/app_cubit.dart';
import 'package:habbit/cubit/app_states.dart';
import 'package:habbit/layout/widgets/bottom_sheet_widget.dart';
import 'package:habbit/layout/widgets/task_tail.dart';

import 'package:habbit/models/task_type_model.dart';

import '../widgets/task_details_app_bar.dart';

class TaskTypeDetailsScreen extends StatelessWidget {
  const TaskTypeDetailsScreen({
    super.key,
    this.taskTypeModel,
  });
  final TaskTypeModel? taskTypeModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AppCubit()..getTypedTasks(type: taskTypeModel!.name!),
      child: BlocBuilder<AppCubit, AppState>(builder: (context, state) {
        AppCubit cubit = context.read<AppCubit>();
        return Scaffold(
          body: cubit.taskType.length == 0
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : CustomScrollView(
                  slivers: [
                    SliverPersistentHeader(
                      delegate: TaskDetailsAppBar(
                        taskTypeModel:
                            cubit.taskType[taskTypeModel!.taskRank! - 1],
                        expandedHeight: 200,
                        actions: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25),
                                    ),
                                  ),
                                  context: context,
                                  builder: (context) {
                                    return BottomSheetWidget(
                                      add: true,
                                    );
                                  }).then((value) {
                                cubit.getTypedTasks(
                                  type: taskTypeModel!.name!,
                                );
                                cubit.getTodayTasks();
                                cubit.getStatusBasedTasks(status: "ongoing");
                                cubit.getDoneTasks();
                              });
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      pinned: true,
                    ),
                    SliverToBoxAdapter(
                      child: ListView.separated(
                        itemCount: cubit.shownTasks.length,
                        shrinkWrap: true,
                        primary: false,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return TaskTail(
                            taskModel: cubit.shownTasks[index],
                            onPressed: () {
                              showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25),
                                    ),
                                  ),
                                  context: context,
                                  builder: (context) {
                                    return BottomSheetWidget(
                                      taskModel: cubit.shownTasks[index],
                                    );
                                  }).then((value) {
                                cubit.getTypedTasks(
                                  type: taskTypeModel!.name!,
                                );
                              });
                            },
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
      }),
    );
  }
}
