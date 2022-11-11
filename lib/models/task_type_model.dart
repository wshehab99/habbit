import 'package:flutter/material.dart';
import 'package:habbit/db_helper/database_helper.dart';

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
  static Future<List<TaskTypeModel>> getTaskTypes() async {
    return [
      TaskTypeModel(
        name: "School",
        taskRank: 1,
        taskNo: await DataBaseHelper.countTasksBasedOnCondition(
            query: "type = ? ", values: ["school"]),
        startColor: Color.fromARGB(255, 253, 147, 70),
        endColor: Color.fromARGB(255, 253, 183, 119),
        mainAxisCellCount: 4,
        completedTasks: await DataBaseHelper.countTasksBasedOnCondition(
            query: "type = ? AND status = ?", values: ["school", "done"]),
      ),
      TaskTypeModel(
        name: "Work",
        taskRank: 2,
        taskNo: await DataBaseHelper.countTasksBasedOnCondition(
            query: "type = ? ", values: ["work"]),
        startColor: Color.fromARGB(255, 134, 147, 117),
        endColor: Color.fromARGB(255, 189, 212, 231),
        completedTasks: await DataBaseHelper.countTasksBasedOnCondition(
            query: "type = ? AND status = ?", values: ["work", "done"]),
        mainAxisCellCount: 3,
      ),
      TaskTypeModel(
        name: "Health",
        taskRank: 3,
        taskNo: await DataBaseHelper.countTasksBasedOnCondition(
            query: "type = ? ", values: ["health"]),
        completedTasks: await DataBaseHelper.countTasksBasedOnCondition(
            query: "type = ? AND status = ?", values: ["health", "done"]),
        startColor: Color.fromARGB(255, 100, 125, 238),
        endColor: Color.fromARGB(255, 127, 83, 172),
        mainAxisCellCount: 4,
      ),
      TaskTypeModel(
        name: "Other",
        taskRank: 4,
        taskNo: await DataBaseHelper.countTasksBasedOnCondition(
            query: "type = ? ", values: ["other"]),
        startColor: Color.fromARGB(255, 119, 238, 216),
        endColor: Color.fromARGB(255, 158, 171, 212),
        mainAxisCellCount: 3,
        completedTasks: await DataBaseHelper.countTasksBasedOnCondition(
            query: "type = ? AND status = ?", values: ["health", "done"]),
      ),
    ];
  }

  static Future<List<String>> getTaskNames() async {
    return await getTaskTypes().then((value) {
      return value.map((e) => e.name!).toList();
    });
  }
}
