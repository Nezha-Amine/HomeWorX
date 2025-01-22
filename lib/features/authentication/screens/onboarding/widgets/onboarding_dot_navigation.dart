import 'package:flutter/material.dart';
import 'package:home_service_app/utils/constants/colors.dart';
import 'package:home_service_app/utils/constants/sizes.dart';
import 'package:home_service_app/utils/device/device_utility.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:home_service_app/features/authentication/controllers/onboarding_controller.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    return Positioned(
        bottom: HDeviceUtils.getBottomNavigationBarHeight() + 25,
        left: HSizes.defaultSpace,
        child: SmoothPageIndicator(
          controller: controller.pageController,
          onDotClicked: controller.dotNavigationClick,
          count: 3,
          effect: const ExpandingDotsEffect(
              activeDotColor: HColors.lightBlueBackground, dotHeight: 6),
        ));
  }
}
