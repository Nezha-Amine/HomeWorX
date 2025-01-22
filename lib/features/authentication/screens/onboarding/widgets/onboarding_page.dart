import "package:flutter/material.dart";
import "package:home_service_app/utils/constants/colors.dart";
import "package:home_service_app/utils/constants/sizes.dart";
import "package:home_service_app/utils/helpers/helper_functions.dart";
import "package:lottie/lottie.dart";

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(HSizes.defaultSpace),
      child: Column(
        children: [
          Lottie.asset(
              width: HHelperFunctions.screenWidth() * 0.8,
              height: HHelperFunctions.screenHeight() * 0.6,
              image),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: HColors.textWhite, // Replace with your desired color
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: HSizes.spaceBtwItems,
          ),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: HColors.textWhite, // Replace with your desired color
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
