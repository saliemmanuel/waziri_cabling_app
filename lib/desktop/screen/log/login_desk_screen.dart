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
      body: Row(children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(55.0),
            color: Palette.scaffold,
            height: double.infinity,
            child: Image.asset('assets/images/login-page-img.png'),
          ),
        ),
        Container(
          width: 600.0,
          color: Palette.scaffold,
          alignment: Alignment.center,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    CustomWindowsButton(),
                  ],
                ),
              ),
              const Spacer(),
              const LoginCard(),
              const Spacer(),
            ],
          ),
        )
      ]),
    );
  }
}
