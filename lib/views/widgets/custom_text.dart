import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;

  const CustomText(
    this.text, {
    this.fontSize = 12,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
    this.textAlign = TextAlign.left,
    this.maxLines,
    this.overflow = TextOverflow.visible,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
