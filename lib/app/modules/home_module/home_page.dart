import 'package:flutter/material.dart';
import 'package:flutter_story_app/app/data/provider/pref.dart';
import 'package:flutter_story_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter_story_app/app/modules/home_module/home_controller.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isNew = ModalRoute.of(context)!.settings.arguments as bool? ?? false;
    if(isNew){
      controller.fetchNewList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Story App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await Pref.clear();
              Get.rootDelegate.history.clear();
              Get.rootDelegate.toNamed(Routes.SPLASH);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.rootDelegate.toNamed(Routes.ADD_STORY);
        },
        child: const Icon(Icons.add),
      ),
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
                    controller.fetchList();
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
        }

        final listStory = controller.listStory;
        return ListView.builder(
          controller: controller.scrollController,
          itemCount: listStory.length + 1,
          itemBuilder: (context, index) {
            if (index == listStory.length) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return InkWell(
              onTap: () {
                Get.rootDelegate.toNamed(Routes.DETAIL_STORY,
                    arguments: listStory[index].id.toString());
              },
              child: ListTile(
                leading: Image.network(listStory[index].photoUrl.toString(),
                    width: 80, height: 80, fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                }),
                title: Text(listStory[index].name.toString()),
                subtitle: Text(
                  listStory[index].description.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
