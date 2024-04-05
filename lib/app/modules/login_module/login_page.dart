import 'package:flutter/material.dart';
import 'package:flutter_story_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter_story_app/app/modules/login_module/login_controller.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              // primary and secondary
              Theme.of(context).primaryColor,
              Colors.deepPurple
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            controller.email = value ?? "";
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            controller.password = value ?? "";
                          },
                        ),
                        const SizedBox(height: 16.0),
                        Obx(() {
                          if (controller.isLoading.value) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    if (controller.formKey.currentState
                                            ?.validate() ??
                                        false) {
                                      controller.formKey.currentState!.save();
                                      if (await controller.login()) {
                                        Get.rootDelegate.history.clear();
                                        Get.rootDelegate.toNamed(Routes.HOME);
                                      } else {
                                        Get.snackbar('Error Login!',
                                            'Make sure the data is valid!');
                                      }
                                    } else {
                                      Get.snackbar('Invalid Form!',
                                          'Make sure Email and Password are Not Empty!');
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                  ),
                                  child: const Text('Login'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.rootDelegate.toNamed(Routes.REGISTER);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.blueGrey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                  ),
                                  child: const Text('Register'),
                                ),
                              ],
                            );
                          }
                        })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
