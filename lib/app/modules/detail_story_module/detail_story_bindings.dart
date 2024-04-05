import 'package:flutter_story_app/app/modules/detail_story_module/detail_story_controller.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class DetailStoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailStoryController());
  }
}
