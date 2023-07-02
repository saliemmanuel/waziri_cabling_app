import 'package:flutter/material.dart';

import '../config/config.dart';
import 'custom_text.dart';
import 'custum_textField.dart';

class CustomDetailWidget2 extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final bool? obscureText;
  const CustomDetailWidget2(
      {super.key,
      required this.controller,
      required this.title,
      required this.onChanged,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
          child: Align(
              alignment: Alignment.centerLeft, child: CustomText(data: title)),
        ),
        CustumTextField(
            onChanged: onChanged,
            bacgroundColor: Palette.teal,
            child: title,
            controller: controller,
            obscureText: obscureText),
      ],
    );
  }
}
