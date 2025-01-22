import 'package:flutter/material.dart';
import 'package:home_service_app/utils/constants/sizes.dart';
import '../../constants/colors.dart';

class HAppBarTheme {
  HAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: HColors.black, size: HSizes.iconMd),
    actionsIconTheme: IconThemeData(color: HColors.black, size: HSizes.iconMd),
    titleTextStyle: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: HColors.black),
  );
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: HColors.black, size: HSizes.iconMd),
    actionsIconTheme: IconThemeData(color: HColors.white, size: HSizes.iconMd),
    titleTextStyle: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: HColors.white),
  );
}
