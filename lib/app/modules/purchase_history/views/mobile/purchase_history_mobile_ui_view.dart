import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/purchase_history/controllers/purchase_history_controller.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:ilu/app/widgets/buttons/custom_button.dart';

class PurchaseHistoryMobileUiView extends StatelessWidget {
  const PurchaseHistoryMobileUiView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<PurchaseHistoryController>(builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.colorWhite,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.colorWhite,
            leading: IconButton(
                onPressed: () => Get.back(),
                alignment: Alignment.center,
                icon: SvgPicture.asset(AppIcons.arrowBack),
                iconSize: 20
            ),
            title: Text(
              "Recharge History",
              textAlign: TextAlign.center,
              style: AppTextStyle.appTextStyle(
                  textColor: AppColors.colorDarkA,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            titleSpacing: 0,
            actions: [
              /// ------------------------ recharge button
              InkWell(
                hoverColor: AppColors.colorRedB,
                borderRadius: BorderRadius.circular(8),
                onTap: (){
                  /// ------------------ recharge balance button bottom sheet
                  showModalBottomSheet(
                      context: context,
                      backgroundColor: AppColors.colorWhite,
                      constraints: const BoxConstraints(maxHeight: 250),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                      ),
                      builder: (context) => Container(
                        width: Get.width,
                        padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 24),
                        decoration: BoxDecoration(
                            color: AppColors.colorWhite,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 5,
                                width: 75,
                                decoration: BoxDecoration(
                                    color: AppColors.colorDarkA.withOpacity(0.2),
                                    borderRadius:
                                    BorderRadius.circular(12)
                                ),
                              ),
                            ),
                            const Gap(20),
                            Text(
                              "Recharge Balance",
                              style: AppTextStyle.appTextStyle(
                                  textColor: AppColors.colorDarkA,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            const Gap(20),
                            CustomButton(
                                onPressed: (){
                                  Get.back();
                                  Get.toNamed(Routes.RECHARGE_DIRECTLY);
                                },
                                buttonText: "Recharge Directly"
                            ),
                            const Gap(12),
                            CustomButton(
                                onPressed: (){
                                  Get.back();
                                  Get.toNamed(Routes.RECHARGE_FROM_REWARD_BALANCE);
                                },
                                buttonText: "Recharge From Reward Balance"
                            ),
                          ],
                        ),
                      )
                  );
                },
                child: Container(
                  height: 36,
                  width: 100,
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xff7017FF),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Text(
                    "Recharge",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.appTextStyle(
                        textColor: AppColors.colorWhite,
                        fontWeight: FontWeight.w700,
                        fontSize: 12
                    ),
                  ),
                ),
              ),
              const Gap(24)
            ],
          ),
          body: controller.isLoading ? const Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              color: AppColors.colorDarkA,
            ),
          ) : controller.rechargeHistories.isEmpty ? Align(
            alignment: Alignment.center,
            child: Text(
              "No Purchase History Available",
              textAlign: TextAlign.center,
              style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkA, fontSize: 16, fontWeight: FontWeight.w600),
            )
          ) : SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 24),
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.rechargeHistories.length,
              separatorBuilder: (context, index) => const Gap(8),
              itemBuilder: (context, index) => Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        controller.rechargeHistories[index].isPurchaseFromReward == true ? Text(
                          "Recharge from Rewards",
                          style: AppTextStyle.appTextStyle(
                              textColor: AppColors.colorDarkA,
                              fontSize: 14,
                              fontWeight: FontWeight.w400
                          ),
                        ) : Text(
                          "Recharge Directly",
                          style: AppTextStyle.appTextStyle(
                              textColor: AppColors.colorDarkA,
                              fontSize: 14,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        const Gap(8),
                        Row(
                          children: [
                            SizedBox(
                                height: 24, width: 24,
                                child: SvgPicture.asset(AppIcons.iluCoin)
                            ),
                            const Gap(8),
                            Text(
                              "${controller.rechargeHistories[index].amount}",
                              style: AppTextStyle.appTextStyle(
                                  textColor: AppColors.colorDarkA,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Gap(12),
                  Flexible(
                    child: Text(
                      controller.formatDateTime(controller.rechargeHistories[index].createdAt ?? ""),
                      style: AppTextStyle.appTextStyle(
                          textColor: AppColors.colorDarkB,
                          fontWeight: FontWeight.w500,
                          fontSize: 12
                      ),
                    ),
                  )
                ],
              )
            ),
          ),
        );
      }),
    );
  }
}
