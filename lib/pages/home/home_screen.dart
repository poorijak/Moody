import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moody_app/controllers/add_mood_controller.dart';
import 'package:moody_app/themes/colors.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final controller = Get.put(AddMoodController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHomeHeader(),
                const Divider(
                  color: Color(0xFFE5E5E5),
                  thickness: 1,
                  height: 40, // ช่องว่างระหว่าง Widget บน-ล่าง รวมตัวเส้นด้วย
                  indent: 0, // ระยะร่นจากซ้าย
                  endIndent: 0, // ระยะร่นจากขวา
                ),
                _buildTodayMood(),
                _buildMoodOfWeek(),
                _buildTips(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHomeHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello,",
              style: TextStyle(
                fontFamily: "Advercase",
                fontSize: 24,
                color: mutedforeground,
              ),
            ),
            Text(
              "Mooder,",
              style: TextStyle(fontSize: 47, fontWeight: FontWeight.bold),
            ),
          ],
        ),

        SvgPicture.asset("assets/images/icons/eye.svg"),
      ],
    );
  }

  Widget _buildTodayMood() {
    return Obx(() {
      var todayMood = controller.todayMood.value;

      // ถ้ายังไม่มีอารมณ์วันนี้ (todayMood ว่างเปล่า) ให้ซ่อน Widget นี้ไปเลย
      if (todayMood.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Mood in day",
            style: TextStyle(fontSize: 16, color: mutedforeground),
          ),
          SizedBox(height: 15),
          SizedBox(
            child: Container(
              height: 106,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(23),
                border: Border.all(color: border),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(16, 0, 25, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 79,
                        width: 79,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(104, 234, 234, 234),
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: Center(
                            child: todayMood.isNotEmpty
                                ? SvgPicture.asset(
                                    "assets/images/icons/moods/${todayMood.toLowerCase()}_mood.svg",
                                    width: 59,
                                    height: 59,
                                  )
                                : Icon(
                                    Icons.sentiment_satisfied_alt,
                                    color: const Color.fromARGB(
                                      255,
                                      23,
                                      23,
                                      23,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(width: 18),
                      Text(todayMood, style: TextStyle(fontSize: 15)),
                    ],
                  ),
                  Text(
                    DateFormat("HH:mm aaa").format(DateTime.now()),
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildMoodOfWeek() {
    return Obx(() {
      var weeklyMoods = controller.weeklyMoodsList;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Text(
            "Mood in weeks",
            style: TextStyle(fontSize: 16, color: mutedforeground),
          ),
          SizedBox(height: 15),
          if (weeklyMoods.isEmpty)
            Center(
              child: Text(
                "ไม่มีการบันทึกอารมณ์ในสัปดาห์นี้",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          SizedBox(
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: weeklyMoods.length,
              itemBuilder: (context, index) {
                var data = weeklyMoods[index];
                DateTime parsedDate =
                    data["date"]; // date เป็น DateTime อยู่แล้ว
                String? mood = data["mood"]; // mood อาจจะเป็น null ได้

                String dayStr = DateFormat(
                  "EEE",
                ).format(parsedDate); // เช่น Mon
                String dateStr = DateFormat("d").format(parsedDate); // เช่น 30
                bool isToday = data["isToday"] ?? false;

                return Container(
                  margin: EdgeInsets.only(right: 15),
                  width: 50,
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        dayStr,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: "",
                          color: Colors.grey,
                        ),
                      ),
                      mood != null
                          ? SvgPicture.asset(
                              controller.getIconPath(mood),
                              width: 35,
                              height: 35,
                            )
                          : SizedBox(
                              height: 50,
                              width: 50,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1000),
                                  color: Colors.white54,
                                ),
                              ),
                            ),
                      // SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: isToday ? primary : Colors.transparent,
                        ),
                        child: Text(
                          dateStr,
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: "noam",
                            color: isToday ? Colors.white : Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildTips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height:  15),
        Text("Tips", style: TextStyle(fontSize: 16, color: mutedforeground)),
        SizedBox(height: 15),
        SvgPicture.asset("assets/images/tips/5-tips.svg"),
      ],
    );
  }
}
