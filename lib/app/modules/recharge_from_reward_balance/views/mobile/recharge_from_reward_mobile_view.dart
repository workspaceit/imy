import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_static_text.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/recharge_from_reward_balance/controllers/recharge_from_reward_balance_controller.dart';
import 'package:ilu/app/widgets/buttons/custom_button.dart';
import 'package:ilu/app/widgets/buttons/custom_loading_button.dart';
import 'package:ilu/app/widgets/text_form_field/custom_text_form_field.dart';

class RechargeFromRewardMobileView extends StatefulWidget {

  const RechargeFromRewardMobileView({super.key});

  @override
  State<RechargeFromRewardMobileView> createState() => _RechargeFromRewardMobileViewState();
}

class _RechargeFromRewardMobileViewState extends State<RechargeFromRewardMobileView> {

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<RechargeFromRewardBalanceController>(
        builder: (controller) {
          return Scaffold(
            backgroundColor: AppColors.colorWhite,
            appBar: AppBar(
              backgroundColor: AppColors.colorWhite,
              leading: IconButton(
                onPressed: () => Get.back(),
                icon: SvgPicture.asset(AppIcons.arrowBack),
                iconSize: 20,
              ),
              centerTitle: true,
              title: Text(
                AppStaticText.rechargeFromRewardBalance.tr,
                style: AppTextStyle.appTextStyle(
                  textColor: AppColors.colorDarkA,
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Recharge Amount",
                          style: AppTextStyle.appTextStyle(
                              textColor: AppColors.colorDarkA,
                              fontWeight: FontWeight.w600,
                              fontSize: 14
                          ),
                        ),
                        const Gap(8),
                        CustomTextFormField(
                          textEditingController: controller.rechargeAmountController,
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          hintText: "Enter your reward balance to recharge",
                          formValidator: (value){
                            if(value.isEmpty){
                              return "Please enter your reward balance to recharge";
                            }else{
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            bottomNavigationBar: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Container(
                width: Get.width,
                padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 24),
                alignment: Alignment.center,
                color: AppColors.colorWhite,
                child: controller.isSubmit ? const CustomLoadingButton() : CustomButton(
                  onPressed: (){
                    if(formKey.currentState!.validate()){
                      controller.rechargeFromRewardPoints();
                    }
                  },
                  buttonText: "Recharge"
                )
              ),
            ),
          );
        }
      ),
    );
  }
}
