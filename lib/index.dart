import 'package:flutter/material.dart';
import 'package:waziri_cabling_app/desktop/screen/splash_desk_screen.dart';
import 'package:waziri_cabling_app/mobile/screens/splash_mobile_screen.dart';

class Index extends StatelessWidget {
  final bool isDesktop;
  const Index({
    Key? key,
    required this.isDesktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isDesktop) {
      return const SplashDeskScreen();
    } else {
      return const SplashMobileScreen();
    }
  }
}
