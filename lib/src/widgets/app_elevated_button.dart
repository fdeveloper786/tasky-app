import 'package:flutter/material.dart';
import 'package:tasky/src/widgets/custom_text.dart';
import '../utils/app_actions.dart';
import '../utils/strings.dart';
import 'package:tasky/src/utils/text_styles.dart';

class AppElevatedButton extends StatelessWidget {
  final AppActionType action;
  final VoidCallback onPressed;

  const AppElevatedButton({
    super.key,
    required this.action,
    required this.onPressed,
  });

  ButtonStyle _buttonStyle(Color bgColor) {
    return ElevatedButton.styleFrom(
      backgroundColor: bgColor,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      textStyle: const TextStyle(color: Colors.white, fontSize: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (action) {
      case AppActionType.add:
        return ElevatedButton(
          style: _buttonStyle(const Color(0xFF6A5AE0)),
          onPressed: onPressed,
          child: const CustomText(
            text: addNewTask,
            textStyle: kTaskWhite16Style,
          ),
        );

      case AppActionType.save:
        return ElevatedButton(
          style: _buttonStyle(const Color(0xFF4CAF50)),
          onPressed: onPressed,
          child: const CustomText(
            text: save,
            textStyle: kTaskWhite16Style,
          ),
        );

      case AppActionType.delete:
        return ElevatedButton(
          style: _buttonStyle(Colors.red),
          onPressed: onPressed,
          child: const CustomText(
            text: delete,
            textStyle: kTaskWhite16Style,
          ),
        );
    }
  }
}
