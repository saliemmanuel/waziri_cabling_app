import 'package:flutter/material.dart';

import '../config/config.dart';

class CustumTextField extends StatefulWidget {
  final String? child;
  final Color? bacgroundColor;
  final double? borderRadius;
  final double? fontSize;
  final Color? textColor;
  final TextEditingController? controller;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final int? maxLength;
  final FocusNode? focusNode;
  final bool? enabled;

  const CustumTextField(
      {Key? key,
      this.child,
      this.borderRadius,
      this.fontSize,
      this.textColor,
      this.bacgroundColor,
      this.controller,
      this.obscureText,
      this.keyboardType,
      this.onChanged,
      this.maxLength,
      this.focusNode,
      this.enabled})
      : assert(child != null, 'child ne doit être different de null'),
        super(key: key);

  @override
  _CustumTextFieldState createState() => _CustumTextFieldState();
}

class _CustumTextFieldState extends State<CustumTextField> {
  bool obscure = false;
  @override
  void initState() {
    obscure = widget.obscureText!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
      child: Container(
        alignment: Alignment.center,
        height: 58.0,
        decoration: BoxDecoration(
            borderRadius: widget.borderRadius == null
                ? BorderRadius.circular(8.0)
                : BorderRadius.circular(widget.borderRadius!),
            border: Border.all(color: Palette.primaryColor)),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: TextField(
            enabled: widget.enabled,
            focusNode: widget.focusNode,
            maxLength: widget.maxLength,
            obscureText: obscure == false ? false : true,
            autocorrect: true,
            controller: widget.controller,
            cursorHeight: 18,
            keyboardType: widget.keyboardType,
            cursorColor: Palette.primaryColor,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              hintText: widget.child,
              disabledBorder: InputBorder.none,
              border: InputBorder.none,
              suffixIcon: widget.obscureText == true
                  ? IconButton(
                      icon: obscure
                          ? const Icon(Icons.visibility_off,
                              color: Palette.primaryColor)
                          : const Icon(Icons.visibility,
                              color: Palette.primaryColor),
                      onPressed: () {
                        setState(() {
                          obscure = !obscure;
                        });
                      },
                    )
                  : null,
            ),
          ),
        )),
      ),
    );
  }
}
