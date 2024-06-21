import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/registration/controllers/registration_controller.dart';
import 'package:ilu/app/modules/registration/views/mobile/registration_mobile_ui_view.dart';
import 'package:ilu/app/modules/registration/views/web/registration_web_ui_view.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {

  @override
  void initState() {
    final controller = Get.find<RegistrationController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getCityData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      mobileUI: RegistrationMobileUiView(),
      desktopUI: RegistrationWebUiView(),
    );
  }
}
