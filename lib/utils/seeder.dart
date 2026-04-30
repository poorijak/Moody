import 'dart:math';
import 'package:hive_flutter/hive_flutter.dart';

class HiveSeeder {
  static Future<void> seedMockData() async {
    var box = Hive.box('moody_app');

    DateTime now = DateTime.now();
    // 1. หาวันแรกของเดือนนี้
    DateTime startOfMonth = DateTime(now.year, now.month, 1);

    // 2. หาวันจันทร์ของสัปดาห์นี้
    // now.weekday (1 = Monday, 7 = Sunday)

    List<String> moods = [
      "Excited",
      "Sensitive",
      "Boring",
      "Insecure",
      "Confuse",
      "Angry",
    ];
    Random random = Random();

    DateTime currentDate = startOfMonth;

    // 3. วนลูปตั้งแต่วันแรกของเดือน จนถึงวันก่อนหน้าสัปดาห์นี้
    while (currentDate.isBefore(now)) {
      String dateString = currentDate.toString().split(" ")[0];

      // เช็คว่าวันนี้มีข้อมูลอยู่แล้วหรือยัง ถ้ายังให้ mock ใส่ลงไป
      if (!box.containsKey(dateString)) {
        String randomMood = moods[random.nextInt(moods.length)];
        await box.put(dateString, randomMood);
      }

      // ขยับไปวันถัดไปทีละ 1 วัน
      currentDate = currentDate.add(const Duration(days: 1));
    }

    print("✅ [HiveSeeder] Mock data seeded successfully.");
  }
}
