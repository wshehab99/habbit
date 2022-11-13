import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habbit/cubit/app_cubit.dart';
import 'package:habbit/cubit/app_states.dart';
import 'package:habbit/layout/widgets/hobbit_timeline_widget.dart';
import 'package:habbit/layout/widgets/task_tail.dart';
import 'package:habbit/models/time_date_model.dart';
import 'package:lottie/lottie.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(builder: (context, state) {
      AppCubit cubit = context.read<AppCubit>();

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            HobbitTimeLineWidget(
              initialDate: DateTime.now(),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: cubit.datedTasks.isEmpty
                  ? LottieBuilder.asset("assets/img/empty.json")
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        return TaskTail(
                          onPressed: () {},
                          taskModel: cubit.datedTasks[index],
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 15),
                      itemCount: cubit.datedTasks.length,
                    ),
            )
          ],
        ),
      );
    });
  }
}
