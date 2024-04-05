import 'package:flutter_story_app/app/modules/map_story_module/map_story_controller.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class MapStoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MapStoryController());
  }
}
