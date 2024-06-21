import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ilu/app/modules/splash/views/inner_widgets/splash_bottom_nav.dart';

class SplashMobileUiView extends GetView {
  const SplashMobileUiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.colorWhite,
        body: Center(
          child: Image.asset(AppImages.appLogoImage, height: 240, width: 240),
        ),
        bottomNavigationBar: const SplashBottomNav(),
      ),
    );
  }
}
