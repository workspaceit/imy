import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/help_and_support/controllers/help_and_support_controller.dart';
import 'package:ilu/app/modules/help_and_support/views/mobile/help_and_support_mobile_view.dart';
import 'package:ilu/app/modules/help_and_support/views/web/help_and_support_web_view.dart';

class HelpAndSupportView extends StatefulWidget {

  const HelpAndSupportView({super.key});

  @override
  State<HelpAndSupportView> createState() => _HelpAndSupportViewState();
}

class _HelpAndSupportViewState extends State<HelpAndSupportView> {

  @override
  void initState() {
    Get.find<HelpAndSupportController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      mobileUI: HelpAndSupportMobileView(),
      desktopUI: HelpAndSupportWebView(),
    );
  }
}
