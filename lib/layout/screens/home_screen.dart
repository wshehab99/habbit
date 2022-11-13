import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habbit/cubit/app_cubit.dart';
import 'package:habbit/cubit/app_states.dart';
import 'package:habbit/layout/screens/bag_screen.dart';
import 'package:habbit/layout/screens/calendar_screen.dart';
import 'package:habbit/layout/screens/dashboard_screen.dart';
import 'package:habbit/layout/screens/profile_screen.dart';
import 'package:habbit/layout/widgets/custom_docked_button.dart';
import 'package:habbit/layout/widgets/hobbit_navigation_bar.dart';
import 'package:habbit/layout/widgets/task_search_text_field.dart';
import 'package:habbit/models/time_date_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> screens = [
    DashBoardScreen(),
    BagScreen(),
    CalendarScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getStatusBasedTasks(status: "ongoing")
        ..getDatedTasks(date: DateTime.now()),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          AppCubit cubit = context.read<AppCubit>();
          return Scaffold(
            key: scaffoldKey,
            bottomNavigationBar: HobbitNavigationBar(
              currentIndex: cubit.currentIndex,
              changeScreen: (value) {
                cubit.changeCurrentScreen(value);
              },
            ),
            appBar: AppBar(
              toolbarHeight: cubit.currentIndex == 0 ? 55 : 80,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        TimeDateModel.formatDate(DateTime.now()),
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: cubit.currentIndex == 0 ? 18 : 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (cubit.currentIndex == 0)
                        const SizedBox(
                          width: 20,
                        ),
                      if (cubit.currentIndex == 0)
                        const Expanded(child: TaskSearchTextField()),
                      if (cubit.currentIndex == 2)
                        Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple[300],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: SvgPicture.asset(
                              "assets/svg/date.svg",
                              height: 30,
                              color: Colors.white,
                            )),
                    ],
                  ),
                  if (cubit.currentIndex == 2)
                    Text(
                        "${cubit.datedTasks.length} tasks in ${TimeDateModel.getWeekday(cubit.days[cubit.selectedDateIndex])}, ${cubit.days[cubit.selectedDateIndex].day}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              titleSpacing: 10,
            ),
            body: screens[cubit.currentIndex],
            floatingActionButton: CustomDockedButton(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
        },
      ),
    );
  }
}
