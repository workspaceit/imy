import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/purchase_history/controllers/purchase_history_controller.dart';
import 'package:ilu/app/modules/purchase_history/views/mobile/purchase_history_mobile_ui_view.dart';
import 'package:ilu/app/modules/purchase_history/views/web/purchase_history_web_ui_view.dart';

class PurchaseHistoryView extends StatefulWidget {
  const PurchaseHistoryView({super.key});

  @override
  State<PurchaseHistoryView> createState() => _PurchaseHistoryViewState();
}

class _PurchaseHistoryViewState extends State<PurchaseHistoryView> {
  @override
  void initState() {
    final controller = Get.find<PurchaseHistoryController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialState();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      mobileUI: PurchaseHistoryMobileUiView(),
      desktopUI: PurchaseHistoryWebUiView(),
    );
  }
}
