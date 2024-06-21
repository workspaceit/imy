import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/recharge_directly/controllers/recharge_directly_controller.dart';
import 'package:ilu/app/modules/recharge_directly/views/mobile/recharge_directly_mobile_view.dart';
import 'package:ilu/app/modules/recharge_directly/views/web/recharge_directly_web_view.dart';

class RechargeDirectlyView extends StatefulWidget {

  const RechargeDirectlyView({super.key});

  @override
  State<RechargeDirectlyView> createState() => _RechargeDirectlyViewState();
}

class _RechargeDirectlyViewState extends State<RechargeDirectlyView> {

  @override
  void initState() {
    Get.find<RechargeDirectlyController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      mobileUI: RechargeDirectlyMobileView(),
      desktopUI: RechargeDirectlyWebView(),
    );
  }
}
