import 'package:get/get.dart';
import 'package:tasky/src/controller/task_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TaskController(), permanent: true);
  }
}
