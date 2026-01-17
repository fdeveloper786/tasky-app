import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasky/src/services/hive_service.dart';

void main() {
  late Box tasksBox;

  setUpAll(() async {
    // Arrange
    final testDir = Directory.systemTemp.createTempSync();
    Hive.init(testDir.path);
    tasksBox = await Hive.openBox('tasks');
  });

  tearDown(() async {
    await tasksBox.clear();
  });

  tearDownAll(() async {
    await tasksBox.close();
    Hive.deleteFromDisk();
  });

  group('HiveService Tests', () {
    test(
      'WHEN addTask is called THEN task should be added to Hive',
      () {
        // Arrange
        final task = {
          'title': 'Test Task',
          'isDone': false,
          'isPriority': true,
          'date': DateTime(2026, 1, 17).toIso8601String(),
        };

        // Act
        HiveService.addTask(task);

        // Assert
        expect(tasksBox.length, 1);
        expect(tasksBox.getAt(0)['title'], 'Test Task');
      },
    );

    test(
      'WHEN getTasks is called THEN it should return all tasks as List<Map>',
      () {
        // Arrange
        HiveService.addTask({'title': 'Task 1'});
        HiveService.addTask({'title': 'Task 2'});

        // Act
        final tasks = HiveService.getTasks();

        // Assert
        expect(tasks.length, 2);
        expect(tasks.first['title'], 'Task 1');
        expect(tasks.last['title'], 'Task 2');
      },
    );

    test(
      'WHEN updateTask is called THEN the task should be updated in Hive',
      () {
        // Arrange
        HiveService.addTask({'title': 'Old Task'});
        final updatedTask = {'title': 'Updated Task'};

        // Act
        HiveService.updateTask(0, updatedTask);

        // Assert
        expect(tasksBox.getAt(0)['title'], 'Updated Task');
      },
    );

    test(
      'WHEN deleteTask is called THEN the task should be removed from Hive',
      () {
        // Arrange
        HiveService.addTask({'title': 'Delete Me'});
        expect(tasksBox.length, 1);

        // Act
        HiveService.deleteTask(0);

        // Assert
        expect(tasksBox.isEmpty, true);
      },
    );

    test(
      'WHEN multiple tasks exist THEN deleteTask should remove correct index',
      () {
        // Arrange
        HiveService.addTask({'title': 'Task 1'});
        HiveService.addTask({'title': 'Task 2'});
        HiveService.addTask({'title': 'Task 3'});

        // Act
        HiveService.deleteTask(1);

        // Assert
        expect(tasksBox.length, 2);
        expect(tasksBox.getAt(0)['title'], 'Task 1');
        expect(tasksBox.getAt(1)['title'], 'Task 3');
      },
    );
  });
}
