import 'package:flutter/material.dart';
import 'package:flutter_story_app/app/data/response/detail_story.dart';
import 'package:get/get.dart';
import 'package:flutter_story_app/app/modules/map_story_module/map_story_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class MapStoryPage extends GetView<MapStoryController> {
  const MapStoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final detail = ModalRoute.of(context)!.settings.arguments as DetailStory;
    // print("DTTTTT: ${detail.name}");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getArgs(detail);
    });
    return Scaffold(
      body: Center(
        child: Obx(() {
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              zoom: 12,
              target: controller.position.value ?? controller.dicodingOffice,
            ),
            markers: controller.markers,
            onMapCreated: (mapController) {
              controller.mapController = mapController;
              if (controller.position.value != null) {
                mapController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: controller.position.value!,
                      zoom: 18,
                    ),
                  ),
                );
              }
            },
          );
        }),
      ),
    );
  }
}
