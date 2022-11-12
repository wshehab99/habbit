import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habbit/layout/screens/task_type_details_screen.dart';
import 'package:habbit/models/task_type_model.dart';

class TaskTypeCardWidget extends StatelessWidget {
  const TaskTypeCardWidget({
    super.key,
    this.taskTypeModel,
  });
  final TaskTypeModel? taskTypeModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45),
        gradient: LinearGradient(
          colors: [
            taskTypeModel!.startColor!,
            taskTypeModel!.endColor!,
          ],
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskTypeDetailsScreen(
                taskTypeModel: taskTypeModel,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Center(
                      child: Text(
                    "${taskTypeModel!.taskRank!}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  )),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                ),
                Row(
                  children: [
                    Text(
                      taskTypeModel!.name!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      CupertinoIcons.arrowtriangle_right_fill,
                      size: 20,
                      color: Colors.white,
                    )
                  ],
                ),
                Text(
                  "${taskTypeModel!.taskNo} Tasks",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
