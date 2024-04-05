import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../data/provider/network.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  String email = '';
  String name = '';
  String password = '';
  final _network = Network();
  final isLoading = false.obs;

  Future<bool> register() async {
    try {
      isLoading.value = true;
      final result = await _network.register(name, email, password);
      if (result.error == false) {
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
