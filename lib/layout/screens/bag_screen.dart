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
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Image(
              image: AssetImage("assets/img/work.png"),
              height: 300,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              padding: EdgeInsets.only(top: 73, left: 15, right: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(90)),
                  gradient: LinearGradient(colors: [
                    Colors.indigo.shade400,
                    Colors.blue.shade400,
                  ])),
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          cubit.datedTasks[index].name!,
                          style: TextStyle(fontSize: 24),
                        ),
                        Text(
                          """${TimeDateModel.subtractTimes(startTime: cubit.datedTasks[index].startTime!, endTime: cubit.datedTasks[index].endTime!)} Min""",
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (contex, index) => SizedBox(
                  height: 15,
                ),
                itemCount: cubit.datedTasks.length,
              ),
            ),
          ],
        ),
      );
    });
  }
}
