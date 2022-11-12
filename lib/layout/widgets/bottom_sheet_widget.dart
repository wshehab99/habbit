import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habbit/cubit/app_cubit.dart';
import 'package:habbit/cubit/app_states.dart';
import 'package:habbit/layout/widgets/coustom_button.dart';
import 'package:habbit/layout/widgets/drop_down_task_type.dart';
import 'package:habbit/layout/widgets/task_details_text_field.dart';
import 'package:habbit/layout/widgets/time_date_widget.dart';
import 'package:habbit/models/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomSheetWidget extends StatelessWidget {
  BottomSheetWidget({
    super.key,
    this.taskModel,
    this.add = false,
  });
  final TaskModel? taskModel;
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();

  final bool add;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 15,
        right: 15,
      ),
      child: SingleChildScrollView(
        child: BlocProvider(
          create: ((context) => AppCubit()),
          child: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              AppCubit cubit = context.read<AppCubit>();
              if (taskModel != null) {
                cubit.initTaskValues(task: taskModel!);
              }
              return Column(
                children: [
                  !add
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: SvgPicture.asset("assets/svg/trash.svg"),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: SvgPicture.asset("assets/svg/complete.svg"),
                            ),
                          ],
                        )
                      : SizedBox(
                          height: 15,
                        ),
                  TaskDetailsTextField(
                    value: cubit.title,
                    onChanged: (value) {
                      cubit.onTextFieldChange(text: value, isTitle: true);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Task title must not be empty";
                      }
                      return null;
                    },
                    hint: "Task Title",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TaskDetailsTextField(
                    value: cubit.description,
                    onChanged: (value) {
                      cubit.onTextFieldChange(text: value, isTitle: false);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Task description must not be empty";
                      }
                    },
                    hint: "Task Description",
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      TimeDateWidget(
                        text: (add && cubit.date == null)
                            ? "date"
                            : cubit.date != null
                                ? cubit.date
                                : taskModel!.date!,
                        icon: (add && cubit.date == null)
                            ? SizedBox()
                            : SvgPicture.asset(
                                "assets/svg/date.svg",
                                color: Colors.white,
                                height: 18,
                              ),
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2050),
                          ).then(
                            (value) {
                              cubit.changeDate(dateTime: value!);
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TimeDateWidget(
                        text: (add && cubit.startTime == null)
                            ? "time"
                            : cubit.startTime != null
                                ? cubit.startTime!
                                : taskModel!.startTime!,
                        icon: (add && cubit.startTime == null)
                            ? SizedBox()
                            : SvgPicture.asset(
                                "assets/svg/clock.svg",
                                height: 18,
                                color: Colors.white,
                              ),
                        onPressed: () {
                          Navigator.of(context).push(
                            showPicker(
                              context: context,
                              value: TimeOfDay.now(),
                              onChange: (value) {
                                if (value != null) {
                                  cubit.changeTime(timeOfDay: value);
                                }
                              },
                              blurredBackground: true,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DropDownTaskType(
                    items: const [
                      "school",
                      "work",
                      "health",
                      "other",
                    ],
                    dropValue: cubit.dropValue,
                    onChanged: (value) {
                      cubit.changeTaskType(value: value!);
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    text: add ? "Add to your tasks" : "Mark as completed",
                    onPressed: () async {
                      if (cubit.title != null &&
                          cubit.description != null &&
                          cubit.date != null &&
                          cubit.startTime != null &&
                          cubit.dropValue != null) {
                        add
                            ? cubit
                                .addTask(
                                name: cubit.title!,
                                description: cubit.description!,
                                date: cubit.date ?? taskModel!.date!,
                                startTime: cubit.startTime!,
                                endTime: cubit.endTime!,
                                status: "ongoing",
                                type: cubit.dropValue!,
                              )
                                .then((value) {
                                Navigator.pop(context);
                              })
                            : {
                                cubit
                                    .updateTask(
                                  id: taskModel!.id!,
                                  name: cubit.title!,
                                  description: cubit.description!,
                                  date: cubit.date ?? taskModel!.date!,
                                  startTime: cubit.startTime!,
                                  endTime: cubit.endTime!,
                                  status: "done",
                                  type: cubit.dropValue!,
                                )
                                    .then((value) {
                                  Navigator.pop(context);
                                })
                              };
                      } else {
                        //print("null");
                      }
                    },
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
