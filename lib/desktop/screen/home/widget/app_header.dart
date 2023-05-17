import 'package:flutter/material.dart';

import '../../../../config/palette.dart';
import '../../../../global_widget/custom_text.dart';

Widget appHeader(String? label) {
  return Padding(
    padding: const EdgeInsets.only(top: 20.0, left: 45.0, right: 45.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: AppBar(
        title: CustomText(data: label!, color: Colors.black),
        elevation: 0.0,
        backgroundColor: Palette.scaffold,
      ),
    ),
  );
}
