import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/notification/controllers/notification_controller.dart';
import 'package:ilu/app/modules/notification/views/mobile/notification_mobile_ui_view.dart';
import 'package:ilu/app/modules/notification/views/web/notification_web_ui_view.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  void initState() {
    final controller = Get.find<NotificationController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialState();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      mobileUI: NotificationMobileUiView(),
      desktopUI: NotificationWebUiView(),
    );
  }
}
