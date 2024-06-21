import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/recharge_from_reward_balance/controllers/recharge_from_reward_balance_controller.dart';
import 'package:ilu/app/modules/recharge_from_reward_balance/views/mobile/recharge_from_reward_mobile_view.dart';
import 'package:ilu/app/modules/recharge_from_reward_balance/views/web/recharge_from_reward_web_view.dart';

class RechargeFromRewardBalanceView extends StatefulWidget {
  const RechargeFromRewardBalanceView({super.key});

  @override
  State<RechargeFromRewardBalanceView> createState() => _RechargeFromRewardBalanceViewState();
}

class _RechargeFromRewardBalanceViewState extends State<RechargeFromRewardBalanceView> {

  @override
  void initState() {
    Get.find<RechargeFromRewardBalanceController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      mobileUI: RechargeFromRewardMobileView(),
      desktopUI: RechargeFromRewardWebView(),
    );
  }
}
