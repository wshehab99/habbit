import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:habbit/cubit/app_cubit.dart';
import 'package:habbit/cubit/app_states.dart';
import 'package:habbit/layout/widgets/coustom_button.dart';
import 'package:habbit/layout/widgets/drop_down_task_type.dart';
import 'package:habbit/layout/widgets/hobbit_date_dialog.dart';
import 'package:habbit/layout/widgets/hobbit_delete_dialog.dart';
import 'package:habbit/layout/widgets/hobbit_time_dialog.dart';
import 'package:habbit/layout/widgets/hobbit_toast.dart';
import 'package:habbit/layout/widgets/task_details_text_field.dart';
import 'package:habbit/layout/widgets/time_date_widget.dart';
import 'package:habbit/models/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habbit/models/time_date_model.dart';

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
              if (taskModel != null && state is InitialAppState) {
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
                                HobbitDeleteDialog.showHobbitDialog(
                                  context: context,
                                  deleteMethod: () {
                                    cubit
                                        .deleteTask(id: taskModel!.id!)
                                        .then((value) {
                                      HobbitToast.showToast(
                                          state: ToastState.delete);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    });
                                  },
                                  cancelMethod: () {
                                    Navigator.pop(context);
                                  },
                                );
                              },
                              icon: SvgPicture.asset("assets/svg/trash.svg"),
                            ),
                            IconButton(
                              onPressed: () {
                                cubit
                                    .updateTask(
                                  id: taskModel!.id!,
                                  name: cubit.title!,
                                  description: cubit.description!,
                                  date: cubit.date ?? taskModel!.date!,
                                  startTime: cubit.startTime!,
                                  endTime: cubit.endTime!,
                                  status: taskModel!.status!,
                                  type: cubit.dropValue!,
                                )
                                    .then((value) {
                                  HobbitToast.showToast(
                                    state: ToastState.update,
                                  );
                                  Navigator.pop(context);
                                });
                              },
                              icon: SvgPicture.asset("assets/svg/complete.svg"),
                            ),
                          ],
                        )
                      : const SizedBox(
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
                            ? const SizedBox()
                            : SvgPicture.asset(
                                "assets/svg/date.svg",
                                color: Colors.white,
                                height: 18,
                              ),
                        onPressed: () {
                          HobbitDateDialog.showDateDialog(
                            context: context,
                            initialDate: cubit.date != null
                                ? TimeDateModel.getDateFromString(cubit.date!)
                                : DateTime.now(),
                            firstDate: DateTime.now(),
                          ).then(
                            (value) {
                              if (value != null) {
                                cubit.changeDate(dateTime: value);
                              }
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
                            ? const SizedBox()
                            : SvgPicture.asset(
                                "assets/svg/clock.svg",
                                height: 18,
                                color: Colors.white,
                              ),
                        onPressed: () {
                          HobbitTimeDialog.showTimeDialog(
                              context: context,
                              value: cubit.startTime != null
                                  ? TimeDateModel.getTimeFromString(
                                      cubit.startTime!)
                                  : TimeOfDay.now(),
                              onChange: (value) {
                                cubit.changeTime(timeOfDay: value);
                              });
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
                    text: add
                        ? "Add to your tasks"
                        : taskModel!.status == "done"
                            ? "Mark as ongoing"
                            : "Mark as completed",
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
                                HobbitToast.showToast(
                                  state: ToastState.add,
                                );
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
                                  status: taskModel!.status == "done"
                                      ? "ongoing"
                                      : "done",
                                  type: cubit.dropValue!,
                                )
                                    .then((value) {
                                  HobbitToast.showToast(
                                    state: ToastState.update,
                                  );
                                  Navigator.pop(context);
                                })
                              };
                      } else {
                        HobbitToast.showToast(
                          state: ToastState.error,
                        );
                      }
                    },
                  ),
                  const SizedBox(
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
