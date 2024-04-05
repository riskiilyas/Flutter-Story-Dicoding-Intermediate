import 'package:flutter/material.dart';
import 'package:flutter_story_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter_story_app/app/modules/splash_module/splash_controller.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  _init() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final result = await controller.checkLoggedIn();

      Future.delayed(const Duration(seconds: 3), () {
        if (result) {
          Get.rootDelegate.history.removeLast();
          Get.rootDelegate.toNamed(Routes.HOME);
        } else {
          Get.rootDelegate.history.removeLast();
          Get.rootDelegate.toNamed(Routes.LOGIN);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _init();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash.png', // Replace with your image asset path
              width: 250,
              height: 250,
            ),
            const SizedBox(height: 20),
            const Text(
              'Story App', // Replace with your app title
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
