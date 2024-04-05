import 'package:flutter_story_app/app/modules/add_story_module/add_story_controller.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class AddStoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddStoryController());
  }
}
