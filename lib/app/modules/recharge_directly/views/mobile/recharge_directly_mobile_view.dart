import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_static_text.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/recharge_directly/controllers/recharge_directly_controller.dart';
import 'package:ilu/app/widgets/buttons/custom_button.dart';
import 'package:ilu/app/widgets/buttons/custom_loading_button.dart';
import 'package:ilu/app/widgets/text_form_field/custom_text_form_field.dart';

class RechargeDirectlyMobileView extends StatefulWidget {
  const RechargeDirectlyMobileView({super.key});

  @override
  State<RechargeDirectlyMobileView> createState() => _RechargeDirectlyMobileViewState();
}

class _RechargeDirectlyMobileViewState extends State<RechargeDirectlyMobileView> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<RechargeDirectlyController>(
        builder: (controller) {
          return Scaffold(
            backgroundColor: AppColors.colorWhite,
            /// ---------------- appbar
            appBar: AppBar(
              backgroundColor: AppColors.colorWhite,
              leading: IconButton(
                onPressed: () => Get.back(),
                icon: SvgPicture.asset(AppIcons.arrowBack),
                iconSize: 20,
              ),
              centerTitle: true,
              title: Text(
                AppStaticText.rechargeDirectly.tr,
                style: AppTextStyle.appTextStyle(
                    textColor: AppColors.colorDarkA,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                ),
              ),
            ),
            /// ---------------- body
            body: SingleChildScrollView(
              padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ---------------------- recharge amount form
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// ------------------- filed label
                        Text(
                          "Recharge Amount",
                          style: AppTextStyle.appTextStyle(
                              textColor: AppColors.colorDarkA,
                              fontWeight: FontWeight.w600,
                              fontSize: 14
                          ),
                        ),
                        const Gap(8),
                        /// ------------------- recharge amount field
                        CustomTextFormField(
                          textEditingController: controller.rechargeAmountController,
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          hintText: "Enter your recharge amount",
                          formValidator: (value){
                            if(value.isEmpty){
                              return "Please enter recharge amount";
                            }else{
                              return null;
                            }
                          },
                        ),
                        const Gap(4),
                        Text(
                          AppStaticText.rechargeDirectlyNote.tr,
                          textAlign: TextAlign.start,
                          style: AppTextStyle.appTextStyle(
                            textColor: AppColors.colorDarkB.withOpacity(0.6),
                            fontWeight: FontWeight.w400,
                            fontSize: 12
                          ),
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
                child: /// ------------------ proceed to payment button
                controller.isSubmit ? const CustomLoadingButton() : CustomButton(
                    onPressed: (){
                      if(formKey.currentState!.validate()){

                      }
                    },
                    buttonText: "Proceed to Payment"
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
