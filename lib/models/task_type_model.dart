import 'package:flutter/material.dart';

class TaskTypeModel {
  String? name;
  int? taskRank;
  int? taskNo;
  Color? startColor;
  Color? endColor;
  int? crossAxisCellCount;
  int? mainAxisCellCount;
  int? completedTasks;
  TaskTypeModel({
    this.name,
    this.taskRank,
    this.taskNo,
    this.startColor,
    this.endColor,
    this.crossAxisCellCount = 3,
    this.mainAxisCellCount,
    this.completedTasks,
  });
  static List<TaskTypeModel> getTaskTypes() {
    return [
      TaskTypeModel(
        name: "School",
        taskRank: 1,
        taskNo: 4,
        startColor: Color.fromARGB(255, 253, 147, 70),
        endColor: Color.fromARGB(255, 253, 183, 119),
        mainAxisCellCount: 4,
        completedTasks: 2,
      ),
      TaskTypeModel(
        name: "Work",
        taskRank: 2,
        taskNo: 2,
        startColor: Color.fromARGB(255, 134, 147, 117),
        endColor: Color.fromARGB(255, 189, 212, 231),
        completedTasks: 2,
        mainAxisCellCount: 3,
      ),
      TaskTypeModel(
        name: "Health",
        taskRank: 3,
        taskNo: 1,
        completedTasks: 0,
        startColor: Color.fromARGB(255, 100, 125, 238),
        endColor: Color.fromARGB(255, 127, 83, 172),
        mainAxisCellCount: 4,
      ),
      TaskTypeModel(
        name: "Other",
        taskRank: 4,
        taskNo: 0,
        startColor: Color.fromARGB(255, 119, 238, 216),
        endColor: Color.fromARGB(255, 158, 171, 212),
        mainAxisCellCount: 3,
        completedTasks: 0,
      ),
    ];
  }
}
