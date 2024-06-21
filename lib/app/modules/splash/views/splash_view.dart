import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/splash/controllers/splash_controller.dart';
import 'package:ilu/app/modules/splash/views/mobile/splash_mobile_ui_view.dart';
import 'package:ilu/app/modules/splash/views/web/splash_web_ui_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    final SplashController splashController = Get.find();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      splashController.initialStage();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
        mobileUI: SplashMobileUiView(),
        desktopUI: SplashWebUiView());
  }
}
