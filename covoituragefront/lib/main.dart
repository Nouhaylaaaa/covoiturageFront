// ignore_for_file: prefer_const_constructors

import 'package:covoituragefront/interfaces/apps/splash_screen/splash_screen.dart';
import 'package:covoituragefront/interfaces/pages/loginPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: splash_screen(
          child: LoginPage(),
        ));
  }
}
