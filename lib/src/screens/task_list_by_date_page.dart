import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasky/src/controller/task_controller.dart';
import 'package:tasky/src/utils/app_actions.dart';
import 'package:tasky/src/utils/app_icon_type.dart';
import 'package:tasky/src/utils/text_styles.dart';
import 'package:tasky/src/widgets/app_icon.dart';
import 'package:tasky/src/widgets/app_icon_button.dart';
import 'package:tasky/src/widgets/custom_text.dart';

class TaskListByDatePage extends StatelessWidget {
  final DateTime date;
  TaskListByDatePage({super.key, required this.date});

  final TaskController controller = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final tasks = controller.tasks
          .where((t) =>
              t.date.year == date.year &&
              t.date.month == date.month &&
              t.date.day == date.day)
          .toList();

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: CustomText(
            text: "${date.day}-${date.month}-${date.year}",
            textStyle: kAppTitleStyle20,
          ),
        ),
        body: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (_, index) {
            final task = tasks[index];
            return ListTile(
              leading: Checkbox(
                  value: task.isDone,
                  onChanged: (v) => controller.toggleDone(task)),
              title: CustomText(
                text: task.title,
                textStyle: taskTextStyle(
                  isDone: task.isDone,
                  isPriority: task.isPriority,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (task.isPriority) const AppIcon(type: AppIconType.star),
                  AppIconButton(
                      action: AppActionType.delete,
                      onPressed: () => controller.deleteTask(task)),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
