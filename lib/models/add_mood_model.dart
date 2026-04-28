import 'package:flutter/painting.dart';

class BackgroundData {
  final Color bgColor;
  final String mood;
  final String svgPath;

  BackgroundData({
    required this.svgPath,
    required this.mood,
    required this.bgColor,
  });
}

final List<BackgroundData> backgroundMood = [
  BackgroundData(
    mood: "Excited",
    svgPath: "assets/images/addMoods/excited_bg.png",
    bgColor: Color(0xFF71B1FF),
  ),
  BackgroundData(
    mood: "Boring",
    svgPath: "assets/images/addMoods/boring_bg.png",
    bgColor: Color(0xFF9189FF),
  ),
  BackgroundData(
    mood: "Sensitive",
    svgPath: "assets/images/addMoods/sensitive_bg.png",
    bgColor: Color(0xFFBBDFFF),
  ),
  BackgroundData(
    mood: "Insecure",
    svgPath: "assets/images/addMoods/insecure_bg.png",
    bgColor: Color(0xFFFF7473),
  ),
  BackgroundData(
    mood: "Angry",
    svgPath: "assets/images/addMoods/angry_bg.png",
    bgColor: Color(0xFFDB73FF),
  ),
  BackgroundData(
    mood: "Confuse",
    svgPath: "assets/images/addMoods/confuse_bg.png",
    bgColor: Color(0xFFF3FF73),
  ),
];
