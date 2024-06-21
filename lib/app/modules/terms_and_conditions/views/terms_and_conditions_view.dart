import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/terms_and_conditions/controllers/terms_and_conditions_controller.dart';
import 'package:ilu/app/modules/terms_and_conditions/views/mobile/terms_and_conditions_mobile_view.dart';
import 'package:ilu/app/modules/terms_and_conditions/views/web/terms_and_conditions_web_view.dart';

class TermsAndConditionsView extends StatefulWidget {

  const TermsAndConditionsView({super.key});

  @override
  State<TermsAndConditionsView> createState() => _TermsAndConditionsViewState();
}

class _TermsAndConditionsViewState extends State<TermsAndConditionsView> {

  @override
  void initState() {
    Get.find<TermsAndConditionsController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      mobileUI: TermsAndConditionsMobileView(),
      desktopUI: TermsAndConditionsWebView(),
    );
  }
}
