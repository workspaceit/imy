import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle appTextStyle(
      {Color? textColor,
      double? fontSize,
      FontWeight? fontWeight,
      Paint? background,
      Paint? foreground,
      double? textHeight,
      double? textWordSpacing,
      double? textLetterSpacing,
      List<Shadow>? shadows,
      TextDecoration? textDecoration}) {
    return GoogleFonts.inter(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        background: background,
        foreground: foreground,
        height: textHeight,
        wordSpacing: textWordSpacing,
        letterSpacing: textLetterSpacing,
        shadows: shadows,
        decoration: textDecoration
    );
  }
}
