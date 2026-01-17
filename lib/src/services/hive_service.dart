import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static final tasksBox = Hive.box('tasks');

  static List<Map> getTasks() {
    return tasksBox.values.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  static addTask(Map task) {
    tasksBox.add(task);
  }

  static updateTask(int index, Map task) {
    tasksBox.putAt(index, task);
  }

  static deleteTask(int index) {
    tasksBox.deleteAt(index);
  }
}
