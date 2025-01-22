import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:home_service_app/app.dart';
import 'package:home_service_app/data/repositories/authentication/authentication_repository.dart';
import 'package:home_service_app/data/repositories/user/user_repository.dart';
import 'package:home_service_app/firebase_options.dart';

Future<void> main() async {
// Widgets Binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

//GetX Local Storage

  await GetStorage.init();

// Await Native Splash with other items to Load

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

//Todo : Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then(
    (FirebaseApp value) {
      // Register repositories with GetX
      Get.put(AuthenticationRepository());
      Get.put(UserRepository());
    },
  );

//Todo : Initialize  Firebase

  runApp(const App());
}
