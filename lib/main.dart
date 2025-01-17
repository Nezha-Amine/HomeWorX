// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:home_service_app/pages/confirmOTP.dart';
import 'package:home_service_app/pages/forgetPassword.dart';
import 'package:home_service_app/pages/creationSuccess.dart';
import 'package:home_service_app/pages/resetPassword.dart';

import 'pages/create_account.dart';
import 'pages/home.dart';
import 'pages/login.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/create_account': (context) => CreateAccount(),
      '/login': (context) => Login(),
      '/forget_password': (context) => ForgetPassword(),
      '/confirm_otp': (context) => ConfirmOTP(),
      '/reset_password': (context) => ResetPassword(),
      '/creation_success': (context) => CreationSuccess(),
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
