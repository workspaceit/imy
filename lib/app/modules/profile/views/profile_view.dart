import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/profile/controllers/profile_controller.dart';
import 'package:ilu/app/modules/profile/views/mobile/profile_mobile_ui_view.dart';
import 'package:ilu/app/modules/profile/views/web/profile_web_ui_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    final controller = Get.find<ProfileController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialStage();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      mobileUI: ProfileMobileUiView(),
      desktopUI: ProfileWebUiView(),
    );
  }
}
