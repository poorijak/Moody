import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moody_app/utils/utility.dart';

class AddMoodController extends GetxController {
  RxString selectedMood =
      "Excited".obs; // ค่า default ถ้ายังไม่เคยเซฟ (ตัวพิมพ์ใหญ่ตาม model)
  RxBool isSavedToday = false.obs;
  RxString todayMood = "".obs;
  RxList<MapEntry<dynamic, dynamic>> moodsHistory =
      <MapEntry<dynamic, dynamic>>[].obs;

  RxList<Map<String, dynamic>> weeklyMoodsList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadTodayMood();
    loadWeeklyMoods();
  }

  void _loadTodayMood() {
    var box = Hive.box('moody_app');
    var todayDate = DateTime.now().toString().split(" ")[0];
    String? savedMood = box.get(todayDate);

    if (savedMood != null) {
      isSavedToday.value = true;
      todayMood.value = savedMood;
    }
  }

  String? getMoodForDate(DateTime date) {
    var box = Hive.box("moody_app");
    String dateKey = date.toString().split(" ")[0];

    return box.get(dateKey);
  }

  String getIconPath(String mood) {
    return "assets/images/icons/moods/${mood.toLowerCase()}_mood.svg";
  }

  void loadWeeklyMoods() {
    var box = Hive.box("moody_app");
    DateTime now = DateTime.now();

    String todayStr = now.toString().split(" ")[0];

    DateTime startOfWeek = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: now.weekday - 1));

    List<DateTime> daysInWeek = List.generate(7, (index) {
      return startOfWeek.add(Duration(days: index));
    });

    var weeklyMoods = daysInWeek.map((day) {
      String dateKey = day.toString().split(" ")[0];

      var value = box.get(dateKey);

      return {
        'date': day,
        'mood': value,
        "isToday": dateKey == todayStr ? true : false,
      };
    }).toList();

    weeklyMoodsList.assignAll(weeklyMoods);
    Utility().logger.d(
      weeklyMoods.map((e) => "${e['date']}: ${e['isToday']}").toList(),
    );
  }

  void saveMood() {
    var box = Hive.box('moody_app');
    var todayDate = DateTime.now().toString().split(" ")[0];

    box.put(todayDate, selectedMood.value);
    isSavedToday.value = true; // อัพเดตสถานะว่าเซฟแล้ว

    Get.back();
    Get.snackbar(
      "Saved",
      "อารมณ์ของวันที่ $todayDate ถูกบันทึกแล้ว",
      snackPosition: SnackPosition.TOP,
    );
  }
}
