import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/nagad_withdraw/controllers/nagad_withdraw_controller.dart';
import 'package:ilu/app/modules/nagad_withdraw/views/mobile/nagad_withdraw_mobile_view.dart';
import 'package:ilu/app/modules/nagad_withdraw/views/web/nagad_withdraw_web_view.dart';

class NagadWithdrawView extends StatefulWidget {
  const NagadWithdrawView({super.key});

  @override
  State<NagadWithdrawView> createState() => _NagadWithdrawViewState();
}

class _NagadWithdrawViewState extends State<NagadWithdrawView> {

  @override
  void initState() {
    final controller = Get.find<NagadWithdrawController>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      mobileUI: NagadWithdrawMobileView(),
      desktopUI: NagadWithdrawWebView(),
    );
  }
}
