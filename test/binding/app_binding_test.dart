import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasky/src/binding/appbinding.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:get/get.dart';
import 'package:tasky/src/controller/task_controller.dart';

class MockPathProviderPlatform extends PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async {
    final directory = Directory.systemTemp.createTempSync();
    return directory.path;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppBinding binding;

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
    binding = AppBinding();
  });

  group('AppBinding Test', () {
    test(
      'WHEN AppBinding.dependencies() is called THEN TaskController should be registered',
      () {
        // Arrange
        binding.dependencies();

        // Assert
        expect(Get.isRegistered<TaskController>(), true);
      },
    );
    test(
      'WHEN AppBinding.dependencies() is called THEN TaskController can be found and is a TaskController instance',
      () {
        // Arrange
        binding.dependencies();

        // Act
        final controller = Get.find<TaskController>();

        // Assert
        expect(controller, isA<TaskController>());
      },
    );
  });
}
