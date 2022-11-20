import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habbit/cubit/app_cubit.dart';
import 'package:habbit/cubit/app_states.dart';
import 'package:habbit/layout/widgets/date_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class HobbitTimeLineWidget extends StatelessWidget {
  HobbitTimeLineWidget({
    super.key,
    required this.initialDate,
  });
  final DateTime initialDate;
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ItemScrollController itemScrollController = ItemScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(builder: (context, state) {
      AppCubit cubit = context.read<AppCubit>();

      return SizedBox(
        height: 120,
        child: ScrollablePositionedList.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemPositionsListener: itemPositionsListener,
          itemScrollController: itemScrollController,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                cubit.changeSelectedDate(index);
                itemScrollController.scrollTo(
                  alignment: 0.03,
                  index: cubit.selectedDateIndex,
                  duration: const Duration(milliseconds: 600),
                );
                cubit.getDatedTasks(date: cubit.days[index]);
              },
              child: DateDayWidget(
                date: cubit.days[index],
                isSelected: index == cubit.selectedDateIndex,
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
            width: 10,
          ),
          itemCount: cubit.days.length,
          scrollDirection: Axis.horizontal,
        ),
      );
    });
  }
}
