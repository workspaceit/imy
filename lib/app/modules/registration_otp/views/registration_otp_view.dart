import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/registration_otp/controllers/registration_otp_controller.dart';
import 'package:ilu/app/modules/registration_otp/views/mobile/registration_otp_mobile_view.dart';
import 'package:ilu/app/modules/registration_otp/views/web/registration_otp_web_view.dart';

class RegistrationOtpView extends StatefulWidget {
  const RegistrationOtpView({super.key});

  @override
  State<RegistrationOtpView> createState() => _RegistrationOtpViewState();
}

class _RegistrationOtpViewState extends State<RegistrationOtpView> {

  @override
  void initState() {
    final controller = Get.find<RegistrationOtpController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.startTimer();
      if(kIsWeb){
        if(controller.repo.apiService.sharedPreferences.getString(LocalStorageHelper.userTypeKey) == "Bangladesh"){
          controller.forgetPasswordPhoneVerify();
        }else{
          controller.forgetPasswordEmailVerify();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      mobileUI: RegistrationOtpMobileView(),
      desktopUI: RegistrationOtpWebView(),
    );
  }
}
