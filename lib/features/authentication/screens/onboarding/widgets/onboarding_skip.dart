import 'package:flutter/material.dart';
import 'package:home_service_app/features/authentication/controllers/onboarding_controller.dart';
import 'package:home_service_app/utils/constants/colors.dart';
import 'package:home_service_app/utils/constants/sizes.dart';
import 'package:home_service_app/utils/device/device_utility.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: HDeviceUtils.getAppBarHeight(),
      right: HSizes.defaultSpace,
      child: TextButton(
        onPressed: () => OnboardingController.instance.skipPage(),
        child: const Text('Skip',
            style: TextStyle(
                color: HColors.textWhite, fontSize: HSizes.fontSizeMd)),
      ),
    );
  }
}
