import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rayhan_test/routes/app_routes.dart';

import '../controllers/storage_controller.dart';

class OnBoardingController extends GetxController {
  PageController pageController = PageController();
  RxInt currentIndex = 0.obs;

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  void nextPage() {
    if (currentIndex.value < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      finish();
    }
  }

  void skip() {
    finish();
  }

  void finish() {
    StorageController.storeStartApp();
    // هنا يمكنك تحويل المستخدم إلى صفحة تسجيل الدخول أو الرئيسية
    // Get.offNamed('/login');
    Get.offNamed(AppRoutes.home);
  }
}
