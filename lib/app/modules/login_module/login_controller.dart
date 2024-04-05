import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_story_app/app/data/provider/pref.dart';
import 'package:get/get.dart';

import '../../data/provider/network.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  final _network = Network();
  final isLoading = false.obs;

  Future<bool> login() async {
    try {
      isLoading.value = true;
      final result = await _network.login(email, password);
      if (result.error == false) {
        await Pref.setToken(result.loginResult!.token.toString());
        isLoading.value = false;
        return true;
      }
      isLoading.value = false;
      return false;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      isLoading.value = false;
      return false;
    }
  }
}
