import 'package:flutter/material.dart';
import 'package:home_service_app/features/authentication/controllers/onboarding_controller.dart';
import 'package:home_service_app/utils/constants/colors.dart';
import 'package:home_service_app/utils/constants/sizes.dart';
import 'package:home_service_app/utils/device/device_utility.dart';
import 'package:iconsax/iconsax.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: HSizes.defaultSpace,
        bottom: HDeviceUtils.getBottomNavigationBarHeight(),
        child: ElevatedButton(
            onPressed: () => OnboardingController.instance.nextPage(),
            style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: HColors.buttonSecondary),
            child: const Icon(
              Iconsax.arrow_right_3,
              color: HColors.white,
              size: 24,
            )));
  }
}
