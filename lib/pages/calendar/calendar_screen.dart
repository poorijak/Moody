import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:moody_app/controllers/add_mood_controller.dart';
import 'package:moody_app/themes/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatelessWidget {
  CalendarScreen({Key? key}) : super(key: key);

  final controller = Get.put(AddMoodController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Mood Calendar",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: black,
                  ),
                ),
              ),
              SizedBox(height: 46),
              _buildCalendar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      rowHeight: 80,
      headerVisible: false,
      daysOfWeekHeight: 40,
      calendarBuilders: CalendarBuilders(
        dowBuilder: (context, day) {
          final text = DateFormat.E().format(day);

          return Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB0B0B2),
                ),
              ),
            ),
          );
        },
        defaultBuilder: (context, day, focusedDay) {
          return _buildMoodCell(day);
        },
        todayBuilder: (context, day, focusedDay) {
          return _buildMoodCell(day, isToday: true);
        },
        outsideBuilder: (context, day, focusedDay) {
          return SizedBox.shrink();
        },
      ),
    );
  }

  Color _getMoodColor(String mood) {
    switch (mood.toLowerCase()) {
      case "sensitive":
        return moodFaceSensitive;
      case "confuse":
        return moodFaceConfuse;
      case "angry":
        return moodFaceAngry;
      case "insecure":
        return moodFaceInsecure;
      case "boring":
        return moodFaceBoring;
      case "excited":
        return moodFaceExcited;
      default:
        return Colors.transparent;
    }
  }

  Widget _buildMoodCell(DateTime date, {bool isToday = false}) {
    String? mood = controller.getMoodForDate(date);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ส่วนของรูปภาพ SVG
        SizedBox(
          height: 35, // ปรับลดขนาดลงหน่อยเพื่อให้มีที่ว่างสำหรับตัวเลข
          width: 43,
          child: Container(
            padding: EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: mood != null ? _getMoodColor(mood) : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
            ),
            child: SvgPicture.asset(
              mood != null
                  ? "assets/images/icons/moods/faces/${mood.toLowerCase()}_face.svg"
                  : "assets/images/icons/notFound.svg",
            ),
          ),
        ),
        // ส่วนของตัวเลขวันที่
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isToday ? primary : Colors.transparent,
          ),
          child: Text(
            "${date.day}",
            style: TextStyle(
              fontSize: 15,
              fontFamily: "noam",
              color: isToday ? Colors.white : Colors.black54,
            ),
          ),
        ),
      ],
    );
  }

 
}
