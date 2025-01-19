// ignore_for_file: prefer_const_constructors
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:home_service_app/pages/confirmOTP.dart';
import 'package:home_service_app/pages/forgetPassword.dart';
import 'package:home_service_app/pages/creationSuccess.dart';
import 'package:home_service_app/pages/resetPassword.dart';
import 'package:home_service_app/pages/success_screen.dart';
import 'package:home_service_app/pages/verify_email.dart';

import 'pages/create_account.dart';
import 'pages/home.dart';
import 'pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  runApp(MyApp());
}

Future<void> initializeFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyBCaxUHLiFEgWqdTaZcks0I9bwfE4cwoXU",
        authDomain: "homeworx-19876.firebaseapp.com",
        projectId: "homeworx-19876",
        storageBucket: "homeworx-19876.appspot.com",
        messagingSenderId: "798788567053",
        appId: "1:798788567053:web:60c5931f76691449549544",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => Home()),
        GetPage(name: '/create_account', page: () => CreateAccount()),
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/forget_password', page: () => ForgetPassword()),
        GetPage(name: '/confirm_otp', page: () => ConfirmOTP()),
        GetPage(name: '/reset_password', page: () => ResetPassword()),
        GetPage(name: '/creation_success', page: () => CreationSuccess()),
        GetPage(
          name: '/verify_email',
          page: () => VerifyEmailScreen(email: Get.parameters['email'] ?? ''),
        ),
        GetPage(name: '/success_screen', page: () => SuccessScreen()),
      ],
    );
  }
}
