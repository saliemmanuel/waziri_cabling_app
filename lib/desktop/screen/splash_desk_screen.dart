import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/config/config.dart';
import 'package:waziri_cabling_app/desktop/screen/home/home_desk_screen.dart';
import 'package:waziri_cabling_app/desktop/screen/log/login_desk_screen.dart';
import 'package:waziri_cabling_app/desktop/screen/log/provider/auth_provider.dart';
import 'package:waziri_cabling_app/global_widget/route.dart';

class SplashDeskScreen extends StatefulWidget {
  const SplashDeskScreen({super.key});

  @override
  State<SplashDeskScreen> createState() => _SplashDeskScreenState();
}

class _SplashDeskScreenState extends State<SplashDeskScreen> {
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      home: Consumer<AuthProvider>(
        builder: (context, data, child) {
          var userIslogged = data.userIsLogged;
          if (!userIslogged) return const LoginDeskScreen();
          return HomeDeskScreen(users: data.user);
        },
      ),
    );
  }
}
