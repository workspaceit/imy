import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/withdraw_history/controllers/withdraw_history_controller.dart';
import 'package:ilu/app/modules/withdraw_history/views/mobile/withdraw_history_mobile_view.dart';
import 'package:ilu/app/modules/withdraw_history/views/web/withdraw_history_web_view.dart';

class WithdrawHistoryView extends StatefulWidget {
  const WithdrawHistoryView({super.key});

  @override
  State<WithdrawHistoryView> createState() => _WithdrawHistoryViewState();
}

class _WithdrawHistoryViewState extends State<WithdrawHistoryView> {

  @override
  void initState() {
    final controller = Get.find<WithdrawHistoryController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialState();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      mobileUI: WithdrawHistoryMobileView(),
      desktopUI: WithdrawHistoryWebView(),
    );
  }
}
