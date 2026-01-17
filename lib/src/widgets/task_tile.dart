import 'package:flutter/material.dart';
import 'package:tasky/src/model/task_model.dart';
import 'package:tasky/src/utils/app_actions.dart';
import 'package:tasky/src/utils/text_styles.dart';
import 'package:tasky/src/widgets/app_icon_button.dart';
import 'package:tasky/src/widgets/custom_text.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onDelete;
  final ValueChanged<bool?> onChanged;

  const TaskTile({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.isDone,
        onChanged: onChanged,
      ),
      title: CustomText(
        text: task.title,
        textStyle: taskTextStyle(
          isDone: task.isDone,
          isPriority: task.isPriority,
        ),
      ),
      trailing: AppIconButton(
          action: AppActionType.delete, onPressed: () => onDelete),
    );
  }
}
