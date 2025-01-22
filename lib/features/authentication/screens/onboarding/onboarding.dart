import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_service_app/features/authentication/controllers/onboarding_controller.dart';
import 'package:home_service_app/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:home_service_app/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:home_service_app/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:home_service_app/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:home_service_app/utils/constants/colors.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
        backgroundColor: HColors.primaryBackground,
        body: Stack(
          children: [
            //Horizontal Scrollable Pages
            PageView(
              controller: controller.pageController,
              onPageChanged: controller.updatePageIndicator,
              children: const [
                OnBoardingPage(
                  image: HImages.onBoardingImage1,
                  title: HTexts.onBoardingTitle1,
                  subTitle: HTexts.onBoardingSubTitle1,
                ),
                OnBoardingPage(
                  image: HImages.onBoardingImage2,
                  title: HTexts.onBoardingTitle2,
                  subTitle: HTexts.onBoardingSubTitle2,
                ),
                OnBoardingPage(
                  image: HImages.onBoardingImage3,
                  title: HTexts.onBoardingTitle3,
                  subTitle: HTexts.onBoardingSubTitle3,
                ),
              ],
            ),
            //Skip Button
            const OnBoardingSkip(),
            //Dot Navigation SmoothPageIndicator
            const OnBoardingDotNavigation(),
            //Circular Button

            const OnBoardingNextButton()
          ],
        ));
  }
}
