import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';

class AuthBottomNav extends StatelessWidget {
  final Widget bottomNavChild;
  const AuthBottomNav({required this.bottomNavChild, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Container(
        width: Get.width,
        color: AppColors.colorWhite,
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 24, vertical: 20),
        child: bottomNavChild,
      ),
    );
  }
}
