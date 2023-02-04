import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/config/config.dart';
import 'package:waziri_cabling_app/desktop/screen/log/provider/test_provider.dart';
import 'package:waziri_cabling_app/global_widget/custom_window_button.dart';
import 'package:window_manager/window_manager.dart';

import 'components/login_card.dart';

class LoginDeskScreen extends StatefulWidget {
  const LoginDeskScreen({super.key});

  @override
  State<LoginDeskScreen> createState() => _LoginDeskScreenState();
}

class _LoginDeskScreenState extends State<LoginDeskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.scaffold,
      body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.only(left: 70.0),
                    color: Palette.scaffold,
                    child: Image.asset(
                      'assets/images/logo_2.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Spacer(),
                  const Spacer(),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: 600.0,
                color: Palette.scaffold,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: const [
                    //       CustomWindowsButton(),
                    //     ],
                    //   ),
                    // ),
                    const Spacer(),
                    const LoginCard(),
                    const Spacer(),
                  ],
                ),
              ),
            )
          ]),
    );
  }
}
