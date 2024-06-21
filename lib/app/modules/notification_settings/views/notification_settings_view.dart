import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/notification_settings/controllers/notification_settings_controller.dart';
import 'package:ilu/app/modules/notification_settings/views/mobile/notification_settings_mobile_ui_view.dart';
import 'package:ilu/app/modules/notification_settings/views/web/notification_settings_web_ui_view.dart';

class NotificationSettingsView extends StatefulWidget {
  const NotificationSettingsView({super.key});

  @override
  State<NotificationSettingsView> createState() => _NotificationSettingsViewState();
}

class _NotificationSettingsViewState extends State<NotificationSettingsView> {

  @override
  void initState() {
    final controller = Get.find<NotificationSettingsController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getUserData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      mobileUI: NotificationSettingsMobileUiView(),
      desktopUI: NotificationSettingsWebUiView(),
    );
  }
}
