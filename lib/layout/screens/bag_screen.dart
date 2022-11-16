import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habbit/cubit/app_cubit.dart';
import 'package:habbit/cubit/app_states.dart';
import 'package:habbit/models/time_date_model.dart';

class BagScreen extends StatelessWidget {
  const BagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(builder: (context, state) {
      AppCubit cubit = context.read<AppCubit>();
      if (cubit.todayTasks.isEmpty) {
        return const Center(
          child: Text(
            "There is no tasks for today",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }
      return SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Image(
                  image: AssetImage(
                      "assets/img/${cubit.todayTasks[cubit.selectedTaskIndex].type!}.jpg"),
                  fit: BoxFit.cover,
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                ),
                Positioned(
                  left: 10,
                  top: 0,
                  child: Text(
                    cubit.todayTasks[cubit.selectedTaskIndex].type!,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white60,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          cubit.todayTasks[cubit.selectedTaskIndex].name!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Text(
                          "- ${cubit.todayTasks[cubit.selectedTaskIndex].status!} task",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height - 500,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 25,
              ),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(70)),
                  gradient: LinearGradient(colors: [
                    Colors.indigo.shade400,
                    Colors.blue.shade400,
                  ])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                          "${cubit.todayTasks[cubit.selectedTaskIndex].startTime!}"),
                      Container(
                        width: 1.5,
                        height: 50,
                        color: Colors.white,
                      ),
                      Text(
                          "${cubit.todayTasks[cubit.selectedTaskIndex].endTime!}"),
                    ],
                  ),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          cubit.changeSelectedTaskIndex(index);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              cubit.todayTasks[index].name!,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 24),
                            ),
                            Text(
                              """${TimeDateModel.subtractTimes(startTime: cubit.todayTasks[index].startTime!, endTime: cubit.todayTasks[index].endTime!)} Min""",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 24),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (contex, index) => const SizedBox(
                      height: 15,
                    ),
                    itemCount: cubit.todayTasks.length,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
