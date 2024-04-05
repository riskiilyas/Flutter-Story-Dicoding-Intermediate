import 'package:flutter_story_app/app/data/provider/pref.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class SplashController extends GetxController {
  Future<bool> checkLoggedIn() async => await Pref.getToken() != null;
}
