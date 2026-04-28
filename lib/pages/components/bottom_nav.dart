import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:moody_app/controllers/navbar_controller.dart';
import 'package:moody_app/pages/add_mood%20/add_mood_screen.dart';
import 'package:moody_app/utils/utility.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BottomNav extends StatelessWidget {
  BottomNav({Key? key}) : super(key: key);

  final navController = Get.find<NavbarController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x0A000000),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildNavItems("Home", 0),
                  const SizedBox(width: 5),
                  _buildNavItems("Calendar", 1),
                ],
              ),
            ),
            const SizedBox(width: 30),
            _buildAddMood(),
          ],
        ),
      ),
    );
  }

  Widget _buildAddMood() {
    return GestureDetector(
      onTap: () {
        Get.to(const AddMoodScreen());
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() {
            String currentIconPath =
                navController.moodIcons[navController.currentIconIndex.value];

            return AnimatedSwitcher(
              switchInCurve: Curves.easeIn, // เพิ่ม Curve เพื่อความสวยงาม
              switchOutCurve: Curves.easeOut, // เพิ่ม Curve เพื่อความสวยงาม
              duration: Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: SvgPicture.asset(
                currentIconPath,
                key: ValueKey<String>(currentIconPath),
                height: 40,
              ),
            );
          }),
          const SizedBox(height: 10),
          const Text(
            "Add Mood",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItems(String label, int index) {
    return Obx(() {
      int selectedIndex = navController.selectedIndex.value;
      bool isSelected = selectedIndex == index;

      IconData displayIcon;

      if (index == 0) {
        displayIcon = isSelected
            ? PhosphorIcons.houseLine(PhosphorIconsStyle.fill)
            : PhosphorIcons.houseLine();
      } else {
        displayIcon = isSelected
            ? PhosphorIcons.calendarBlank(PhosphorIconsStyle.fill)
            : PhosphorIcons.calendarBlank();
      }

      return GestureDetector(
        onTap: () {
          // แค่เปลี่ยนค่าใน controller หน้าก็จะเปลี่ยนเองที่ MainLayout ครับ
          navController.changeNavbar(index);
          Utility().logger.d("Selected: $index");
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFF2F2F2) : Colors.transparent,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                displayIcon,
                size: 25,
                color: isSelected ? Colors.black : Colors.black54,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? Colors.black : Colors.black54,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
