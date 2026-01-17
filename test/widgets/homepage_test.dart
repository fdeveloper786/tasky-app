import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasky/src/model/task_model.dart';
import 'package:tasky/src/screens/homepage.dart';
import 'package:tasky/src/controller/task_controller.dart';
import 'package:tasky/src/screens/task_list_by_date_page.dart';
import 'package:tasky/src/utils/strings.dart';
import 'package:tasky/src/widgets/custom_buttom_sheet.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

class MockPathProviderPlatform extends PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async {
    final dir = Directory.systemTemp.createTempSync();
    return dir.path;
  }
}

void main() {
  late TaskController controller;
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    PathProviderPlatform.instance = MockPathProviderPlatform();

    await Hive.initFlutter();
    await Hive.openBox('tasks');
    await Hive.openBox('meta');
  });

  tearDownAll(() async {
    await Hive.close();
  });

  setUp(() {
    Get.testMode = true;
    Get.reset();

    controller = TaskController();
    controller.tasks.clear();

    Get.put<TaskController>(controller);
  });

  Get.reset();

  Widget createWidget() {
    return const GetMaterialApp(
      home: HomePage(),
    );
  }

  testWidgets(
    'WHEN no tasks exist THEN noTask text should be shown',
    (tester) async {
      // Arrange
      controller.tasks.clear();

      // Act
      await tester.pumpWidget(createWidget());
      await tester.pump();

      // Assert
      expect(find.text(noTask), findsOneWidget);
    },
  );

  testWidgets(
    'WHEN tasks exist THEN date cards should be rendered',
    (tester) async {
      // Arrange
      final date = DateTime(2026, 1, 17);

      controller.tasks.addAll([
        Task(
          key: 1,
          title: 'Task 1',
          isDone: false,
          isPriority: false,
          date: date,
        ),
        Task(
          key: 2,
          title: 'Task 2',
          isDone: false,
          isPriority: true,
          date: date,
        ),
      ]);

      // Act
      await tester.pumpWidget(createWidget());
      await tester.pump();

      // Assert
      expect(find.byType(GridView), findsOneWidget);
      expect(find.text('17-1-2026'), findsOneWidget);
      expect(find.text('2 Tasks'), findsOneWidget);
    },
  );

  testWidgets(
    'WHEN date card is tapped THEN it should navigate to TaskListByDatePage',
    (tester) async {
      // Arrange
      final date = DateTime(2026, 1, 17);

      controller.tasks.add(
        Task(
          key: 1,
          title: 'Task 1',
          isDone: false,
          isPriority: false,
          date: date,
        ),
      );

      // Act
      await tester.pumpWidget(createWidget());
      await tester.pump();

      await tester.tap(find.byType(InkWell).first);
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(TaskListByDatePage), findsOneWidget);
    },
  );

  testWidgets(
    'WHEN FAB is tapped THEN CustomBottomSheet should open',
    (tester) async {
      // Arrange
      controller.tasks.clear();

      // Act
      await tester.pumpWidget(createWidget());
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(CustomBottomSheet), findsOneWidget);
    },
  );

  testWidgets(
    'WHEN Add button pressed with empty title THEN error message should be shown',
    (tester) async {
      // Arrange
      await tester.pumpWidget(createWidget());

      // Act
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Add New Task'));
      await tester.pump();

      // Assert
      expect(find.text(taskEmptyErrorMessage), findsOneWidget);
    },
  );
}
