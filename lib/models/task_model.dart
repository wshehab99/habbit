class TaskModel {
  String? name;
  String? date;
  String? startTime;
  String? endTime;
  TaskStatus? status;
  TaskTypes? type;
  TaskModel({
    this.name,
    this.date,
    this.startTime,
    this.endTime,
    this.status,
    this.type,
  });
  static List<TaskModel> getSchoolTasks() {
    return [
      TaskModel(
        name: 'this is task 1',
        date: 'june 06 2022',
        startTime: '13:00',
        endTime: '15:00',
        status: TaskStatus.waiting,
        type: TaskTypes.school,
      ),
      TaskModel(
        name: 'this is task 2',
        date: 'june 10 2022',
        startTime: '07:00',
        endTime: '10:00',
        status: TaskStatus.done,
        type: TaskTypes.school,
      ),
      TaskModel(
        name: 'this is task 10',
        date: 'june 30 2022',
        startTime: '20:00',
        endTime: '22:30',
        status: TaskStatus.waiting,
        type: TaskTypes.school,
      ),
      TaskModel(
        name: 'this is task 7',
        date: 'july 08 2022',
        startTime: '10:00',
        endTime: '13:00',
        status: TaskStatus.ongoing,
        type: TaskTypes.school,
      ),
      TaskModel(
        name: 'this is task 31',
        date: 'june 29 2022',
        startTime: '13:00',
        endTime: '15:00',
        status: TaskStatus.waiting,
        type: TaskTypes.school,
      ),
      TaskModel(
        name: 'this is task 31',
        date: 'june 29 2022',
        startTime: '13:00',
        endTime: '15:00',
        status: TaskStatus.waiting,
        type: TaskTypes.school,
      ),
      TaskModel(
        name: 'this is task 31',
        date: 'june 29 2022',
        startTime: '13:00',
        endTime: '15:00',
        status: TaskStatus.waiting,
        type: TaskTypes.school,
      ),
      TaskModel(
        name: 'this is task 31',
        date: 'june 29 2022',
        startTime: '13:00',
        endTime: '15:00',
        status: TaskStatus.waiting,
        type: TaskTypes.school,
      ),
    ];
  }
}

enum TaskStatus {
  waiting,
  ongoing,
  done,
}

enum TaskTypes {
  school,
  work,
  health,
  other,
}
