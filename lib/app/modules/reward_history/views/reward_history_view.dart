import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/reward_history/controllers/reward_history_controller.dart';
import 'package:ilu/app/modules/reward_history/views/mobile/reward_history_mobile_view.dart';
import 'package:ilu/app/modules/reward_history/views/web/reward_history_web_view.dart';

class RewardHistoryView extends StatefulWidget {
  const RewardHistoryView({super.key});

  @override
  State<RewardHistoryView> createState() => _RewardHistoryViewState();
}

class _RewardHistoryViewState extends State<RewardHistoryView> {

  @override
  void initState() {
    final controller = Get.find<RewardHistoryController>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialState();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      mobileUI: RewardHistoryMobileView(),
      desktopUI: RewardHistoryWebView(),
    );
  }
}
