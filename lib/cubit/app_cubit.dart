import 'package:bloc/bloc.dart';
import 'package:habbit/cubit/app_states.dart';
import 'package:habbit/db_helper/database_helper.dart';
import 'package:habbit/models/task_model.dart';

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
    await DataBaseHelper.addTask(task: taskModel).then((value) {
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

  List<TaskModel> schoolTasks = [];
  void getSchoolTasks() async {
    await DataBaseHelper.getQueryTasks(query: "type = ?", values: ["school"])
        .then((value) {
      value.forEach(
        (element) {
          schoolTasks.add(TaskModel.fromMap(map: element));
        },
      );
      emit(GetSchoolTasksState());
    });
  }

  List<TaskModel> workTasks = [];
  void getWorkTasks() async {
    await DataBaseHelper.getQueryTasks(query: "type = ?", values: ["work"])
        .then((value) {
      value.forEach(
        (element) {
          workTasks.add(TaskModel.fromMap(map: element));
        },
      );
      emit(GetWorkTasksState());
    });
  }

  List<TaskModel> healthTasks = [];
  void getHealthTasks() async {
    await DataBaseHelper.getQueryTasks(query: "type = ?", values: ["health"])
        .then((value) {
      value.forEach(
        (element) {
          healthTasks.add(TaskModel.fromMap(map: element));
        },
      );
      emit(GetHealthTasksState());
    });
  }

  List<TaskModel> otherTasks = [];
  void getOtherTasks() async {
    await DataBaseHelper.getQueryTasks(query: "type = ?", values: ["other"])
        .then((value) {
      value.forEach(
        (element) {
          otherTasks.add(TaskModel.fromMap(map: element));
        },
      );
      emit(GetOtherTasksState());
    });
  }

  List<TaskModel> ongoingTasks = [];
  void getOngoingTasks() async {
    await DataBaseHelper.getQueryTasks(query: "status = ?", values: [
      "ongoing",
    ]).then((value) {
      value.forEach(
        (element) {
          ongoingTasks.add(TaskModel.fromMap(map: element));
        },
      );
      emit(GetOngoingTasksState());
    });
  }

  List<TaskModel> searchedTasks = [];
  void searchTask({required String value}) async {
    DataBaseHelper.searchAboutTasks(value: value).then((value) {
      value.forEach((element) {
        TaskModel.fromMap(map: element);
      });
      emit(SearchState());
    });
  }
}
