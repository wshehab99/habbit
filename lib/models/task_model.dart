class TaskModel {
  String? name;
  String? date;
  String? startTime;
  String? endTime;
  String? status;
  String? type;
  String? description;
  int? id;
  TaskModel({
    required this.name,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.type,
    required this.description,
  });
  TaskModel.fromMap({required Map<String, dynamic> map}) {
    id = map['id'];
    name = map['name'];
    date = map['date'];
    startTime = map['startTime'];
    endTime = map['endTime'];
    status = map['status'];
    type = map['type'];
    description = map['description'];
  }
}
