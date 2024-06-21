import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/account_settings/controllers/account_settings_controller.dart';
import 'package:ilu/app/modules/account_settings/views/mobile/account_settings_mobile_ui_view.dart';
import 'package:ilu/app/modules/account_settings/views/web/account_settings_web_ui_view.dart';

class AccountSettingsView extends StatefulWidget {
  const AccountSettingsView({super.key});

  @override
  State<AccountSettingsView> createState() => _AccountSettingsViewState();
}

class _AccountSettingsViewState extends State<AccountSettingsView> {

  @override
  void initState() {
    final controller = Get.find<AccountSettingsController>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      mobileUI: AccountSettingsMobileUiView(),
      desktopUI: AccountSettingsWebUiView(),
    );
  }
}
