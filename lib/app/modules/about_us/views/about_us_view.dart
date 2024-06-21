import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/about_us/controllers/about_us_controller.dart';
import 'package:ilu/app/modules/about_us/views/mobile/about_us_mobile_ui_view.dart';
import 'package:ilu/app/modules/about_us/views/web/about_us_web_ui_view.dart';

class AboutUsView extends StatefulWidget {

  const AboutUsView({super.key});

  @override
  State<AboutUsView> createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {

  @override
  void initState() {
    Get.find<AboutUsController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return const BaseLayout(
      mobileUI: AboutUsMobileUiView(),
      desktopUI: AboutUsWebUiView(),
    );
  }
}
