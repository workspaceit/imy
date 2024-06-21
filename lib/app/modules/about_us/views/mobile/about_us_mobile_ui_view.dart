import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/about_us/controllers/about_us_controller.dart';
import 'package:ilu/app/widgets/list/custom_bulleted_list.dart';

class AboutUsMobileUiView extends StatelessWidget {
  const AboutUsMobileUiView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<AboutUsController>(
        builder: (controller) {
          return Scaffold(
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
                  "About Us",
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(controller.aboutUsList.length, (index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      controller.aboutUsList[index].title,
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
                          controller.aboutUsList[0].content,
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
                          controller.aboutUsList[6].content,
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
                          controller.aboutUsList[7].content,
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
                      children: List.generate(controller.aboutUsList[8].content.length, (i) => Padding(
                        padding: index == controller.aboutUsList[8].content.length - 1 ? const EdgeInsetsDirectional.only(bottom: 0) : const EdgeInsetsDirectional.only(bottom: 12),
                        child: Text(
                          controller.aboutUsList[8].content[i],
                          style: AppTextStyle.appTextStyle(
                              textColor: AppColors.colorDarkB,
                              fontWeight: FontWeight.w400,
                              fontSize: 14
                          ),
                        ),
                      ))
                    ) : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(controller.aboutUsList[index].content.length, (contentIndex) => Padding(
                        padding: index == controller.aboutUsList[index].content.length - 1 ? const EdgeInsetsDirectional.only(bottom: 12) : const EdgeInsetsDirectional.only(bottom: 12),
                        child: CustomBulletedList(
                            content: controller.aboutUsList[index].content[contentIndex]
                        ),
                      )),
                    )
                  ],
                )),
              ),
            ),
          );
        }
      ),
    );
  }
}
