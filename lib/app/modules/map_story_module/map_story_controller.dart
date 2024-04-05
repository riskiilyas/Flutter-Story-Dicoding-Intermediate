import 'package:flutter_story_app/app/data/provider/network.dart';
import 'package:flutter_story_app/app/data/response/detail_story.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class MapStoryController extends GetxController {
  late GoogleMapController mapController;
  final Set<Marker> markers = {};
  final network = Network();
  final Rx<LatLng?> position = Rx(null);
  final dicodingOffice = const LatLng(-6.8957473, 107.6337669);

  // @override
  // void onReady() {
  //   super.onReady();
  //   getArgs();
  // }

  Future<void> getArgs(DetailStory story) async {
    // DetailStory story = Get.arguments;
    // print(story);
    final lat = story.lat!;
    final lon = story.lon!;
    final latlon = LatLng(lat, lon);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latlon.latitude, latlon.longitude);

    Placemark place = placemarks[0];
    String address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    InfoWindow infoWindow = InfoWindow(title: story.name, snippet: address);

    final marker = Marker(
      markerId: MarkerId(story.name.toString()),
      infoWindow: infoWindow,
      position: latlon,
      onTap: () {
        mapController.animateCamera(
          CameraUpdate.newLatLngZoom(latlon, 18),
        );
      },
    );
    markers.add(marker);
    position.value = latlon;
  }
}
