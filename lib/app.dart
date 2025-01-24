import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:home_service_app/bindings/general_bindings.dart';
import 'package:home_service_app/data/repositories/authentication/authentication_repository.dart';
import 'package:home_service_app/utils/constants/colors.dart';
import 'package:home_service_app/utils/constants/text_strings.dart';
import 'package:home_service_app/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: HTexts.appName,
      themeMode: ThemeMode.system,
      theme: HAppTheme.lightTheme,
      initialBinding: GeneralBindings(),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: AuthenticationRepository.instance.screenRedirect(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(); // Placeholder, as navigation is handled in `screenRedirect`.
          }
          return const Scaffold(
            backgroundColor: HColors.primary,
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
