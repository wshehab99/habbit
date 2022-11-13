import 'package:bloc/bloc.dart';
import 'package:habbit/cubit/app_states.dart';
import 'package:habbit/db_helper/database_helper.dart';
import 'package:habbit/models/task_model.dart';
import 'package:habbit/models/task_type_model.dart';
import 'package:habbit/models/time_date_model.dart';

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

  Future<void> addTask({
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

  Future<void> updateTask({
    required String name,
    required String description,
    required String date,
    required String startTime,
    required String endTime,
    required String status,
    required String type,
    required int id,
  }) async {
    TaskModel task = TaskModel(
      id: id,
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
  Future<void> getTypedTasks({required String type}) async {
    shownTasks = [];
    await TaskTypeModel.getTaskTypes().then((value) {
      taskType = value;
    });
    await DataBaseHelper.getQueryTasks(
        query: "type = ?", values: [type.toLowerCase()]).then((value) {
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
    statusBasedTasks = [];
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

      emit(GetStatusBasedTasksState());
    });
  }

  List<TaskModel> doneTasks = [];
  Future getDoneTasks() async {
    doneTasks.clear();
    await DataBaseHelper.getQueryTasks(query: "status = ?", values: ["done"])
        .then((value) {
      value.forEach(
        (element) {
          doneTasks.add(TaskModel.fromMap(map: element));
        },
      );

      emit(GetStatusBasedTasksState());
    });
  }

  List<TaskModel> searchedTasks = [];
  void searchTask({required String value}) async {
    searchedTasks = [];
    DataBaseHelper.searchAboutTasks(value: value).then((value) {
      value.forEach((element) {
        searchedTasks.add(TaskModel.fromMap(map: element));
      });
      emit(SearchState());
    });
  }

  List<TaskModel> datedTasks = [];
  void getDatedTasks({required DateTime date}) async {
    emit(LoadingState());
    datedTasks = [];
    await DataBaseHelper.getQueryTasks(
        query: "date = ?",
        values: [TimeDateModel.formatDate(date)]).then((value) {
      value.forEach((element) {
        datedTasks.add(TaskModel.fromMap(map: element));
      });
      datedTasks.sort((a, b) => TimeDateModel.dateTimeExtension(
                  TimeDateModel.getTimeFromString(a.startTime!))
              .compareTo(
            TimeDateModel.dateTimeExtension(
                TimeDateModel.getTimeFromString(b.startTime!)),
          ));
      print(value);
      emit(GetDatedTasksState());
    });
  }

  Future<void> deleteTask({required int id}) async {
    DataBaseHelper.deleteTask(id).then((value) {
      emit(DeleteTaskState());
    });
  }

  String? dropValue;
  void changeTaskType({required String value}) {
    dropValue = value;
    emit(ChangeDropDownValueState());
  }

  String? date;
  void changeDate({required DateTime dateTime}) {
    date = TimeDateModel.formatDate(dateTime);
    emit(ChangeDateState());
  }

  String? startTime;
  String? endTime;
  void changeTime({required timeOfDay}) {
    startTime = TimeDateModel.formatTime(timeOfDay);
    endTime = TimeDateModel.formatTime(
      timeOfDay,
      isEnd: true,
    );

    emit(ChangeTimeState());
  }

  String? title = "";
  String? description = "";
  void onTextFieldChange({required String text, isTitle}) {
    if (isTitle) {
      title = text;
    } else {
      description = text;
    }
  }

  void initTaskValues({required TaskModel task}) {
    title = task.name!;
    description = task.description!;
    startTime = task.startTime!;
    endTime = task.endTime!;
    date = task.date!;
    dropValue = task.type;
  }

  int selectedDateIndex = 0;
  void changeSelectedDate(int index) {
    selectedDateIndex = index;
    emit(ChangeSelectedDate());
  }

  List days = TimeDateModel.getDateBetween(
      startDate: DateTime.now(),
      endDate: DateTime.now().add(
        Duration(days: 365),
      ));
}
