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
  final TextEditingController descriptionController = TextEditingController();
  final bool add;
  final DropDownTaskType downTaskType = DropDownTaskType(
    items: const [
      "school",
      "work",
      "health",
      "other",
    ],
    validator: (value) {
      if (value!.isEmpty) {
        return "Task type must not be empty";
      }
    },
  );
  @override
  Widget build(BuildContext context) {
    if (taskModel != null) {
      titleController.text = taskModel!.name!;
      descriptionController.text = taskModel!.description!;
      downTaskType.dropValue = taskModel!.type;
    }

    return BlocProvider(
      create: ((context) => AppCubit()),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          AppCubit cubit = context.read<AppCubit>();
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
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
                  ),
                  TaskDetailsTextField(
                    controller: titleController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Task title must not be empty";
                      }
                      return null;
                    },
                    hint: "Task Title",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TaskDetailsTextField(
                    controller: descriptionController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Task description must not be empty";
                      }
                    },
                    hint: "Task Description",
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
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
                          text: (add && cubit.time == null)
                              ? "time"
                              : cubit.time != null
                                  ? cubit.time!
                                  : taskModel!.startTime!,
                          icon: (add && cubit.time == null)
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
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  downTaskType,
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    text: add ? "Add to your tasks" : "Mark as completed",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        add
                            ? cubit.addTask(
                                name: titleController.text,
                                description: descriptionController.text,
                                date: "22 june 2020",
                                startTime: "11:00 pm",
                                endTime: "01:00 am",
                                status: "ongoing",
                                type: downTaskType.dropValue!,
                              )
                            : {};
                      } else {
                        //print("null");
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
