import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:habbit/cubit/app_cubit.dart';
import 'package:habbit/cubit/app_states.dart';
import 'package:habbit/layout/widgets/bottom_sheet_widget.dart';
import 'package:habbit/layout/widgets/task_tail.dart';

import '../widgets/task_type_card.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        AppCubit cubit = context.read<AppCubit>();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "My Tasks",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "See all",
                        style: TextStyle(
                          color: Colors.pink[200],
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                StaggeredGrid.count(
                  crossAxisCount: 6,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: cubit.taskType.map((element) {
                    return StaggeredGridTile.count(
                      crossAxisCellCount: element.crossAxisCellCount!,
                      mainAxisCellCount: element.mainAxisCellCount!,
                      child: TaskTypeCardWidget(
                        taskTypeModel: element,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 15,
                ),
                if (cubit.statusBasedTasks.isNotEmpty)
                  const Text(
                    "On Going",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                const SizedBox(
                  height: 15,
                ),
                ListView.separated(
                  itemCount: cubit.statusBasedTasks.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return TaskTail(
                      taskModel: cubit.statusBasedTasks[index],
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
                                taskModel: cubit.statusBasedTasks[index],
                              );
                            }).then((value) {
                          cubit.getStatusBasedTasks(status: "ongoing");
                          cubit.getDoneTasks();
                        });
                      },
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                ),
                if (cubit.doneTasks.isNotEmpty)
                  const Text(
                    "Done",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                const SizedBox(
                  height: 15,
                ),
                ListView.separated(
                  itemCount: cubit.doneTasks.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return TaskTail(
                      taskModel: cubit.doneTasks[index],
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
                                taskModel: cubit.doneTasks[index],
                              );
                            }).then((value) {
                          cubit.getDoneTasks();
                          cubit.getStatusBasedTasks(status: "ongoing");
                          cubit.getDatedTasks(date: DateTime.now());
                          cubit.getTodayTasks();
                        });
                      },
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
