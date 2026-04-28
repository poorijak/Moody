import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moody_app/pages/home/home_screen.dart';
import 'package:moody_app/utils/utility.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  final PageController pageController = PageController();

  void onEnd() async {
    await Utility.setSharedPreference("onBoardingStatus", true);
    Get.offAll(HomeScreen());
  }

  void nextPage(int length) {
    if (currentPage.value < length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      onEnd();
    }
  }

  void skip(int length) {
    onEnd();
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
