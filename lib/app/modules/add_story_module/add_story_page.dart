import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_story_app/app/utils/flavor_config.dart';
import 'package:get/get.dart';
import 'package:flutter_story_app/app/modules/add_story_module/add_story_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

import '../../data/provider/media_service.dart';
import '../../routes/app_pages.dart';
import 'dialog/location_picker_dialog.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class AddStoryPage extends GetView<AddStoryController> {
  const AddStoryPage({super.key});

  Future<void> _pickImage(ImageSource source) async {
    final file = await MediaService.pickImage(source);
    if (file != null) {
      controller.imageFile.value = file;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Story'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(() {
                return controller.imageFile.value == null
                    ? Container(
                        height: 200,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Text('No image selected'),
                        ),
                      )
                    : FutureBuilder(
                        future: controller.imageFile.value?.readAsBytes(),
                        builder: (context, data) {
                          return data.data != null
                              ? Image.memory(
                                  data.data!,
                                  height: 200,
                                  fit: BoxFit.fill,
                                )
                              : const SizedBox();
                        });
              }),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      _pickImage(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Camera'),
                  ),
                  const SizedBox(width: 16.0),
                  ElevatedButton.icon(
                    onPressed: () {
                      _pickImage(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Gallery'),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Obx(() {
                if (controller.myLocation.value == null) {
                  return const SizedBox();
                }
                return Row(
                  children: [
                    Expanded(
                        child: Text(controller.myLocation.value.toString())),
                    IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          controller.myLocation.value = null;
                        })
                  ],
                );
              }),
              const SizedBox(height: 8.0),
              if (FlavorConfig.instance.flavor == FlavorType.paid)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  onPressed: () async {
                    await getMyLocation();
                    if (!context.mounted) return;
                    LatLng? pickedLocation = await showDialog(
                      context: context,
                      builder: (context) => LocationPickerDialog(
                        initialPosition: controller.myLocation.value,
                      ),
                    );

                    if (pickedLocation != null) {
                      if (kDebugMode) {
                        print(
                            'Picked location: ${pickedLocation.latitude}, ${pickedLocation.longitude}');
                      }

                      controller.myLocation.value = pickedLocation;
                    } else {
                      controller.myLocation.value = null;
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Choose Location'),
                      SizedBox(width: 8.0),
                      Icon(Icons.location_on),
                    ],
                  ),
                ),
              const SizedBox(height: 16.0),
              TextField(
                maxLines: 10,
                decoration: const InputDecoration(
                  hintText: 'Enter description',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  controller.description = value;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                onPressed: () async {
                  if (controller.imageFile.value == null ||
                      controller.description.isEmpty) {
                    Get.snackbar(
                        'Empty Data!', 'Please fill in the form and image!');
                  }

                  if (await controller.addStory()) {
                    Get.snackbar(
                        'Upload Success!', 'Your story has been uploaded!');
                    Get.rootDelegate.history.clear();
                    Get.rootDelegate.toNamed(Routes.HOME, arguments: true);
                  } else {
                    Get.snackbar('Error!', 'Make sure the form is valid!');
                  }
                },
                child: const Text('Upload'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getMyLocation() async {
    final Location location = Location();
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;
    late LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        if (kDebugMode) {
          print("Location services is not available");
        }
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        if (kDebugMode) {
          print("Location permission is denied");
        }
        return;
      }
    }

    locationData = await location.getLocation();
    controller.myLocation.value =
        LatLng(locationData.latitude!, locationData.longitude!);
  }
}
