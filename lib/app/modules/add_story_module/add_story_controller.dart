import 'package:flutter/foundation.dart';
import 'package:flutter_story_app/app/data/provider/media_service.dart';
import 'package:flutter_story_app/app/data/provider/network.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class AddStoryController extends GetxController {
  final Rx<XFile?> imageFile = Rx(null);
  String description = '';
  final network = Network();
  final Rx<LatLng?> myLocation = Rx(null);

  Future<bool> addStory() async {
    try {
      if (imageFile.value != null) {
        final image = imageFile.value!;
        final bytes = await image.readAsBytes();
        final shrinkImage = await MediaService.compressImage(bytes);
        final lat = myLocation.value?.latitude;
        final lon = myLocation.value?.longitude;
        final result = await network.uploadStory(
            shrinkImage as List<int>, image.name, description, lat, lon);
        return result.error == false;
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }
}
