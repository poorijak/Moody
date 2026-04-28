import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddMoodController extends GetxController {
  RxString selectedMood =
      "Excited".obs; // ค่า default ถ้ายังไม่เคยเซฟ (ตัวพิมพ์ใหญ่ตาม model)
  RxBool isSavedToday = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadTodayMood();
  }

  String? _loadTodayMood() {
    var box = Hive.box('moody_app');
    var todayDate = DateTime.now().toString().split(" ")[0];
    String? savedMood = box.get(todayDate);

    if (savedMood != null) {
      selectedMood.value = savedMood;
      isSavedToday.value = true;
    }

    return savedMood;
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
