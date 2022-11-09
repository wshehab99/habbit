import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habbit/layout/widgets/coustom_button.dart';
import 'package:habbit/layout/widgets/drop_down_task_type.dart';
import 'package:habbit/layout/widgets/task_details_text_field.dart';
import 'package:habbit/layout/widgets/time_date_widget.dart';
import 'package:habbit/models/task_model.dart';
import 'package:habbit/models/task_type_model.dart';

class BottomSheetWidget extends StatelessWidget {
  BottomSheetWidget({
    super.key,
    this.taskModel,
  });
  final TaskModel? taskModel;
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    titleController.text = taskModel!.name!;

    return Form(
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
          SizedBox(
            height: 10,
          ),
          TaskDetailsTextField(
            controller: descriptionController,
            validator: (value) {
              if (value!.isEmpty) {
                return "Task description must not be empty";
              }
              return null;
            },
            hint: "Task Description",
            maxLines: 3,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                TimeDateWidget(
                  text: taskModel!.date!,
                  icon: SvgPicture.asset(
                    "assets/svg/calendar_active.svg",
                    height: 18,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                TimeDateWidget(
                  text: taskModel!.startTime!,
                  icon: SvgPicture.asset(
                    "assets/svg/clock.svg",
                    height: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          DropDownTaskType(
            items: TaskTypeModel.getTaskNames(),
            validator: (value) {
              if (value!.isEmpty) {
                return "Task type must not be empty";
              }
              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          CustomButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                print("validate");
              } else {
                print("null");
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
