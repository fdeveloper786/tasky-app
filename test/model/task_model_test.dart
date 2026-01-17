import 'package:flutter_test/flutter_test.dart';
import 'package:tasky/src/model/task_model.dart';

void main() {
  group('Task Model Tests', () {
    test(
      'WHEN toMap is called THEN it should convert Task to Map correctly',
      () {
        // Arrange
        final task = Task(
          key: 1,
          title: 'Test Task',
          isDone: false,
          isPriority: true,
          date: DateTime(2026, 1, 17),
        );

        // Act
        final map = task.toMap();

        // Assert
        expect(map['title'], 'Test Task');
        expect(map['isDone'], false);
        expect(map['isPriority'], true);
        expect(map['date'], isA<String>());
      },
    );

    test(
      'WHEN fromMap is called with String date THEN it should parse DateTime correctly',
      () {
        // Arrange
        final map = {
          'title': 'Test Task',
          'isDone': true,
          'isPriority': false,
          'date': '2026-01-17T00:00:00.000',
        };

        // Act
        final task = Task.fromMap(1, map);

        // Assert
        expect(task.key, 1);
        expect(task.title, 'Test Task');
        expect(task.isDone, true);
        expect(task.isPriority, false);
        expect(task.date, isA<DateTime>());
        expect(task.date.year, 2026);
      },
    );

    test(
      'WHEN fromMap is called with DateTime THEN it should keep DateTime unchanged',
      () {
        // Arrange
        final date = DateTime(2026, 1, 17);
        final map = {
          'title': 'Direct Date Task',
          'isDone': false,
          'isPriority': true,
          'date': date,
        };

        // Act
        final task = Task.fromMap(2, map);

        // Assert
        expect(task.key, 2);
        expect(task.date, date);
      },
    );

    test(
      'WHEN Task is converted to Map and back THEN data should remain consistent',
      () {
        // Arrange
        final originalTask = Task(
          key: 10,
          title: 'Round Trip Task',
          isDone: true,
          isPriority: false,
          date: DateTime(2026, 1, 17),
        );

        // Act
        final map = originalTask.toMap();
        final recreatedTask = Task.fromMap(10, map);

        // Assert
        expect(recreatedTask.key, originalTask.key);
        expect(recreatedTask.title, originalTask.title);
        expect(recreatedTask.isDone, originalTask.isDone);
        expect(recreatedTask.isPriority, originalTask.isPriority);
        expect(recreatedTask.date, originalTask.date);
      },
    );
  });
}
