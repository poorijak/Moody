import 'package:get/get.dart';
import 'package:moody_app/pages/calendar/calendar_screen.dart';
import 'package:moody_app/pages/home/home_screen.dart';

class NavbarController extends GetxController {
  RxInt selectedIndex = 0.obs;

  final screens = [const HomeScreen(), const CalendarScreen()];

  void changeNavbar(int newIndex) {
    selectedIndex.value = newIndex;
  }
}
