import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;

  const CustomButton(
      {required this.onPressed,
      required this.buttonText,
      this.fontSize = 16,
      this.fontWeight = FontWeight.w600,
      this.textColor = AppColors.colorWhite,
      super.key
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(99),
      hoverColor: AppColors.colorWhite,
      onTap: onPressed,
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(99)
          ),
          child: FittedBox(
            child: Text(
              buttonText.tr,
              style: AppTextStyle.appTextStyle(
                textColor: textColor,
                fontSize: fontSize,
                fontWeight: fontWeight
              ),
            ),
          )
      ),
    );
  }
}
