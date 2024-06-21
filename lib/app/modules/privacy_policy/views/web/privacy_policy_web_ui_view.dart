import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/privacy_policy/controllers/privacy_policy_controller.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:ilu/app/widgets/list/custom_bulleted_list.dart';

class PrivacyPolicyWebUiView extends StatelessWidget {
  const PrivacyPolicyWebUiView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<PrivacyPolicyController>(
        builder: (controller) => Scaffold(
          backgroundColor: AppColors.colorWhite,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.colorWhite,
            leading: IconButton(
                onPressed: () => Get.toNamed(Routes.PROFILE),
                alignment: Alignment.center,
                icon: SvgPicture.asset(AppIcons.arrowBack),
                iconSize: 24),
            title: Text(
              "Privacy Policy",
              textAlign: TextAlign.center,
              style: AppTextStyle.appTextStyle(
                  textColor: AppColors.colorDarkA,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 24, vertical: 20),
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 600,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(controller.privacyList.length, (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        controller.privacyList[index].title,
                        style: AppTextStyle.appTextStyle(
                            textColor: AppColors.colorDarkA,
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      const Gap(12),
                      index == 0 ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.privacyList[0].content,
                            style: AppTextStyle.appTextStyle(
                                textColor: AppColors.colorDarkB,
                                fontWeight: FontWeight.w400,
                                fontSize: 14
                            ),
                          ),
                          const Gap(12)
                        ],
                      ) : index == 6 ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.privacyList[6].content,
                            style: AppTextStyle.appTextStyle(
                                textColor: AppColors.colorDarkB,
                                fontWeight: FontWeight.w400,
                                fontSize: 14
                            ),
                          ),
                          const Gap(12)
                        ],
                      ) : index == 7 ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.privacyList[7].content,
                            style: AppTextStyle.appTextStyle(
                                textColor: AppColors.colorDarkB,
                                fontWeight: FontWeight.w400,
                                fontSize: 14
                            ),
                          ),
                          const Gap(12)
                        ],
                      ) : index == 8 ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(controller.privacyList[8].content.length, (i) => Padding(
                            padding: index == controller.privacyList[8].content.length - 1 ? const EdgeInsetsDirectional.only(bottom: 0) : const EdgeInsetsDirectional.only(bottom: 12),
                            child: Text(
                              controller.privacyList[8].content[i],
                              style: AppTextStyle.appTextStyle(
                                  textColor: AppColors.colorDarkB,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14
                              ),
                            ),
                          ))
                      ) : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(controller.privacyList[index].content.length, (contentIndex) => Padding(
                          padding: index == controller.privacyList[index].content.length - 1 ? const EdgeInsetsDirectional.only(bottom: 12) : const EdgeInsetsDirectional.only(bottom: 12),
                          child: CustomBulletedList(
                              content: controller.privacyList[index].content[contentIndex]
                          ),
                        )),
                      )
                    ],
                  )),
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
}
