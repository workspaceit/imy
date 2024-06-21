import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/privacy_policy/controllers/privacy_policy_controller.dart';
import 'package:ilu/app/modules/privacy_policy/views/mobile/privacy_policy_mobile_ui_view.dart';
import 'package:ilu/app/modules/privacy_policy/views/web/privacy_policy_web_ui_view.dart';

class PrivacyPolicyView extends StatefulWidget {
  const PrivacyPolicyView({super.key});

  @override
  State<PrivacyPolicyView> createState() => _PrivacyPolicyViewState();
}

class _PrivacyPolicyViewState extends State<PrivacyPolicyView> {

  @override
  void initState() {
    Get.find<PrivacyPolicyController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      mobileUI: PrivacyPolicyMobileUiView(),
      desktopUI: PrivacyPolicyWebUiView(),
    );
  }
}
