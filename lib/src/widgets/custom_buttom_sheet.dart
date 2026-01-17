import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasky/src/controller/task_controller.dart';
import 'package:tasky/src/utils/app_actions.dart';
import 'package:tasky/src/widgets/app_elevated_button.dart';
import 'package:tasky/src/widgets/custom_text.dart';
import '../utils/strings.dart';
import 'custom_text_field.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  final controller = Get.find<TaskController>();
  final titleController = TextEditingController();

  bool isPriority = false;
  DateTime selectedDate = DateTime.now();
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            controller: titleController,
            hint: taskTitleHint,
            errorText: errorText,
          ),

          const SizedBox(height: 10),

          /// ⭐ Priority
          CheckboxListTile(
            value: isPriority,
            onChanged: (v) {
              setState(() => isPriority = v ?? false);
            },
            title: const CustomText(
              text: setPriority,
            ),
          ),

          /// 📅 Date Picker
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: CustomText(
              text:
                  "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}",
            ),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
                initialDate: selectedDate,
              );

              if (picked != null) {
                setState(() => selectedDate = picked);
              }
            },
          ),

          const SizedBox(height: 10),
          AppElevatedButton(
            action: AppActionType.add,
            onPressed: () async {
              if (titleController.text.trim().isEmpty) {
                setState(() {
                  errorText = taskEmptyErrorMessage;
                });
                return;
              }
              setState(() => errorText = null);

              await controller.addTask(
                titleController.text,
                isPriority,
                selectedDate,
              );
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
