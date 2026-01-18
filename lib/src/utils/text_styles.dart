import 'package:flutter/material.dart';

const kTitleStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
);

const kTaskTitleStyle = TextStyle(
  fontSize: 16,
);

const kBold16Style = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

TextStyle taskTextStyle({
  required bool isDone,
  required bool isPriority,
}) {
  return TextStyle(
    decoration: isDone ? TextDecoration.lineThrough : null,
    fontWeight: isPriority ? FontWeight.bold : FontWeight.normal,
  );
}

const kTaskWhite16Style = TextStyle(fontSize: 16, color: Colors.white);

const kAppTitleStyle20 = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);
