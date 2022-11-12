import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habbit/cubit/app_cubit.dart';
import 'package:habbit/cubit/app_states.dart';
import 'package:habbit/layout/screens/bag_screen.dart';
import 'package:habbit/layout/screens/calendar_screen.dart';
import 'package:habbit/layout/screens/dashboard_screen.dart';
import 'package:habbit/layout/screens/profile_screen.dart';
import 'package:habbit/layout/widgets/bottom_sheet_widget.dart';
import 'package:habbit/layout/widgets/custom_docked_button.dart';
import 'package:habbit/layout/widgets/hobbit_navigation_bar.dart';
import 'package:habbit/layout/widgets/task_search_text_field.dart';

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
      create: (context) => AppCubit()..getStatusBasedTasks(status: "ongoing"),
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
              toolbarHeight: 55,
              title: Row(
                children: [
                  Text(
                    "June 03 2022",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Expanded(child: TaskSearchTextField())
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
