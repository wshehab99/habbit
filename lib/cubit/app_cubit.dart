import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:habbit/cubit/app_states.dart';
import 'package:habbit/db_helper/database_helper.dart';
import 'package:habbit/models/task_model.dart';
import 'package:habbit/models/task_type_model.dart';
import 'package:intl/intl.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitialAppState());
  int currentIndex = 0;

  void changePage(int index) {
    currentIndex = index;
    emit(ChangePage());
  }

  void changeCurrentScreen(int index) {
    currentIndex = index;
    emit(ChangePage());
  }

  void addTask({
    required String name,
    required String description,
    required String date,
    required String startTime,
    required String endTime,
    required String status,
    required String type,
  }) async {
    TaskModel taskModel = TaskModel(
      name: name,
      date: date,
      endTime: endTime,
      startTime: startTime,
      status: status,
      type: type,
      description: description,
    );
    DataBaseHelper.addTask(task: taskModel).then((value) {
      print("added");
      emit(AddTaskState());
    });
  }

  void updateTask({
    required String name,
    required String description,
    required String date,
    required String startTime,
    required String endTime,
    required String status,
    required String type,
  }) async {
    TaskModel task = TaskModel(
      name: name,
      date: date,
      startTime: startTime,
      endTime: endTime,
      status: status,
      type: type,
      description: description,
    );
    await DataBaseHelper.updateTask(task: task).then((value) {
      emit(UpdateTaskState());
    });
  }

  List<TaskModel> shownTasks = [];
  List<TaskTypeModel> taskType = [];
  void getTypedTasks({required String type}) async {
    await TaskTypeModel.getTaskTypes().then((value) {
      taskType = value;
    });
    await DataBaseHelper.getQueryTasks(query: "type = ?", values: [type])
        .then((value) {
      value.forEach(
        (element) {
          shownTasks.add(TaskModel.fromMap(map: element));
        },
      );
      emit(GetTypedTasksState());
    });
  }

  List<TaskModel> statusBasedTasks = [];
  void getStatusBasedTasks({required String status}) async {
    await TaskTypeModel.getTaskTypes().then((value) {
      taskType = value;
    });
    await DataBaseHelper.getQueryTasks(query: "status = ?", values: [status])
        .then((value) {
      value.forEach(
        (element) {
          statusBasedTasks.add(TaskModel.fromMap(map: element));
        },
      );
      print(value);
      emit(GetStatusBasedTasksState());
    });
  }

  List<TaskModel> searchedTasks = [];
  void searchTask({required String value}) async {
    DataBaseHelper.searchAboutTasks(value: value).then((value) {
      value.forEach((element) {
        searchedTasks.add(TaskModel.fromMap(map: element));
      });
      emit(SearchState());
    });
  }

  String? date;
  void changeDate({required DateTime dateTime}) {
    date = DateFormat.yMMMd().format(dateTime);
    emit(ChangeDateState());
  }

  String? time;
  void changeTime({required timeOfDay}) {
    time = DateFormat.jm().format(dateTimeExtension(timeOfDay));

    emit(ChangeTimeState());
  }

  DateTime dateTimeExtension(TimeOfDay time) {
    return DateTime(
      2000,
      1,
      1,
      time.hour,
      time.minute,
    );
  }
}
