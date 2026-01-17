import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasky/src/controller/task_controller.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

class MockPathProviderPlatform extends PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async {
    final directory = Directory.systemTemp.createTempSync();
    return directory.path;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late TaskController controller;

  setUpAll(() async {
    PathProviderPlatform.instance = MockPathProviderPlatform();
    await Hive.initFlutter();
    await Hive.openBox('tasks');
    await Hive.openBox('meta');
    Get.reset();
  });

  tearDownAll(() async {
    await Hive.close();
  });

  setUp(() {
    controller = TaskController();
    controller.tasksBox.clear();
    controller.tasks.clear();
  });

  group('TaskController Tests ', () {
    late TaskController controller;

    setUp(() async {
      await Hive.box('tasks').clear();
      controller = TaskController();
    });

    test(
      'WHEN a task is added THEN it should be present in tasks list',
      () async {
        // Arrange
        const title = 'Test Task';
        final date = DateTime(2026, 1, 17);

        // Act
        await controller.addTask(title, true, date);

        // Assert
        expect(controller.tasks.length, 1);
        final task = controller.tasks.first;
        expect(task.title, title);
        expect(task.isPriority, true);
        expect(task.isDone, false);
        expect(task.date, date);
      },
    );

    test(
      'WHEN toggleDone is called THEN isDone field should flip',
      () async {
        // Arrange
        await controller.addTask('Task 1', false, DateTime.now());

        // Act
        controller.toggleDone(controller.tasks.first);

        // Assert
        expect(controller.tasks.first.isDone, true);
      },
    );

    test(
      'WHEN loadTasks is called THEN tasks from Hive should populate controller',
      () async {
        // Arrange
        await Hive.box('tasks').clear();
        final date = DateTime(2026, 1, 17);
        await Hive.box('tasks').add({
          'title': 'Hive Task',
          'isDone': false,
          'isPriority': true,
          'date': date,
        });

        final controller = TaskController();

        // Act
        controller.loadTasks();

        // Assert
        expect(controller.tasks.length, 1);
        expect(controller.tasks.first.title, 'Hive Task');
      },
    );
  });
  test(
    'WHEN deleteTask is called THEN task should be removed from controller and Hive',
    () async {
      // Arrange
      await controller.addTask('Delete Me', false, DateTime.now());
      final task = controller.tasks.first;

      // Act
      controller.deleteTask(task);

      // Assert
      expect(controller.tasks.isEmpty, true);
      expect(controller.tasksBox.isEmpty, true);
    },
  );
  test(
    'WHEN groupedTasks is called THEN tasks should be grouped by date',
    () async {
      // Arrange
      final date1 = DateTime(2026, 1, 17, 10);
      final date2 = DateTime(2026, 1, 17, 18);
      final date3 = DateTime(2026, 1, 18);

      await controller.addTask('Task 1', false, date1);
      await controller.addTask('Task 2', false, date2);
      await controller.addTask('Task 3', false, date3);

      // Act
      final grouped = controller.groupedTasks();

      // Assert
      expect(grouped.length, 2);
      expect(grouped[DateTime(2026, 1, 17)]!.length, 2);
      expect(grouped[DateTime(2026, 1, 18)]!.length, 1);
    },
  );
  test(
    'WHEN loadTasks is called AND Hive is empty THEN tasks list should be cleared',
    () async {
      // Arrange
      await controller.addTask('Temp Task', false, DateTime.now());
      expect(controller.tasks.isNotEmpty, true);

      await controller.tasksBox.clear();

      // Act
      controller.loadTasks();

      // Assert
      expect(controller.tasks.isEmpty, true);
    },
  );
  test(
    'WHEN controller is registered with GetX THEN onInit should load tasks',
    () async {
      // Arrange
      final date = DateTime(2026, 1, 17);
      await Hive.box('tasks').add({
        'title': 'Init Task',
        'isDone': false,
        'isPriority': false,
        'date': date,
      });

      // Act
      Get.reset();
      final controller = Get.put(TaskController());

      // Assert
      expect(controller.tasks.length, 0);
    },
  );
}
