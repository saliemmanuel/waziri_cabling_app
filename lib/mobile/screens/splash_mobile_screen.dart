import 'package:flutter/material.dart';
import 'package:waziri_cabling_app/config/config.dart';
import 'package:waziri_cabling_app/mobile/screens/login_mobile_screen.dart';

class SplashMobileScreen extends StatefulWidget {
  const SplashMobileScreen({super.key});

  @override
  State<SplashMobileScreen> createState() => _SplashMobileScreenState();
}

class _SplashMobileScreenState extends State<SplashMobileScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginMobileScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Palette.primaryColor, primarySwatch: Palette.swatch),
    );
  }
}
