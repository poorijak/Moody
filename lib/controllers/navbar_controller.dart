import 'dart:async';

import 'package:get/get.dart';
import 'package:moody_app/pages/calendar/calendar_screen.dart';
import 'package:moody_app/pages/home/home_screen.dart';

class NavbarController extends GetxController {
  RxInt selectedIndex = 0.obs;

  final screens = [const HomeScreen(), const CalendarScreen()];

  RxInt currentIconIndex = 0.obs;
  Timer? _timer;

  final List<String> moodIcons = [
    "assets/images/icons/moods/excited_mood.svg",
    "assets/images/icons/moods/angry_mood.svg",
    "assets/images/icons/moods/confuse_mood.svg",
    "assets/images/icons/moods/boring_mood.svg",
    "assets/images/icons/moods/insecure_mood.svg",
    "assets/images/icons/moods/sensitive_mood.svg",
  ];

  @override
  void onInit() {
    super.onInit();
    startIconLoop();
  }

  void startIconLoop() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (currentIconIndex < moodIcons.length - 1) {
        currentIconIndex++;
      } else {
        currentIconIndex.value = 0;
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel(); // ล้าง timer เมื่อ controller ถูกทำลาย
    super.onClose();
  }

  void changeNavbar(int newIndex) {
    selectedIndex.value = newIndex;
  }
}
