import 'package:flutter/material.dart';
import 'package:flutter_story_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter_story_app/app/modules/detail_story_module/detail_story_controller.dart';
import 'package:intl/intl.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class DetailStoryPage extends GetView<DetailStoryController> {
  const DetailStoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    // print("IDDDDD: $id");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchDetail(id);
    });
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.isError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.error, color: Colors.red),
                const SizedBox(height: 8),
                Text(controller.isError.value.toString()),
                ElevatedButton(
                  onPressed: () {
                    controller.fetchDetail(id);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  child: const Text('Refresh'),
                ),
              ],
            ),
          );
        } else if (controller.story.value == null) {
          return const SizedBox();
        }
        final story = controller.story.value!;

        return Scaffold(
            body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(story.photoUrl ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          story.name ?? '',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DateFormat('MMMM dd, yyyy').format(
                        DateTime.parse(story.createdAt ?? ''),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          story.description ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Obx(() {
                      final story = controller.story.value;
                      if (story == null ||
                          story.lat == null ||
                          story.lon == null) {
                        return const SizedBox();
                      }
                      return ElevatedButton(
                        onPressed: () {
                          Get.rootDelegate
                              .toNamed(Routes.MAP_STORY, arguments: story);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('View in Maps'),
                            SizedBox(width: 8),
                            Icon(Icons.map),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ));
      }),
    );
  }
}
