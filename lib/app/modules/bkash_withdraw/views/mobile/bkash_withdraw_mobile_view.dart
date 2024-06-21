import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/bkash_withdraw/controllers/bkash_withdraw_controller.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:ilu/app/widgets/bottom_nav/auth_bottom_nav.dart';
import 'package:ilu/app/widgets/buttons/custom_button.dart';
import 'package:ilu/app/widgets/buttons/custom_loading_button.dart';
import 'package:ilu/app/widgets/text_form_field/custom_text_form_field.dart';
import 'package:number_to_words_english/number_to_words_english.dart';

class BkashWithdrawMobileView extends StatelessWidget {
  const BkashWithdrawMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<BkashWithdrawController>(
        builder: (controller) => Scaffold(
          backgroundColor: AppColors.colorWhite,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.colorWhite,
            leading: IconButton(
                onPressed: () => Get.offAndToNamed(Routes.WITHDRAW_REWARD_POINT),
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
          body: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // todo -> heading
                Text(
                  "Bkash Information",
                  style: AppTextStyle.appTextStyle(
                    textColor: AppColors.colorDarkA,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),
                ),
                const Gap(20),
                Form(
                  key: controller.bkashForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // todo -> bkash username
                      CustomTextFormField(
                        hintText: "Bkash Username",
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                        textEditingController: controller.bkashUsernameController,
                        formValidator: (value) {
                          if(value.isEmpty){
                            return "Please enter bkash";
                          }
                          return null;
                        },
                      ),
                      const Gap(12),
                      // todo -> mobile wallet number
                      CustomTextFormField(
                        hintText: "Bkash Mobile Wallet Number",
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.number,
                        textEditingController: controller.mobileWalletController,
                        formValidator: (value) {
                          if(value.isEmpty){
                            return "Please enter mobile wallet number";
                          }
                          return null;
                        },
                      ),
                      const Gap(12),
                      // todo -> ilu profile id
                      CustomTextFormField(
                        hintText: "ILU Profile ID Number",
                        readOnly: true,
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        textEditingController: controller.iluProfileIdController,
                      ),
                      const Gap(12),
                      // todo -> amount
                      CustomTextFormField(
                        hintText: "Enter your withdraw amount",
                        fillColor: AppColors.colorWhite,
                        textEditingController: controller.amountController,
                        inputFormatter: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value){
                          if(value.isNotEmpty){
                            controller.amountTextController.text = NumberToWordsEnglish.convert(int.parse(value)).toString().trim();
                          }else{
                            controller.amountTextController.text = "";
                          }
                        },
                        formValidator: (value){
                          if(value.isEmpty){
                            return "Please enter withdraw amount";
                          }else if(int.parse(value.toString()) < controller.lowestWithdrawalAmount){
                            return "You could withdraw minimum ${controller.lowestWithdrawalAmount}";
                          }else{
                            return null;
                          }
                        }
                      ),
                      const Gap(4),
                      Text(
                        "Note: You can withdraw minimum ${controller.lowestWithdrawalAmount}",
                        textAlign: TextAlign.start,
                        style: AppTextStyle.appTextStyle(
                            textColor: AppColors.colorDarkB.withOpacity(0.6),
                            fontWeight: FontWeight.w400,
                            fontSize: 12
                        ),
                      ),
                      const Gap(12),
                      /// ---------------- amount in text field ------------
                      CustomTextFormField(
                        readOnly: true,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.text,
                        hintText: "Write amount in text",
                        textEditingController: controller.amountTextController,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: AuthBottomNav(
            bottomNavChild: controller.isSubmit ? const CustomLoadingButton() : CustomButton(
              onPressed: () {
                if(controller.bkashForm.currentState!.validate()){
                  controller.withdrawRewardPointFromBkash();
                }
              },
              buttonText: "Confirm",
            ),
          ),
        )
      ),
    );
  }
}
