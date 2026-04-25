import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moody_app/controllers/onboarding_controller.dart';
import 'package:moody_app/themes/colors.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    final List<OnboardingData> pages = [
      OnboardingData(
        title: "Not Sure\nYour\nMood?",
        imagePath: "assets/images/icons/onBoarding_1.png",
        fontSize: 56,
        backgroundColor: onboardingYellow,
      ),
      OnboardingData(
        title: "Turn Moods Into Memories",
        imagePath: "assets/images/icons/onBoarding_2.png",
        backgroundColor: onboardingPurple,
      ),
    ];

    return Scaffold(
      body: Obx(
        () => AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          color: pages[controller.currentPage.value].backgroundColor,
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    onPageChanged: controller.onPageChanged,
                    itemCount: pages.length,
                    itemBuilder: (context, index) {
                      return OnboardingPageContent(data: pages[index]);
                    },
                  ),
                ),
                _buildBottomBar(controller, pages.length),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(OnboardingController controller, int length) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Skip Button
          TextButton(
            onPressed: () => controller.skip(length),
            child: const Text(
              "Skip",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Advercase',
              ),
            ),
          ),

          // Page Indicator
          Row(
            children: List.generate(
              length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: controller.currentPage.value == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: controller.currentPage.value == index
                      ? Colors.black
                      : Colors.black.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),

          // Next Button
          GestureDetector(
            onTap: () => controller.nextPage(length),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.black,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String imagePath;
  final Color backgroundColor;
  final double fontSize;

  OnboardingData({
    required this.title,
    required this.imagePath,
    required this.backgroundColor,
    this.fontSize = 48,
  });
}

class OnboardingPageContent extends StatelessWidget {
  final OnboardingData data;

  const OnboardingPageContent({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: data.fontSize,
              fontWeight: FontWeight.normal,
              fontFamily: 'Advercase',
              height: 1.0,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          Image.asset(data.imagePath),
          const Spacer(),
        ],
      ),
    );
  }
}
