import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_story_app/app/data/provider/network.dart';
import 'package:flutter_story_app/app/data/response/story.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class HomeController extends GetxController {
  RxList<Story> listStory = <Story>[].obs;
  final network = Network();
  final isLoading = false.obs;
  final isError = false.obs;
  int? _pageItems = 1;
  final int _sizeItems = 20;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    super.onInit();
    fetchList();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        fetchList();
      }
    });
  }

  void fetchList() async {
    try {
      if (_pageItems == 1) {
        isLoading.value = true;
      }

      // if(_pageItems!=null && _pageItems! >= 1) {
      //   await Future.delayed(Duration(seconds: 2));
      //   final List<Story> listsStory = [];
      //   for (var i = 0; i < _sizeItems; i++) {
      //     listsStory.add(Story(name: 'story $i', id: i.toString(), description: "asfmaseaes"));
      //   }
      //
      //   listStory.addAll(listsStory);
      //   _pageItems = _pageItems! + 1;
      //   isError.value = false;
      //   isLoading.value = false;
      // }

      final result =
          await network.getAllStories(page: _pageItems, size: _sizeItems);
      if (result.error == false) {
        listStory.addAll(result.listStory!);
        _pageItems = _pageItems! + 1;
        isError.value = false;
        isLoading.value = false;
      } else {
        _setError();
      }
    } catch (e) {
      _setError();
      isLoading.value = false;
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  _setError() {
    if (listStory.isEmpty) {
      isError.value = true;
    }
  }

  void fetchNewList() {
    _pageItems = 1;
    listStory.clear();
    fetchList();
  }
}
