import 'package:flutter/foundation.dart';
import 'package:flutter_story_app/app/data/provider/network.dart';
import 'package:flutter_story_app/app/data/response/detail_story.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class DetailStoryController extends GetxController {
  final Rx<DetailStory?> story = Rx(null);
  final isLoading = false.obs;

  // final isPagingLoading = false.obs;
  final isError = false.obs;
  final network = Network();

  // String _id = '';

  // @override
  // void onReady() {
  //   super.onReady();
  //   // _id = ModalRoute.of(context)!.settings.arguments as String;
  //   // _id = Get.rootDelegate.arguments.toString();
  //   // fetchDetail();
  // }

  fetchDetail(String id) async {
    try {
      isLoading.value = true;

      final result = await network.getStoryDetail(id.toString());
      if (result.error == false) {
        story.value = result.story;
        isError.value = false;
      } else {
        isError.value = true;
      }
      isLoading.value = false;
    } catch (e) {
      isError.value = true;
      isLoading.value = false;
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
