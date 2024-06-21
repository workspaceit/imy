import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/account_settings/controllers/account_settings_controller.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:ilu/app/widgets/buttons/custom_button.dart';
import 'package:ilu/app/widgets/buttons/custom_loading_button.dart';
import 'package:ilu/app/widgets/text_form_field/custom_text_form_field.dart';

class AccountSettingsWebUiView extends StatefulWidget {
  const AccountSettingsWebUiView({super.key});

  @override
  State<AccountSettingsWebUiView> createState() => _AccountSettingsWebUiViewState();
}

class _AccountSettingsWebUiViewState extends State<AccountSettingsWebUiView> {

  final changePasswordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<AccountSettingsController>(
        builder: (controller) => Scaffold(
          backgroundColor: AppColors.colorWhite,
          /// --------------------- appbar ----------------------------
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.colorWhite,
            leading: IconButton(
                onPressed: () => Get.toNamed(Routes.PROFILE),
                alignment: Alignment.center,
                icon: SvgPicture.asset(AppIcons.arrowBack),
                iconSize: 24),
            title: Text(
              "Account Settings",
              textAlign: TextAlign.center,
              style: AppTextStyle.appTextStyle(
                  textColor: AppColors.colorDarkA,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            actions: const [
              /// ----------------------- save button --------------------
              // Padding(
              //   padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
              //   child: TextButton(
              //       onPressed: (){},
              //       child: GradientText("Save",
              //           style: AppTextStyle.appTextStyle(
              //               fontSize: 16.0, fontWeight: FontWeight.w500
              //           ),
              //           colors: const [
              //             Color(0xffFFD000),
              //             Color(0xffF80261),
              //             Color(0xff7017FF)
              //           ])
              //   ),
              // )
            ],
          ),
          /// --------------------- body ------------------------------
          body: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(vertical: 24, horizontal: 20),
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 600,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// ---------------------- contact information ------------------------
                    // Text(
                    //   "Contact information",
                    //   style: AppTextStyle.appTextStyle(
                    //       textColor: AppColors.colorDarkA,
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w600
                    //   ),
                    // ),
                    // const Gap(12),
                    // Text(
                    //   "Stay connected! Share your preferred contact information, ensuring seamless communication.",
                    //   style: AppTextStyle.appTextStyle(
                    //       fontWeight: FontWeight.w400,
                    //       fontSize: 14,
                    //       textColor: AppColors.colorDarkB
                    //   ),
                    // ),
                    // const Gap(20),
                    // Form(
                    //   child: Column(
                    //     children: [
                    //       controller.isCaller == true ? Column(
                    //         children: [
                    //           CustomTextFormField(
                    //             textInputAction: TextInputAction.next,
                    //             textInputType: TextInputType.emailAddress,
                    //             textEditingController: controller.emailController,
                    //             hintText: AppStaticText.enterYourEmail,
                    //             prefixIcon: Padding(
                    //               padding: const EdgeInsetsDirectional.only(
                    //                   start: 12, top: 16, bottom: 16, end: 8),
                    //               child: SvgPicture.asset(AppIcons.verifyEmailField),
                    //             ),
                    //             formValidator: (value) {},
                    //           ),
                    //           const Gap(12),
                    //         ],
                    //       ) : const SizedBox(),
                    //       Row(
                    //         children: [
                    //           Expanded(
                    //             flex: 1,
                    //             child: CustomTextFormField(
                    //               readOnly: true,
                    //               textInputAction: TextInputAction.next,
                    //               textEditingController: controller.dialCodeController,
                    //               hintText: "Country Code",
                    //               suffixIcon: const Icon(Icons.keyboard_arrow_down,
                    //                   color: AppColors.colorDarkB),
                    //               onTap: () => CustomBottomSheet.customBottomSheet(
                    //                   context: context,
                    //                   isDialCode: true,
                    //                   child: Column(
                    //                     children: [
                    //                       Align(
                    //                         alignment: Alignment.center,
                    //                         child: Container(
                    //                           height: 5,
                    //                           width: 75,
                    //                           decoration: BoxDecoration(
                    //                               color: AppColors.colorGrayB,
                    //                               borderRadius: BorderRadius.circular(12)),
                    //                         ),
                    //                       ),
                    //                       const Gap(16),
                    //                       Row(
                    //                         mainAxisAlignment: MainAxisAlignment.start,
                    //                         children: [
                    //                           Text(
                    //                             "Country Code",
                    //                             textAlign: TextAlign.left,
                    //                             style: AppTextStyle.appTextStyle(
                    //                                 textColor: AppColors.colorDarkA,
                    //                                 fontSize: 16,
                    //                                 fontWeight: FontWeight.w600),
                    //                           )
                    //                         ],
                    //                       ),
                    //                       const Gap(16),
                    //                       Expanded(
                    //                         child: SingleChildScrollView(
                    //                           physics: const BouncingScrollPhysics(),
                    //                           child: Column(
                    //                             crossAxisAlignment: CrossAxisAlignment.start,
                    //                             children: List.generate(
                    //                                 controller.phoneCodeList.length,
                    //                                     (index) => GestureDetector(
                    //                                   onTap: () =>
                    //                                       controller.changeCallerPhoneCode(index),
                    //                                   child: Container(
                    //                                     padding: const EdgeInsetsDirectional.symmetric(
                    //                                         horizontal: 12, vertical: 12),
                    //                                     margin: const EdgeInsetsDirectional.only(bottom: 8),
                    //                                     width: MediaQuery.of(context).size.width,
                    //                                     decoration: BoxDecoration(
                    //                                         borderRadius: BorderRadius.circular(12),
                    //                                         border: Border.all(
                    //                                             color: AppColors.colorGrayB, width: 1)),
                    //                                     child: Row(
                    //                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                                       children: [
                    //                                         Text(
                    //                                           controller.phoneCodeList[index].countryName,
                    //                                           style: AppTextStyle.appTextStyle(
                    //                                               textColor: AppColors.colorDarkB,
                    //                                               fontSize: 14,
                    //                                               fontWeight: FontWeight.w400),
                    //                                         ),
                    //                                         Text(
                    //                                           controller.phoneCodeList[index].dialCode,
                    //                                           style: AppTextStyle.appTextStyle(
                    //                                               textColor: AppColors.colorDarkB,
                    //                                               fontSize: 14,
                    //                                               fontWeight: FontWeight.w400),
                    //                                         )
                    //                                       ],
                    //                                     ),
                    //                                   ),
                    //                                 )),
                    //                           ),
                    //                         ),
                    //                       )
                    //                     ],
                    //                   )
                    //               ),
                    //               formValidator: (value){
                    //                 if(value.isEmpty){
                    //                   return "Please, enter your country code number";
                    //                 }else{
                    //                   return null;
                    //                 }
                    //               },
                    //             ),
                    //           ),
                    //           const Gap(4),
                    //           Expanded(
                    //             flex: 2,
                    //             child: CustomTextFormField(
                    //               textInputAction: TextInputAction.next,
                    //               textInputType: TextInputType.number,
                    //               textEditingController: controller.contactController,
                    //               hintText: AppStaticText.enterYourContactNumber,
                    //               prefixIcon: Padding(
                    //                 padding: const EdgeInsetsDirectional.only(
                    //                     start: 12, top: 16, bottom: 16, end: 8),
                    //                 child: SvgPicture.asset(AppIcons.verifyContactField),
                    //               ),
                    //               formValidator: (value) {},
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // const Gap(20),
                    //
                    // // auto save
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Expanded(
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             "Auto Save",
                    //             style: AppTextStyle.appTextStyle(
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.w500,
                    //                 textColor: AppColors.colorDarkA
                    //             ),
                    //           ),
                    //           const Gap(4),
                    //           Text(
                    //             "Auto-save to gallery from the chat",
                    //             style: AppTextStyle.appTextStyle(
                    //                 fontSize: 14,
                    //                 fontWeight: FontWeight.w400,
                    //                 textColor: AppColors.colorDarkB
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //     const Gap(8),
                    //     controller.isSwitch ? GestureDetector(
                    //       onTap: () => controller.changeSwitch(),
                    //       child: Container(
                    //         width: 40,
                    //         height: 25,
                    //         alignment: Alignment.centerRight,
                    //         padding: const EdgeInsetsDirectional.only(end: 4, top: 2, bottom: 2),
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(12),
                    //             gradient: AppColors.primaryGradient
                    //         ),
                    //         child: Container(
                    //           height: 16, width: 16,
                    //           decoration: const BoxDecoration(
                    //               shape: BoxShape.circle,
                    //               color: AppColors.colorWhite
                    //           ),
                    //         ),
                    //       ),
                    //     ) : GestureDetector(
                    //       onTap: () => controller.changeSwitch(),
                    //       child: Container(
                    //         width: 40,
                    //         height: 25,
                    //         alignment: Alignment.centerLeft,
                    //         padding: const EdgeInsetsDirectional.only(start: 4, top: 2, bottom: 2),
                    //         decoration: BoxDecoration(
                    //             color: AppColors.colorGrayA,
                    //             borderRadius: BorderRadius.circular(12)
                    //         ),
                    //         child: Container(
                    //           height: 16, width: 16,
                    //           decoration: const BoxDecoration(
                    //               shape: BoxShape.circle,
                    //               color: AppColors.colorWhite
                    //           ),
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    // const Gap(20),

                    // change password

                    /// ---------------------- change password section -------------------
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// ------------- change password heading -------------------------
                        Text(
                          "Change Password",
                          style: AppTextStyle.appTextStyle(
                              textColor: AppColors.colorDarkA,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        const Gap(12),
                        /// -------------- change password sub content ------------------------
                        Text(
                          "Your password must contain at least 4 characters.",
                          style: AppTextStyle.appTextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              textColor: AppColors.colorDarkB
                          ),
                        ),
                        const Gap(20),
                        /// -------------- change password form -------------------------
                        Form(
                          key: changePasswordFormKey,
                          child: Column(
                            children: [
                              /// ------------ current password field -------------------
                              CustomTextFormField(
                                  isPassword: true,
                                  textEditingController: controller.currentPassController,
                                  textInputAction: TextInputAction.next,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 12, top: 16, bottom: 16, end: 8),
                                    child: SvgPicture.asset(AppIcons.passwordField),
                                  ),
                                  hintText: "Current password",
                                  formValidator: (value) {
                                    if(value.toString().isEmpty){
                                      return "Please enter your current password";
                                    }else if(value.toString().length < 4){
                                      return "Passwords must contain at least 4 characters";
                                    }else{
                                      return null;
                                    }
                                  }
                              ),
                              const Gap(12),
                              /// ------------ new password field ----------------------
                              CustomTextFormField(
                                isPassword: true,
                                textEditingController: controller.newPassController,
                                textInputAction: TextInputAction.next,
                                prefixIcon: Padding(
                                    padding: const EdgeInsetsDirectional.only(start: 12, top: 16, bottom: 16, end: 8),
                                    child: SvgPicture.asset(AppIcons.passwordField),
                                ),
                                hintText: "New password",
                                formValidator: (value) {
                                  if(value.toString().isEmpty){
                                    return "Please enter new password";
                                  }else if(value.toString().length < 4){
                                    return "Password must contain at least 4 characters";
                                  }else{
                                    return null;
                                  }
                                }
                              ),
                              const Gap(12),
                              /// ------------ confirm password field ------------------
                              CustomTextFormField(
                                  isPassword: true,
                                  textEditingController: controller.retypePassController,
                                  textInputAction: TextInputAction.done,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 12, top: 16, bottom: 16, end: 8),
                                    child: SvgPicture.asset(AppIcons.passwordField),
                                  ),
                                  hintText: "Re-type new password",
                                  formValidator: (value) {
                                    if(value.toString().isEmpty){
                                      return "Please re-enter password";
                                    }else if(value.toString().length < 4){
                                      return "Passwords must contain at least 4 characters";
                                    }else if(controller.newPassController.text != value){
                                      return "Passwords do not match";
                                    }else{
                                      return null;
                                    }
                                  }
                              ),
                              const Gap(20),
                              /// ------------ change password button ------------------
                              controller.isSubmit ? const CustomLoadingButton() : CustomButton(
                                onPressed: (){
                                  if(changePasswordFormKey.currentState!.validate()){
                                    controller.changePassword();
                                  }
                                },
                                buttonText: "Change Password"
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
}
