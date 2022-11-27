import 'package:flutter/material.dart';

import '../config/config.dart';

class ObscureTextWidget extends StatefulWidget {
  final TextEditingController controller;

  const ObscureTextWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  State<ObscureTextWidget> createState() => _ObscureTextWidgetState();
}

class _ObscureTextWidgetState extends State<ObscureTextWidget> {
  bool obscure = true;

  var valuePin2 = '******';
  var valuePin = '';
  @override
  void initState() {
    widget.controller.addListener(() {
      if (mounted) {
        setText();
      }
    });
    super.initState();
  }

  setText() {
    // if (obscure) {
    valuePin = widget.controller.text;
    // }
    setState(() {});
  }

  @override
  void dispose() {
    if (mounted) {
      widget.controller.removeListener(() {});
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            child: Text(obscure ? valuePin2 : valuePin,
                style: const TextStyle(color: Colors.black)),
            onTap: () {
              setState(() {
                obscure = !obscure;
                valuePin = widget.controller.text;
              });
            },
          ),
          IconButton(
            icon: obscure
                ? const Icon(Icons.visibility_off, color: Palette.primaryColor)
                : const Icon(Icons.visibility, color: Palette.primaryColor),
            onPressed: () {
              setState(() {
                obscure = !obscure;
                valuePin = widget.controller.text;
              });
            },
          )
        ],
      ),
    );
  }
}
