import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moody_app/main_layout.dart';
import 'package:moody_app/pages/add_mood%20/add_mood_screen.dart';
import 'package:moody_app/pages/home/home_screen.dart';
import 'package:moody_app/pages/onboardings_screen/onboarding_screen.dart';
import 'package:moody_app/themes/styles.dart';
import 'package:moody_app/utils/utility.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('moody_app');
  await Utility.initSharedPrefs();
  bool isOnboarded = Utility.getSharedPreference("onBoardingStatus") ?? false;

  // ส่งค่าไปที่ MyApp
  runApp(MyApp(startRoute: isOnboarded ? "/home" : "/onboarding"));
}

class MyApp extends StatelessWidget {
  final String startRoute;
  const MyApp({Key? key, required this.startRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: startRoute,
      getPages: [
        GetPage(
          name: "/home",
          page: () => MainLayout(child: HomeScreen()),
        ),
        GetPage(name: "/onboarding", page: () => OnboardingScreen()),
        GetPage(name: "/addMood", page: () => AddMoodScreen()),
      ],
    );
  }
}
