import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_story_app/app/modules/register_module/register_controller.dart';

import '../../routes/app_pages.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

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
                          'Register',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Please enter your Name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            controller.name = value ?? "";
                          },
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
                            if (value != null) {
                              controller.email = value;
                            }
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
                            if (value != null) {
                              controller.password = value;
                            }
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
                                      if (await controller.register()) {
                                        Get.snackbar('Sucessfully Registered!',
                                            'Please Login to Continue');
                                        Get.rootDelegate.history.clear();
                                        Get.rootDelegate.toNamed(Routes.LOGIN);
                                      } else {
                                        Get.snackbar('Error Register!',
                                            'Make sure the data is valid!');
                                      }
                                    } else {
                                      Get.snackbar('Invalid Form!',
                                          'Make sure Name, Email and Password are Not Empty!');
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
                                  child: const Text('Register'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.rootDelegate.toNamed(Routes.LOGIN);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.blueGrey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                  ),
                                  child: const Text('Login'),
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
