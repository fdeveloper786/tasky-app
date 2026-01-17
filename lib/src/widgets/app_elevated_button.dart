import 'package:flutter/material.dart';
import 'package:tasky/src/widgets/custom_text.dart';
import '../utils/app_actions.dart';
import '../utils/strings.dart';

class AppElevatedButton extends StatelessWidget {
  final AppActionType action;
  final VoidCallback onPressed;

  const AppElevatedButton({
    super.key,
    required this.action,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    switch (action) {
      case AppActionType.add:
        return ElevatedButton(
          onPressed: onPressed,
          child: const CustomText(text: addNewTask),
        );

      case AppActionType.save:
        return ElevatedButton(
          onPressed: onPressed,
          child: const CustomText(text: save),
        );

      case AppActionType.delete:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          onPressed: onPressed,
          child: const CustomText(text: delete),
        );
    }
  }
}
