import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/reward_history/controllers/reward_history_controller.dart';
import 'package:ilu/app/routes/app_pages.dart';

class RewardHistoryWebView extends StatelessWidget {
  const RewardHistoryWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<RewardHistoryController>(
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
              "Reward History",
              textAlign: TextAlign.center,
              style: AppTextStyle.appTextStyle(
                textColor: AppColors.colorDarkA,
                fontSize: 18,
                fontWeight: FontWeight.w600
              ),
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
                  children: [

                    // todo -> top section
                    Container(
                      width: Get.width,
                      padding: const EdgeInsetsDirectional.symmetric(
                          vertical: 12, horizontal: 12),
                      decoration: BoxDecoration(
                          color: AppColors.colorWhite,
                          borderRadius: BorderRadius.circular(8),
                          border: const GradientBoxBorder(
                              gradient: AppColors.primaryGradient, width: 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Available Reward Balance",
                                    style: AppTextStyle.appTextStyle(
                                        textColor: AppColors.colorDarkB,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400
                                    )
                                ),
                                const Gap(8),
                                Row(
                                  children: [
                                    SizedBox(
                                        height: 20, width: 20,
                                        child: SvgPicture.asset("assets/icons/reward_point.svg", color: const Color(0xfff80261))
                                    ),
                                    const Gap(8),
                                    Text(
                                      "${controller.rewardPoints}",
                                      textAlign: TextAlign.start,
                                      style: AppTextStyle.appTextStyle(
                                          textColor: const Color(0xfff80261),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const Gap(12),
                          Flexible(
                            child: InkWell(
                              hoverColor: AppColors.colorRedB,
                              borderRadius: BorderRadius.circular(8),
                              onTap: (){
                                /// ----------- this method is used to withdraw reward points
                                controller.withdrawRewardPoints();
                              },
                              child: Container(
                                  width: Get.width,
                                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 8),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: const GradientBoxBorder(
                                          gradient: AppColors.primaryGradient,
                                          width: 1
                                      )
                                  ),
                                  child: Text(
                                    "Withdraw",
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.appTextStyle(
                                        textColor: const Color(0xfff80261),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14
                                    ),
                                  )
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Gap(32),
                    controller.isLoading ? const Padding(
                      padding: EdgeInsetsDirectional.symmetric(vertical: 100),
                      child: Center(
                        child: CircularProgressIndicator(color: AppColors.colorDarkA),
                      ),
                    ) : controller.rewardList.isEmpty ? Padding(
                      padding: const EdgeInsetsDirectional.symmetric(vertical: 100),
                      child: Center(
                        child: Text(
                          "No Reward History found",
                          textAlign: TextAlign.center,
                          style: AppTextStyle.appTextStyle(
                              textColor: AppColors.colorDarkA,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ) : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(controller.rewardList.length, (index) => Padding(
                        padding: const EdgeInsetsDirectional.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${controller.rewardList[index].totalPoints ?? 0} Reward Balance",
                              style: AppTextStyle.appTextStyle(
                                  textColor: AppColors.colorDarkA,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16
                              ),
                            ),
                            const Gap(4),
                            Row(children: [
                              Container(
                                  height: 4,
                                  width: 4,
                                  decoration: BoxDecoration(
                                      color: AppColors.colorDarkA.withOpacity(0.5),
                                      shape: BoxShape.circle
                                  )
                              ),
                              const Gap(8),
                              Text(
                                  controller.rewardList[index].date ?? "",
                                  style: AppTextStyle.appTextStyle(
                                      textColor: AppColors.colorDarkA.withOpacity(0.5),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400
                                  )
                              ),
                            ])
                          ],
                        ),
                      )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
