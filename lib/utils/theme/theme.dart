import 'package:flutter/material.dart';
import 'package:home_service_app/utils/theme/widget_themes/appbar_theme.dart';
import 'package:home_service_app/utils/theme/widget_themes/bottom_sheet_theme.dart';
import 'package:home_service_app/utils/theme/widget_themes/checkbox_theme.dart';
import 'package:home_service_app/utils/theme/widget_themes/chip_theme.dart';
import 'package:home_service_app/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:home_service_app/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:home_service_app/utils/theme/widget_themes/text_field_theme.dart';
import 'package:home_service_app/utils/theme/widget_themes/text_theme.dart';

import '../constants/colors.dart';

class HAppTheme {
  HAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: HColors.grey,
    brightness: Brightness.light,
    primaryColor: HColors.primary,
    textTheme: TTextTheme.lightTextTheme,
    chipTheme: TChipTheme.lightChipTheme,
    scaffoldBackgroundColor: HColors.white,
    appBarTheme: HAppBarTheme.lightAppBarTheme,
    checkboxTheme: HCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: HBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: HElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: HOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: HTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: HColors.grey,
    brightness: Brightness.dark,
    primaryColor: HColors.primary,
    textTheme: TTextTheme.darkTextTheme,
    chipTheme: TChipTheme.darkChipTheme,
    scaffoldBackgroundColor: HColors.black,
    appBarTheme: HAppBarTheme.darkAppBarTheme,
    checkboxTheme: HCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: HBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: HElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: HOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: HTextFormFieldTheme.darkInputDecorationTheme,
  );
}
