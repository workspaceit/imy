import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/edit_profile/controllers/edit_profile_controller.dart';
import 'package:ilu/app/modules/edit_profile/views/mobile/edit_profile_mobile_ui_view.dart';
import 'package:ilu/app/modules/edit_profile/views/web/edit_profile_web_ui_view.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {

  @override
  void initState() {
    final controller = Get.find<EditProfileController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialStage();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      mobileUI: EditProfileMobileUiView(),
      desktopUI: EditProfileWebUiView(),
    );
  }
}
