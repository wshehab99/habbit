import 'package:habbit/models/task_model.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static Database? database;
  static Future<void> init() async {
    database = await openDatabase("tasks.db", version: 1,
        onCreate: (Database db, int version) {
      db.execute(
        "CREATE TABLE tasks (id INTEGER PRIMARY KEY, name TEXT, description TEXT, startTime TEXT, endTime TEXT, date TEXT, status TEXT, type TEXT)",
      );
    });
  }

  static Future<void> addTask({required TaskModel task}) async {
    await database!.transaction((txn) async {
      return await txn.rawInsert(
          "INSERT INTO tasks ( name, description, startTime, endTime, date, status,type) VALUES (?, ?, ?, ?, ?, ?, ?)",
          [
            task.name,
            task.description,
            task.startTime,
            task.endTime,
            task.date,
            task.status,
            task.type,
          ]);
    });
  }

  static Future<void> deleteTask(int id) async {
    await database!.rawDelete("DELETE FROM tasks WHERE id = ?,", [id]);
  }

  static Future<void> updateTask({required TaskModel task}) async {
    database!.rawUpdate(
        "UPDATE tasks SET name = ?, description = ?, startTime = ?, endTime = ?, date = ?, status = ?, type = ? WHERE id = ?",
        [
          task.name,
          task.description,
          task.startTime,
          task.endTime,
          task.date,
          task.status,
          task.type,
          task.id,
        ]);
  }

  static Future<List<Map<String, dynamic>>> getAllTasks() async {
    return await database!.rawQuery("SELECT * FROM tasks");
  }

  static Future<List<Map<String, dynamic>>> getQueryTasks({
    required String query,
    required List values,
  }) async {
    return database!.rawQuery("SELECT * FROM tasks WHERE $query", values);
  }

  static Future<List<Map<String, dynamic>>> searchAboutTasks({
    required String value,
  }) async {
    return database!
        .rawQuery("SELECT * FROM tasks WHERE name LIKE %?%", [value]);
  }

  static countTasksBasedOnCondition({
    required String query,
    required List values,
  }) async {
    return await Sqflite.firstIntValue(await database!.rawQuery(
      "SELECT SUM(CASE WHEN $query THEN 1 ELSE 0 END) FROM tasks",
      values,
    ));
  }

  static countTasks() async {
    return Sqflite.firstIntValue(
        await database!.rawQuery('SELECT COUNT(*) FROM tasks'));
  }
}
