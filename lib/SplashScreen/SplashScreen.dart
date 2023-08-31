import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideausher/ScreenUI.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool align = false;
  bool _visible = false;
  Color imageColor = Get.isDarkMode ? Colors.white : Colors.black;
  String image =
      Get.isDarkMode ? 'assets/BoozinLogodark.png' : 'assets/BoozinText.png';
  @override
  void initState() {
    super.initState();
    checkPermission();
    initSetup().then((_) async {
      _startAnimation();
    });
  }

  checkPermission() async {
    var status = await Permission.activityRecognition.status;
    if (status.isDenied) {
      await Permission.activityRecognition.request();
      print("denied");
    }
    if (await Permission.location.isRestricted) {
      await Permission.location.request();
      print("restricted");
    }
  }

  Future<void> _startAnimation() async {
    setState(() => align = !align);
    await Future.delayed(const Duration(milliseconds: 100));
    setupComplete();
  }

  Future<void> initSetup() {
    return Future.delayed(const Duration(seconds: 2));
  }

  Future<void> setupComplete() async {
    setState(() => _visible = true);
    await Future.delayed(const Duration(seconds: 2));
    Get.to(HealthDataScreenUI());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      ConstrainedBox(
        constraints: BoxConstraints.tight(const Size(210, 85)),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // animate the pin logo on the screen
            AnimatedAlign(
                duration: const Duration(seconds: 1),
                alignment: align ? const Alignment(4.0, 0) : Alignment.center,
                child: Image.asset('assets/Boozin Logo.png')),

            if (align)
              AnimatedOpacity(
                  opacity: _visible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 1500),
                  child: Image.asset(image)),
          ],
        ),
      ),
      const SizedBox(height: 14),
      AnimatedOpacity(
        opacity: _visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 1500),
        child: const Text(
          "Fitness",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
    ])));
  }
}
