import 'package:flutter/material.dart';
import 'package:tasky/src/widgets/app_icon.dart';
import '../utils/app_actions.dart';
import '../utils/app_icon_type.dart';

class AppIconButton extends StatelessWidget {
  final AppActionType action;
  final VoidCallback onPressed;
  final Color? color;
  final double size;

  const AppIconButton({
    super.key,
    required this.action,
    required this.onPressed,
    this.color,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    switch (action) {
      case AppActionType.delete:
        return IconButton(
          icon: AppIcon(
            type: AppIconType.delete,
            color: color,
            size: size,
          ),
          onPressed: onPressed,
        );
      case AppActionType.add:
        return IconButton(
          icon: AppIcon(
            type: AppIconType.add,
            color: color,
            size: size,
          ),
          onPressed: onPressed,
        );

      case AppActionType.save:
        return IconButton(
          icon: AppIcon(
            type: AppIconType.star,
            color: color,
            size: size,
          ),
          onPressed: onPressed,
        );
    }
  }
}
