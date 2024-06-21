import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/forget_password/controllers/forget_password_controller.dart';
import 'package:ilu/app/modules/forget_password/views/mobile/forget_password_mobile_ui_view.dart';
import 'package:ilu/app/modules/forget_password/views/web/forget_password_web_ui_view.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {

  @override
  void initState() {
    final forgetPasswordController = Get.find<ForgetPasswordController>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      mobileUI: ForgetPasswordMobileUiView(),
      desktopUI: const ForgetPasswordWebUiView(),
    );
  }
}
