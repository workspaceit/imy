import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/bkash_withdraw/controllers/bkash_withdraw_controller.dart';
import 'package:ilu/app/modules/bkash_withdraw/views/mobile/bkash_withdraw_mobile_view.dart';
import 'package:ilu/app/modules/bkash_withdraw/views/web/bkash_withdraw_web_view.dart';

class BkashWithdrawView extends StatefulWidget {
  const BkashWithdrawView({super.key});

  @override
  State<BkashWithdrawView> createState() => _BkashWithdrawViewState();
}

class _BkashWithdrawViewState extends State<BkashWithdrawView> {

  @override
  void initState() {
    final controller = Get.find<BkashWithdrawController>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      mobileUI: BkashWithdrawMobileView(),
      desktopUI: BkashWithdrawWebView(),
    );
  }
}
