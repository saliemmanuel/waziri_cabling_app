import 'package:flutter/material.dart';

import '../config/config.dart';

class AddImageCard extends StatelessWidget {
  final Widget? child;
  final Function()? onTap;
  const AddImageCard({super.key, this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 155.5,
        width: double.infinity,
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Palette.primaryColor)),
        child: SizedBox(
            child: child ?? const Icon(Icons.add, color: Palette.primaryColor)),
      ),
    );
  }
}
