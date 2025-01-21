import 'package:belajarmobile/app/modules/dashboard/views/index_view.dart';
import 'package:belajarmobile/app/modules/dashboard/views/profile_view.dart';
import 'package:belajarmobile/app/modules/dashboard/views/your_event_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  //TODO: Implement DashboardController
  var SelectedIndex = 0.obs;

  void changeIndex(int index) {
    SelectedIndex.value = index;
  }

  final List<Widget> pages = [
    IndexView(),
    YourEventView(),
    ProfileView(),
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
