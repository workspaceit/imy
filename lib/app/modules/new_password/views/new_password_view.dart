import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/new_password/controllers/new_password_controller.dart';
import 'package:ilu/app/modules/new_password/views/mobile/new_password_mobile_ui_view.dart';
import 'package:ilu/app/modules/new_password/views/web/new_password_web_ui_view.dart';

class NewPasswordView extends StatefulWidget {
  const NewPasswordView({super.key});

  @override
  State<NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<NewPasswordView> {
  @override
  void initState() {
    Get.find<NewPasswordController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      mobileUI: NewPasswordMobileUiView(),
      desktopUI: NewPasswordWebUiView(),
    );
  }
}
