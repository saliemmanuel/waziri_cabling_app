import 'package:flutter/material.dart';

import '../config/config.dart';

class NumPad extends StatelessWidget {
  final double buttonSize;
  final Color iconColor;
  final TextEditingController controller;
  final Function delete;
  final Function onSubmit;

  const NumPad({
    Key? key,
    this.buttonSize = 60,
    this.iconColor = Palette.primaryColor,
    required this.delete,
    required this.onSubmit,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NumberButton(
              number: 1,
              size: buttonSize,
              controller: controller,
            ),
            NumberButton(
              number: 2,
              size: buttonSize,
              controller: controller,
            ),
            NumberButton(
              number: 3,
              size: buttonSize,
              controller: controller,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NumberButton(
              number: 4,
              size: buttonSize,
              controller: controller,
            ),
            NumberButton(
              number: 5,
              size: buttonSize,
              controller: controller,
            ),
            NumberButton(
              number: 6,
              size: buttonSize,
              controller: controller,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NumberButton(
              number: 7,
              size: buttonSize,
              controller: controller,
            ),
            NumberButton(
              number: 8,
              size: buttonSize,
              controller: controller,
            ),
            NumberButton(
              number: 9,
              size: buttonSize,
              controller: controller,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // this button is used to delete the last number
            IconButton(
              onPressed: () => delete(),
              icon: Icon(
                Icons.backspace,
                color: iconColor,
              ),
              iconSize: 35.0,
            ),

            NumberButton(
              number: 0,
              size: buttonSize,
              controller: controller,
            ),
            // this button is used to submit the entered value
            IconButton(
              onPressed: () => onSubmit(),
              icon: Icon(
                Icons.done_rounded,
                color: iconColor,
              ),
              iconSize: 35.0,
            ),
          ],
        ),
      ],
    );
  }
}

// define NumberButton widget
// its shape is round
class NumberButton extends StatelessWidget {
  final int number;
  final double size;
  final TextEditingController controller;

  const NumberButton({
    Key? key,
    required this.number,
    required this.size,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: InkWell(
        onTap: () {
          controller.text += number.toString();
        },
        child: Center(
          child: Text(
            number.toString(),
            style: const TextStyle(color: Colors.black, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
