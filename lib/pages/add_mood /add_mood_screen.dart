import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:moody_app/controllers/add_mood_controller.dart';
import 'package:moody_app/models/add_mood_model.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AddMoodScreen extends StatelessWidget {
  const AddMoodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddMoodController());

    return Scaffold(
      body: Obx(() {
        BackgroundData currentMood = backgroundMood.firstWhere(
          (mood) => mood.mood == controller.selectedMood.value,
          orElse: () => backgroundMood.first,
        );

        return AnimatedContainer(
          duration: Duration(milliseconds: 500),
          color: currentMood.bgColor,
          child: SafeArea(
            bottom: false, // ปิดขอบล่างเพื่อให้รูปภาพลงไปสุดขอบจอ
            child: Stack(
              children: [
                Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Image.asset(
                    currentMood.svgPath,
                    fit: BoxFit
                        .cover, // แนะนำใช้ cover หรือ fitWidth เพื่อไม่ให้ภาพล้น
                    alignment: Alignment.topCenter,
                  ),
                ),

                SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        _buildAppBar(),
                        const SizedBox(height: 380),

                        Text(
                          DateFormat(
                            'dd MMM yyyy HH:mm',
                          ).format(DateTime.now()),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 30),

                        const Text(
                          "How Are You Feeling\nRight Now?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 35),
                        _buildMoodChips(controller),
                        const SizedBox(height: 29),
                        _buildSaveMoodButton(controller),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(PhosphorIcons.caretLeft()),
            SizedBox(width: 5),
            Text("Back"),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodChips(AddMoodController controller) {
    final moods = [
      "Excited",
      "Sensitive",
      "Boring",
      "Insecure",
      "Confuse",
      "Angry",
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Wrap(
        spacing: 12, // ระยะห่างแนวนอน
        runSpacing: 12, // ระยะห่างแนวตั้ง
        alignment: WrapAlignment.center,
        children: moods.map((mood) {
          return Obx(() {
            bool isSelected = controller.selectedMood.value == mood;
            bool isSaved = controller.isSavedToday.value;

            return GestureDetector(
              // ถ้าเซฟแล้วให้กดเปลี่ยนไม่ได้
              onTap: isSaved ? null : () => controller.selectedMood.value = mood,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFFFC107)
                      : const Color.fromARGB(17, 0, 0, 0),
                  borderRadius: BorderRadius.circular(30),
                  // ทำให้ดูจางลงถ้าเซฟแล้วและไม่ได้ถูกเลือก
                  border: Border.all(
                    color: isSaved && !isSelected ? Colors.transparent : Colors.transparent,
                  ),
                ),
                child: Text(
                  mood,
                  style: TextStyle(
                    fontSize: 16,
                    color: isSelected ? Colors.black : (isSaved ? Colors.white54 : Colors.white),
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            );
          });
        }).toList(),
      ),
    );
  }

  Widget _buildSaveMoodButton(AddMoodController controller) {
    bool isSaved = controller.isSavedToday.value;

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: ElevatedButton(
          // ถ้าเซฟแล้วให้ปุ่มเป็น null (Disable)
          onPressed: isSaved ? null : () {
            controller.saveMood();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isSaved ? Colors.white54 : Colors.white,
            disabledBackgroundColor: Colors.white54, // สีตอนโดน Disable
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(80),
            ),
            shadowColor: Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isSaved ? "Already Saved Today" : "Save Today Mood",
                style: TextStyle(
                  color: isSaved ? Colors.black54 : Colors.black, 
                  fontSize: 16,
                  fontWeight: isSaved ? FontWeight.normal : FontWeight.w600,
                ),
              ),
              if (!isSaved) ...[
                SizedBox(width: 10),
                Icon(PhosphorIcons.arrowRight(), color: Colors.black, size: 20),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
