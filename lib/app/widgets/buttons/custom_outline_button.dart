import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';

class CustomOutlineButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;

  const CustomOutlineButton({
    required this.onPressed,
    required this.buttonText,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.textColor = AppColors.colorDarkB,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(99),
      hoverColor: AppColors.colorWhite,
      onTap: onPressed,
      child: Container(
        width: Get.width,
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.colorGrayB, width: 1),
          borderRadius: BorderRadius.circular(99)
        ),
        child: Text(
          buttonText.tr,
          style: AppTextStyle.appTextStyle(
            textColor: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight
          ),
        )
      ),
    );
  }
}
