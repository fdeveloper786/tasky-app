import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasky/src/controller/task_controller.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:get/get.dart';
import 'package:tasky/app.dart';

class MockPathProviderPlatform extends PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async {
    final dir = Directory.systemTemp.createTempSync();
    return dir.path;
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

    Get.testMode = true;
    controller = TaskController();
    Get.put(controller);
  });

  tearDownAll(() async {
    await Hive.close();
    Get.reset();
  });

  testWidgets('WHEN app loads THEN MyApp should render', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('WHEN no tasks THEN noTask message shows', (tester) async {
    controller.tasks.clear();

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('No tasks found'), findsOneWidget);
  });
}
