// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String data;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final Color? color;
  final double? fontSize;
  final TextOverflow? overflow;
  const CustomText({
    Key? key,
    required this.data,
    this.strutStyle,
    this.textAlign,
    this.fontWeight,
    this.color,
    this.fontSize,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(data,
        overflow: overflow,
        style: GoogleFonts.cabin(
            color: color, fontWeight: fontWeight, fontSize: fontSize));
  }
}
