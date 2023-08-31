import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideausher/SplashScreen/SplashScreen.dart';
import 'package:ideausher/ThemeControl/themecontroller.dart';

void main() {
  runApp(const HealthApp());
  Get.put(ThemeController());
}

class HealthApp extends StatelessWidget {
  const HealthApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SplashScreen(), // Use HealthDataScreenUI directly
      darkTheme: ThemeData.dark(), // Set your default dark theme here
      themeMode: ThemeMode.system,
    );
  }
}
