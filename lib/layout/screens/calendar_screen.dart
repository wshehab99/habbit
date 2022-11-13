import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habbit/cubit/app_cubit.dart';
import 'package:habbit/cubit/app_states.dart';
import 'package:habbit/layout/widgets/bottom_sheet_widget.dart';
import 'package:habbit/layout/widgets/hobbit_timeline_widget.dart';
import 'package:habbit/layout/widgets/task_tail.dart';
import 'package:lottie/lottie.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(builder: (context, state) {
      AppCubit cubit = context.read<AppCubit>();

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              HobbitTimeLineWidget(
                initialDate: DateTime.now(),
              ),
              const SizedBox(
                height: 10,
              ),
              cubit.datedTasks.isEmpty
                  ? LottieBuilder.asset("assets/img/empty.json")
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return TaskTail(
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
                                    taskModel: cubit.datedTasks[index],
                                  );
                                }).then((value) {
                              cubit.getDatedTasks(
                                date: cubit.days[cubit.selectedDateIndex],
                              );
                            });
                          },
                          taskModel: cubit.datedTasks[index],
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 15),
                      itemCount: cubit.datedTasks.length,
                    )
            ],
          ),
        ),
      );
    });
  }
}
