import 'package:flutter/material.dart';

import '../config/config.dart';

class CustumButton extends StatelessWidget {
  final String? child;
  final Color? bacgroundColor;
  final double? borderRadius;
  final double? fontSize;
  final Color? textColor;
  final bool? enableBorder;
  final bool? enableButton;
  final Function()? onPressed;
  const CustumButton(
      {Key? key,
      this.child,
      this.borderRadius,
      this.fontSize,
      this.textColor,
      this.bacgroundColor,
      this.onPressed,
      this.enableBorder,
      required this.enableButton})
      : assert(child != null, 'child ne doit être different de null'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: InkWell(
        onTap: enableButton! ? onPressed : null,
        child: Container(
          height: 57.0,
          decoration: enableBorder == true
              ? BoxDecoration(
                  borderRadius: borderRadius == null
                      ? BorderRadius.circular(8.0)
                      : BorderRadius.circular(borderRadius!),
                  border: Border.all(color: Palette.primaryColor))
              : BoxDecoration(
                  borderRadius: borderRadius == null
                      ? BorderRadius.circular(8.0)
                      : BorderRadius.circular(borderRadius!),
                  color: bacgroundColor == null
                      ? enableButton == true
                          ? Palette.primaryColor
                          : Colors.grey
                      : bacgroundColor!,
                ),
          child: Center(
              child: Text(
            child!,
            softWrap: true,
            style: TextStyle(
                color: textColor == null
                    ? enableBorder == true
                        ? Palette.primaryColor
                        : Colors.white
                    : textColor!,
                fontSize: fontSize == null ? 19.0 : fontSize!),
          )),
        ),
      ),
    );
  }
}
