import 'package:flutter/material.dart';
import 'package:tasky/src/utils/app_icon_type.dart';

class AppIcon extends StatelessWidget {
  final AppIconType type;
  final Color? color;
  final double size;

  const AppIcon({
    super.key,
    required this.type,
    this.color,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AppIconType.add:
        return Icon(Icons.add, color: color, size: size);

      case AppIconType.delete:
        return Icon(Icons.delete_outline, color: color, size: size);

      case AppIconType.star:
        return Icon(Icons.star, color: color ?? Colors.amber, size: size);

      case AppIconType.calendarToday:
        return Icon(Icons.calendar_today, color: color, size: size);

      case AppIconType.calendarMonth:
        return Icon(Icons.calendar_month, color: color, size: size);

      case AppIconType.checkbox:
        return Icon(Icons.check_box, color: color, size: size);

      case AppIconType.uncheck:
        return Icon(Icons.check_box_outline_blank, color: color, size: size);
    }
  }
}
