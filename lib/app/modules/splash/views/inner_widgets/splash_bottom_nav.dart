import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_static_text.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';

class SplashBottomNav extends GetView {
  const SplashBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsetsDirectional.symmetric(vertical: 12),
        alignment: Alignment.center,
        child: Text(AppStaticText.version.tr,
            style: AppTextStyle.appTextStyle(
                textColor: AppColors.colorDarkA,
                fontSize: 14,
                fontWeight: FontWeight.w700)),
      ),
    );
  }
}
