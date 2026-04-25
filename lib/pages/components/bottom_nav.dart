import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:moody_app/controllers/navbar_controller.dart';
import 'package:moody_app/utils/utility.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BottomNav extends StatelessWidget {
  BottomNav({Key? key}) : super(key: key);

  final navController = Get.find<NavbarController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 80,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x0A000000),
                  offset: const Offset(0, 2), //
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItems(PhosphorIcons.houseLine(), "Home", 0),
                SizedBox(width: 5),
                _buildNavItems(PhosphorIcons.calendar(), "Calendar", 1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItems(IconData icon, String label, int index) {
    return Obx(() {
      int selectedIndex = navController.selectedIndex.value;
      bool isSelected = selectedIndex == index;

      return GestureDetector(
        onTap: () {
          navController.changeNavbar(index);
          Utility().logger.d(selectedIndex);
          Utility().logger.d(isSelected);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFF2F2F2) : Colors.transparent,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 25,
                color: isSelected ? Colors.black : Colors.black54,
              ),
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
