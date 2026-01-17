import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasky/src/controller/task_controller.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('tasks');
  await Hive.openBox('meta');
  Get.put(TaskController(), permanent: true);
  runApp(const MyApp());
}
