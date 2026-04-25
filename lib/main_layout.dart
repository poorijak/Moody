import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:moody_app/controllers/navbar_controller.dart';
import 'package:moody_app/pages/components/bottom_nav.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  final navController = Get.put(NavbarController());

  MainLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => navController.screens[navController.selectedIndex.value]),
      bottomNavigationBar: BottomNav(),
    );
  }
}
