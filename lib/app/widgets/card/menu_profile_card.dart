import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';

class MenuProfileCard extends StatelessWidget {
  final VoidCallback? onPressed;
  final String leadingImage;
  final String titleText;

  const MenuProfileCard(
      {this.onPressed,
      required this.leadingImage,
      required this.titleText,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(99),
      hoverColor: AppColors.colorWhite,
      onTap: onPressed,
      child: Container(
        width: Get.width,
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
            color: AppColors.colorWhite,
            border: Border.all(color: AppColors.colorLightWhite, width: 1),
            borderRadius: BorderRadius.circular(99)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                    height: 24,
                    width: 24,
                    child: SvgPicture.asset(leadingImage)),
                const Gap(12),
                Text(
                  titleText,
                  style: AppTextStyle.appTextStyle(
                      textColor: AppColors.colorDarkB,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.colorDarkB,
              size: 24,
            )
          ],
        ),
      ),
    );
  }
}
