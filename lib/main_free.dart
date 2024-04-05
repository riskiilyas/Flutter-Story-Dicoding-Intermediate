import 'package:flutter/material.dart';
import 'package:flutter_story_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

import 'app/utils/flavor_config.dart';

void main() {
  FlavorConfig(
    flavor: FlavorType.free,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      title: 'Story App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      getPages: AppPages.pages,
    );
  }
}
