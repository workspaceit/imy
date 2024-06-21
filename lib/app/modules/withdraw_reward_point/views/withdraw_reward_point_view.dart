import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/withdraw_reward_point/controllers/withdraw_reward_point_controller.dart';
import 'package:ilu/app/modules/withdraw_reward_point/views/mobile/withdraw_reward_point_mobile_view.dart';
import 'package:ilu/app/modules/withdraw_reward_point/views/web/withdraw_reward_point_web_view.dart';

class WithdrawRewardPointView extends StatefulWidget {
  const WithdrawRewardPointView({super.key});

  @override
  State<WithdrawRewardPointView> createState() => _WithdrawRewardPointViewState();
}

class _WithdrawRewardPointViewState extends State<WithdrawRewardPointView> {

  @override
  void initState() {
    final controller = Get.find<WithdrawRewardPointController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getUserData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      mobileUI: WithdrawRewardPointMobileView(),
      desktopUI: WithdrawRewardPointWebView(),
    );
  }
}
