import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/notification_settings/controllers/notification_settings_controller.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class NotificationSettingsMobileUiView extends StatelessWidget {
  const NotificationSettingsMobileUiView({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: false,
      child: GetBuilder<NotificationSettingsController>(
        builder: (controller) => Scaffold(
          backgroundColor: AppColors.colorWhite,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.colorWhite,
            leading: IconButton(
                onPressed: () => Get.back(),
                alignment: Alignment.center,
                icon: SvgPicture.asset(AppIcons.arrowBack),
                iconSize: 24),
            title: Text(
              "Notification",
              textAlign: TextAlign.center,
              style: AppTextStyle.appTextStyle(
                  textColor: AppColors.colorDarkA,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
                child: TextButton(
                    onPressed: (){
                      controller.setNotificationSetting();
                    },
                    child: controller.isSubmit ? const SizedBox(
                      height: 16, width: 16,
                      child: CircularProgressIndicator(color: AppColors.colorDarkA, strokeWidth: 2),
                    ) : GradientText(
                        "Save",
                        style: AppTextStyle.appTextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w500
                        ),
                        colors: const [
                          Color(0xffFFD000),
                          Color(0xffF80261),
                          Color(0xff7017FF)
                        ]
                    )
                ),
              )
            ],
          ),
          body: controller.isLoading ? const Center(
            child: CircularProgressIndicator(color: AppColors.colorDarkA),
          ) : SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // manage notification text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Manage Your Notification",
                      style: AppTextStyle.appTextStyle(
                          textColor: AppColors.colorDarkA,
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    const Gap(12),
                    Text(
                      "Stay connected! Share your preferred contact information, ensuring seamless communication.",
                      style: AppTextStyle.appTextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          textColor: AppColors.colorDarkB
                      ),
                    ),
                  ],
                ),
                const Gap(24),

                // pause notification
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pause all",
                            style: AppTextStyle.appTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                textColor: AppColors.colorDarkA
                            ),
                          ),
                          const Gap(4),
                          Text(
                            "Temporarily pause notifications",
                            style: AppTextStyle.appTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                textColor: AppColors.colorDarkB
                            ),
                          )
                        ],
                      ),
                    ),
                    const Gap(8),
                    controller.temporarilyPauseNotification ? GestureDetector(
                      onTap: () {
                        controller.tempPauseNotification();
                      },
                      child: Container(
                        width: 40,
                        height: 25,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsetsDirectional.only(end: 4, top: 2, bottom: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: AppColors.primaryGradient
                        ),
                        child: Container(
                          height: 16, width: 16,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.colorWhite
                          ),
                        ),
                      ),
                    ) : GestureDetector(
                      onTap: () {
                        controller.tempPauseNotification();
                      },
                      child: Container(
                        width: 40,
                        height: 25,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsetsDirectional.only(start: 4, top: 2, bottom: 2),
                        decoration: BoxDecoration(
                            color: AppColors.colorGrayA,
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Container(
                          height: 16, width: 16,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.colorWhite
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const Gap(24),

                // other notification text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Other Notifications",
                      style: AppTextStyle.appTextStyle(
                          textColor: AppColors.colorDarkA,
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    const Gap(12),
                    Text(
                      "Never miss a chance to start a meaningful conversation and explore exciting possibilities.",
                      style: AppTextStyle.appTextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          textColor: AppColors.colorDarkB
                      ),
                    ),
                  ],
                ),
                const Gap(24),

                // pause notification
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Messages",
                            style: AppTextStyle.appTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                textColor: AppColors.colorDarkA
                            ),
                          ),
                          const Gap(4),
                          Text(
                            "Someone send you a new message.",
                            style: AppTextStyle.appTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                textColor: AppColors.colorDarkB
                            ),
                          )
                        ],
                      ),
                    ),
                    const Gap(8),
                    controller.messageNotification ? GestureDetector(
                      onTap: (){
                        controller.setMessageNotification();
                      },
                      child: Container(
                        width: 40,
                        height: 25,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsetsDirectional.only(end: 4, top: 2, bottom: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: AppColors.primaryGradient
                        ),
                        child: Container(
                          height: 16, width: 16,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.colorWhite
                          ),
                        ),
                      ),
                    ) : GestureDetector(
                      onTap: (){
                        controller.setMessageNotification();
                      },
                      child: Container(
                        width: 40,
                        height: 25,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsetsDirectional.only(start: 4, top: 2, bottom: 2),
                        decoration: BoxDecoration(
                            color: AppColors.colorGrayA,
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Container(
                          height: 16, width: 16,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.colorWhite
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
