import 'package:flutter/material.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_images.dart';
import 'package:ilu/app/modules/splash/views/inner_widgets/splash_bottom_nav.dart';

class SplashWebUiView extends StatelessWidget {
  const SplashWebUiView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.colorWhite,
        body: Center(
          child:
              Image.asset(AppImages.appLogoImage, height: 400, width: 400),
        ),
        bottomNavigationBar: const SplashBottomNav(),
      ),
    );
  }
}
