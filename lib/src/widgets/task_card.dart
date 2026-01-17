import 'package:flutter/material.dart';
import 'package:tasky/src/utils/strings.dart';
import 'package:tasky/src/widgets/custom_text.dart';
import '../utils/text_styles.dart';
import '../utils/date_utils.dart';

class TaskCard extends StatelessWidget {
  final DateTime date;
  final int count;
  final VoidCallback onTap;

  const TaskCard({
    super.key,
    required this.date,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: formatDate(date),
                textStyle: kTitleStyle,
              ),
              const SizedBox(height: 8),
              CustomText(text: taskLength(count).toLowerCase()),
            ],
          ),
        ),
      ),
    );
  }
}
