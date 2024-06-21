import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/call_history/controllers/call_history_controller.dart';
import 'package:ilu/app/routes/app_pages.dart';

class CallHistoryWebUiView extends StatelessWidget {
  final ScrollController scrollController;
  const CallHistoryWebUiView({required this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<CallHistoryController>(builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.colorWhite,
          /// -------------------------- appbar --------------------------------
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.colorWhite,
            leading: IconButton(
                onPressed: () => Get.toNamed(Routes.PROFILE),
                alignment: Alignment.center,
                icon: SvgPicture.asset(AppIcons.arrowBack),
                iconSize: 24),
            title: Text(
              "Call History",
              textAlign: TextAlign.center,
              style: AppTextStyle.appTextStyle(
                  textColor: AppColors.colorDarkA,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          /// ------------------- body -----------------------
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 24),
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: 600,
                  child: Text(
                    "No Call History Available",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkA, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
