import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moody_app/controllers/add_mood_controller.dart';
import 'package:moody_app/themes/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddMoodController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: IntrinsicHeight(
            child: Column(
              children: [
                _buildHomeHeader(),
                const Divider(
                  color: Color(0xFFE5E5E5),
                  thickness: 1,
                  height: 40, // ช่องว่างระหว่าง Widget บน-ล่าง รวมตัวเส้นด้วย
                  indent: 0, // ระยะร่นจากซ้าย
                  endIndent: 0, // ระยะร่นจากขวา
                ),
                _buildTodayMood(controller),
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

  Widget _buildTodayMood(AddMoodController controller) {
    return Obx(() {
      var todayMood = controller.selectedMood.value;

      return SizedBox(
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
                        child: SvgPicture.asset(
                          "assets/images/icons/moods/${todayMood.toLowerCase()}_mood.svg",
                          width: 59,
                          height: 59,
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
      );
    });
  }
}
