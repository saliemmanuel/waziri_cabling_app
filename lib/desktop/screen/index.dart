import 'package:flutter/material.dart';
import '../../config/config.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.scaffold,
      child: Column(
        children: [
          Expanded(child: Image.asset("assets/images/splash.png")),
        ],
      ),
    );
  }
}
