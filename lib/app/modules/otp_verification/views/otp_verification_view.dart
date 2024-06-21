import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/otp_verification/controllers/otp_verification_controller.dart';
import 'package:ilu/app/modules/otp_verification/views/mobile/otp_verify_mobile_ui_view.dart';
import 'package:ilu/app/modules/otp_verification/views/web/otp_verify_web_ui_view.dart';

class OtpVerificationView extends StatefulWidget {

  const OtpVerificationView({super.key});

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {

  @override
  void initState() {
    final controller = Get.find<OtpVerificationController>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.startTimer();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      mobileUI: OtpVerifyMobileUiView(),
      desktopUI: OtpVerifyWebUiView(),
    );
  }
}
