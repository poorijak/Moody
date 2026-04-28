import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moody_app/controllers/navbar_controller.dart';
import 'package:moody_app/pages/components/bottom_nav.dart';
import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:moody_app/pages/add_mood%20/add_mood_screen.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  const MainLayout({Key? key, required this.child}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final navController = Get.put(NavbarController());
  StreamSubscription? _accelerometerSub;
  static const double shakeThreshold =
      60.0; // ค่าความแรงในการเขย่า (ปรับเพิ่ม-ลดได้)

  @override
  void initState() {
    super.initState();

    // ตรวจจับการเขย่าด้วย sensors_plus (userAccelerometerEventStream จะตัดแรงโน้มถ่วงออกแล้ว)
    _accelerometerSub = userAccelerometerEventStream().listen((
      UserAccelerometerEvent event,
    ) {
      // คำนวณความแรงรวมจากทั้ง 3 แกน
      double acceleration = (event.x.abs() + event.y.abs() + event.z.abs());

      // ถ้าแรงเขย่ามากกว่าเกณฑ์ที่กำหนด
      if (acceleration > shakeThreshold) {
        _handleShake();
      }
    });
  }

  void _handleShake() {
    // ป้องกันการเปิดหน้าซ้อนกัน ถ้าย้ายไปหน้า addMood แล้วก็ไม่ต้องเปิดอีก
    if (Get.currentRoute != '/addMood') {
      Get.to(() => const AddMoodScreen());
    }
  }

  @override
  void dispose() {
    // หยุดรับค่าเซนเซอร์เมื่อปิดหน้านี้ เพื่อประหยัดแบตเตอรี่
    _accelerometerSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => navController.screens[navController.selectedIndex.value]),
      bottomNavigationBar: BottomNav(),
    );
  }
}
