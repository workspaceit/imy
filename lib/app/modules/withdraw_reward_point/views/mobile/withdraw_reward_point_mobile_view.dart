import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/withdraw_reward_point/controllers/withdraw_reward_point_controller.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:ilu/app/widgets/bottom_nav/auth_bottom_nav.dart';
import 'package:ilu/app/widgets/buttons/custom_button.dart';
import 'package:ilu/app/widgets/dialog/custom_dialog.dart';

class WithdrawRewardPointMobileView extends StatelessWidget {
  const WithdrawRewardPointMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<WithdrawRewardPointController>(
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
              "Reward Balance Withdraw",
              textAlign: TextAlign.center,
              style: AppTextStyle.appTextStyle(
                  textColor: AppColors.colorDarkA,
                  fontSize: 18,
                  fontWeight: FontWeight.w600
              ),
            ),
            centerTitle: true,
          ),
          body: controller.isLoading ? const Center(
            child: CircularProgressIndicator(color: AppColors.colorDarkA)
          ) : SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Payment Method",
                  style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkA, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const Gap(20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: controller.paymentMethodList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8, mainAxisExtent: 52),
                  itemBuilder: (context, index) => index == controller.selectedPayment ? Container(
                    width: Get.width,
                    padding: const EdgeInsetsDirectional.symmetric(vertical: 14, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: AppColors.primaryGradient
                    ),
                    child: Text(
                      controller.paymentMethodList[index],
                      style: AppTextStyle.appTextStyle(textColor: AppColors.colorWhite, fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ) : GestureDetector(
                    onTap: () => controller.selectPaymentMethod(index),
                    child: Container(
                      width: Get.width,
                      padding: const EdgeInsetsDirectional.symmetric(vertical: 14, horizontal: 20),
                      decoration: BoxDecoration(
                        color: AppColors.colorWhite,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.colorGrayB)
                      ),
                      child: Text(
                        controller.paymentMethodList[index],
                        style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkA, fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ),
                  )
                )
              ],
            ),
          ),
          bottomNavigationBar: controller.selectedPayment == -1 ? null : AuthBottomNav(
            bottomNavChild: CustomButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => CustomDialog(
                  dialogChild: Column(
                    children: [
                      Text(
                        "Withdraw Information",
                        style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkA, fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const Gap(20),
                      Text(
                        "You will be able to withdraw ${controller.rewardPoint} "
                        "Reward balance which is equivalent to ${(controller.rewardPoint) * 1} BDT.",
                        textAlign: TextAlign.center,
                        style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkB, fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                      const Gap(24),
                      CustomButton(
                        onPressed: (){
                          if(controller.selectedPayment == 0){
                            Get.back();
                            Get.offAndToNamed(Routes.BKASH_WITHDRAW);
                          }else if(controller.selectedPayment == 1){
                            Get.back();
                            Get.offAndToNamed(Routes.NAGAD_WITHDRAW);
                          }else{
                            
                          }
                        },
                        buttonText: "Proceed to Withdraw"
                      )
                    ],
                  ),
                )
              ),
              buttonText: "Proceed",
            ),
          ),
        )
      ),
    );
  }
}
