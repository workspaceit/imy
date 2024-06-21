import 'package:flutter/material.dart';

class AppColors {
  static const Color colorWhite = Color(0xffFFFFFF);
  static const Color colorLightWhite = Color(0xffF5F5F5);
  static const Color colorGrayA = Color(0xffF0F1F3);
  static const Color colorGrayB = Color(0xffF0F1F3);
  static const Color colorDarkA = Color(0xff383E49);
  static const Color colorDarkB = Color(0xff667085);
  static const Color colorBlueA = Color(0xff42B3F3);
  static const Color colorBlueB = Color(0xffE8F2F8);
  static const Color colorGreen = Color(0xff17B26A);
  static const Color colorRedB = Color(0xffFDF5F7);
  static const Color colorYellow = Color(0xffF6C825);

  static const primaryGradient = LinearGradient(
      begin: Alignment(1, -5),
      end: Alignment(-1, 2.5),
      colors: [Color(0xff7017ff), Color(0xfff80261), Color(0xffffd000)],
      stops: [0, 0.5, 1]);

  static const redGradient = LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: [Color(0xffF5827A), Color(0xffFF597B)]);
}
