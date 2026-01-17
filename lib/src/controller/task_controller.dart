import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../model/task_model.dart';
import 'package:hive/hive.dart';

class TaskController extends GetxController {
  final Box tasksBox = Hive.box('tasks');

  RxList<Task> tasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  void loadTasks() {
    if (tasksBox.isEmpty) {
      tasks.clear();
      return;
    }

    final loadedTasks = tasksBox.keys.map((key) {
      final data = tasksBox.get(key);
      return Task.fromMap(key, Map<String, dynamic>.from(data));
    }).toList();

    tasks.assignAll(loadedTasks);
  }

  Future<void> addTask(String title, bool priority, DateTime date) async {
    // 1️⃣ Await Hive key
    final int key = await tasksBox.add({
      'title': title,
      'isDone': false,
      'isPriority': priority,
      'date': date,
    });

    // 2️⃣ Create Task with key
    final task = Task(
      key: key,
      title: title,
      isDone: false,
      isPriority: priority,
      date: date,
    );

    // 3️⃣ Update UI list
    tasks.add(task);
  }

  void toggleDone(Task task) {
    final updatedTask = Task(
      key: task.key,
      title: task.title,
      isDone: !task.isDone,
      isPriority: task.isPriority,
      date: task.date,
    );

    tasksBox.put(task.key, updatedTask.toMap());

    final i = tasks.indexWhere((t) => t.key == task.key);
    if (i != -1) {
      tasks[i] = updatedTask;
    }
  }

  void deleteTask(Task task) {
    tasksBox.delete(task.key);
    tasks.removeWhere((t) => t.key == task.key);
  }

  Map<DateTime, List> groupedTasks() {
    final Map<DateTime, List> map = {};
    for (var t in tasks) {
      final date = DateTime(t.date.year, t.date.month, t.date.day);
      map.putIfAbsent(date, () => []);
      map[date]!.add(t);
    }
    return map;
  }
}
