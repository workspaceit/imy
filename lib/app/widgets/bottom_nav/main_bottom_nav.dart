import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/routes/app_pages.dart';

class MainBottomNav extends StatefulWidget {

  final int currentScreen;
  final bool isWeb;

  const MainBottomNav({required this.currentScreen, this.isWeb = false, super.key});

  @override
  State<MainBottomNav> createState() => _MainBottomNavState();
}

class _MainBottomNavState extends State<MainBottomNav> {

  int bottomNavIndex = 0;

  List<String> inActiveIconList = [
    AppIcons.homeInactive,
    AppIcons.messageInactive,
    "",
    AppIcons.bellInactive,
    AppIcons.profileInactive
  ];

  List<String> activeIconList = [
    AppIcons.homeActive,
    AppIcons.messageActive,
    "",
    AppIcons.bellActive,
    AppIcons.profileActive
  ];

  @override
  void initState() {
    bottomNavIndex = widget.currentScreen;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Container(
        width: Get.width,
        alignment: Alignment.center,
        decoration:
        BoxDecoration(color: AppColors.colorWhite, boxShadow: [
          BoxShadow(
              color: AppColors.colorDarkB.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(-2, -2))
        ]),
        padding: const EdgeInsetsDirectional.symmetric(
            vertical: 12, horizontal: 12),
        child: widget.isWeb ? Container(
          width: 600,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(inActiveIconList.length, (index) => index == 2 ? InkWell(
                  borderRadius: BorderRadius.circular(100),
                  hoverColor: AppColors.colorWhite,
                  onTap: () => Get.offAndToNamed(Routes.CREATE_POST),
                  child: Container(
                    height: 56,
                    width: 56,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppColors.primaryGradient),
                    child: SvgPicture.asset(AppIcons.bottomNavAdd,
                        height: 24, width: 24),
                  ),
                ) : IconButton(
                    onPressed: () => changePage(index),
                    icon: index == bottomNavIndex
                        ? SvgPicture.asset(
                        activeIconList[index],
                        height: 24,
                        width: 24)
                        : SvgPicture.asset(
                        inActiveIconList[index],
                        height: 24,
                        width: 24)
                )
            ),
          )
        ) : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
              inActiveIconList.length,
                  (index) => index == 2 ? GestureDetector(
                onTap: () => Get.toNamed(Routes.CREATE_POST),
                child: Container(
                  height: 56,
                  width: 56,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.primaryGradient),
                  child: SvgPicture.asset(AppIcons.bottomNavAdd,
                      height: 24, width: 24),
                ),
              ) : IconButton(
                  onPressed: () => changePage(index),
                  icon: index == bottomNavIndex
                      ? SvgPicture.asset(
                      activeIconList[index],
                      height: 24,
                      width: 24)
                      : SvgPicture.asset(
                      inActiveIconList[index],
                      height: 24,
                      width: 24)
              )
          ),
        ),
      ),
    );
  }

  void changePage(int index){
    if (index == 0) {
      if (!(widget.currentScreen == 0)) {
        Get.offAndToNamed(Routes.HOME);
      }
    }
    else if (index == 1) {
      if (!(widget.currentScreen == 1)) {
        Get.offAndToNamed(Routes.MESSAGE);
      }
    }
    else if (index == 3) {
      if (!(widget.currentScreen == 3)) {
        Get.offAndToNamed(Routes.NOTIFICATION);
      }
    }
    else if (index == 4) {
      if (!(widget.currentScreen == 4)) {
        Get.offAndToNamed(Routes.PROFILE);
      }
    }
  }
}
