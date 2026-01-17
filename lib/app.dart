import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasky/src/binding/appbinding.dart';
import 'package:tasky/src/screens/homepage.dart';
import 'package:tasky/src/utils/strings.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      title: appName,
      home: const HomePage(),
    );
  }
}
