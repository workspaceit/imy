import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_static_text.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/core/utils/app_utils.dart';
import 'package:ilu/app/modules/registration/controllers/registration_controller.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:ilu/app/widgets/buttons/custom_button.dart';
import 'package:ilu/app/widgets/buttons/custom_loading_button.dart';
import 'package:ilu/app/widgets/buttons/custom_outline_button.dart';
import 'package:ilu/app/widgets/text_form_field/custom_text_form_field.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() =>
      _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
        builder: (controller) => Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ---------------- username field
              CustomTextFormField(
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                  textEditingController: controller.usernameController,
                  hintText: AppStaticText.username.tr,
                  prefixIcon: Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: 12, top: 16, bottom: 16, end: 8),
                    child: SvgPicture.asset(AppIcons.nameField),
                  ),
                formValidator: (value) {
                  if (value.isEmpty) {
                    return "Please enter username.";
                  } else if(
                  value.toString().contains("IMY") || value.toString().contains("IMy") || value.toString().contains("ImY")
                      || value.toString().contains("Imy") || value.toString().contains("imy") || value.toString().contains("iMY")
                      || value.toString().contains("imY")
                  ){
                    return "Username can not contain IMY";
                  } else if(RegExp(r'[!@#%^&*(),.?":{}|<>]').hasMatch(value)){
                    return "Username can not contain special characters";
                  } else if (RegExp(r'[0-9]').hasMatch(value)) {
                    return 'Username can not contain digits';
                  }else {
                    return null;
                  }
                },              ),
              const Gap(12),
              /// ---------------- gender field
              Column(
                  children: [
                    CustomTextFormField(
                      readOnly: true,
                      textInputAction: TextInputAction.next,
                      textEditingController: controller.genderController,
                      hintText: AppStaticText.gender.tr,
                      suffixIcon: const Icon(Icons.keyboard_arrow_down,
                          color: AppColors.colorDarkB),
                      onTap: () => controller.pickUserGender(context),
                      formValidator: (value) {
                        if (value.isEmpty) {
                          return "Please select gender.";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const Gap(4),
                    GradientText(AppStaticText.genderCannotChangeLater.tr,
                        style: AppTextStyle.appTextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.w400),
                        colors: const [
                          Color(0xffFF597B),
                          Color(0xffF5827A),
                        ]
                    ),
                  ],
                ),
              const Gap(12),
              /// ------------------ date of birth field
              Column(
                  children: [
                    CustomTextFormField(
                      readOnly: true,
                      textInputAction: TextInputAction.next,
                      textEditingController: controller.dobController,
                      hintText: AppStaticText.dateOfBirth.tr,
                      prefixIcon: Padding(
                        padding: const EdgeInsetsDirectional.only(
                            start: 12, top: 16, bottom: 16, end: 8),
                        child: SvgPicture.asset(AppIcons.calender),
                      ),
                      formValidator: (value) {
                        if (value.isEmpty) {
                          return "Your date of birth is required";
                        } else {
                          return null;
                        }
                      },
                      onTap: () => controller.pickUserDateOfBirth(context),
                    ),
                    const Gap(4),
                    GradientText(AppStaticText.ageMustBe.tr,
                        style: AppTextStyle.appTextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.w400),
                        colors: const [
                          Color(0xffFF597B),
                          Color(0xffF5827A),
                        ]
                    ),
                  ],
                ),
              const Gap(12),
              /// ------------------ country field
              CustomTextFormField(
                readOnly: true,
                textInputAction: TextInputAction.next,
                textEditingController: controller.countryController,
                hintText: AppStaticText.country.tr,
                suffixIcon: const Icon(Icons.keyboard_arrow_down, color: AppColors.colorDarkB),
                /// --------------------- country bottom sheet
                onTap: () => showModalBottomSheet(
                    backgroundColor: AppColors.colorWhite,
                    context: context,
                    builder: (context) => Padding(
                      padding: const EdgeInsetsDirectional.only(top: 12),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 5,
                              width: 75,
                              decoration: BoxDecoration(
                                  color: AppColors.colorDarkA.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                          const Gap(16),
                          Padding(
                            padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  AppStaticText.selectCountry.tr,
                                  textAlign: TextAlign.left,
                                  style: AppTextStyle.appTextStyle(
                                      textColor: AppColors.colorDarkA,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                          const Gap(16),
                          Flexible(
                            child: SingleChildScrollView(
                              padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(countries.length, (index) => GestureDetector(
                                      onTap: () => controller.chooseCountry(index),
                                      child: Container(
                                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
                                        margin: const EdgeInsetsDirectional.only(bottom: 8),
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(
                                                color: AppColors.colorGrayB, width: 1)),
                                        child: Text(
                                          countries[index].name,
                                          style: AppTextStyle.appTextStyle(
                                              textColor: AppColors.colorDarkB,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                ),
                formValidator: (value){
                  if(value.isEmpty){
                    return "Please select your country";
                  }else{
                    return null;
                  }
                },
              ),
              const Gap(12),
              /// ------------------ district field
              controller.countryController.text == "Bangladesh" ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    readOnly: true,
                    textInputAction: TextInputAction.next,
                    textEditingController: controller.districtController,
                    hintText: AppStaticText.district.tr,
                    suffixIcon: const Icon(Icons.keyboard_arrow_down,
                        color: AppColors.colorDarkB),
                    onTap: () => showModalBottomSheet(
                        backgroundColor: AppColors.colorWhite,
                        context: context,
                        builder: (context) => Padding(
                          padding: const EdgeInsetsDirectional.only(top: 12),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 5,
                                  width: 75,
                                  decoration: BoxDecoration(
                                      color: AppColors.colorDarkA.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                              const Gap(16),
                              Padding(
                                padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppStaticText.selectDistrict.tr,
                                      textAlign: TextAlign.left,
                                      style: AppTextStyle.appTextStyle(
                                          textColor: AppColors.colorDarkA,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                              const Gap(16),
                              Flexible(
                                child: SingleChildScrollView(
                                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
                                  physics: const BouncingScrollPhysics(),
                                  child: controller.isLoadingCity ? const Center(
                                    child: CircularProgressIndicator(color: AppColors.colorDarkA, strokeWidth: 3),
                                  ) : controller.cityList.isEmpty ? Center(
                                    child: Text(
                                      "No data found",
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.appTextStyle(
                                          textColor: AppColors.colorDarkA,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16
                                      ),
                                    ),
                                  ) : Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: List.generate(
                                        controller.cityList.length,
                                            (index) => GestureDetector(
                                          onTap: () =>
                                              controller.chooseCity(index),
                                          child: Container(
                                            padding: const EdgeInsetsDirectional.symmetric(
                                                horizontal: 12, vertical: 12),
                                            margin: const EdgeInsetsDirectional.only(bottom: 8),
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: AppColors.colorGrayB, width: 1)),
                                            child: Text(
                                              controller.cityList[index].name ?? "",
                                              style: AppTextStyle.appTextStyle(
                                                  textColor: AppColors.colorDarkB,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                    ),
                    formValidator: (value){
                      if(value.isEmpty){
                        return "Please select district";
                      }else{
                        return null;
                      }
                    },
                  ),
                  const Gap(12),
                ],
              ) : const SizedBox(),
              /// ------------------ email
              controller.countryController.text == "Bangladesh" ? const SizedBox() : CustomTextFormField(
                textEditingController: controller.emailController,
                hintText: AppStaticText.enterYourEmail.tr,
                prefixIcon: Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 16, vertical: 16),
                  child: SvgPicture.asset(AppIcons.verifyEmailField),
                ),
                formValidator: (value){
                  if(value.toString().isEmpty){
                    return "Please enter email";
                  }else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(controller.emailController.text)){
                    return "Please enter valid email";
                  }
                  return null;
                },
              ),
              const Gap(12),
              /// --------------------- phone number field
              controller.countryController.text == "Bangladesh" ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IntlPhoneField(
                    style: AppTextStyle.appTextStyle(
                        textColor: AppColors.colorDarkA,
                        fontWeight: FontWeight.w400,
                        fontSize: 14
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: controller.contactNumberController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: AppStaticText.enterYourContactNumber.tr,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(99),
                            borderSide: const BorderSide(
                                color: AppColors.colorGrayB, width: 1
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(99),
                            borderSide: const BorderSide(
                                color: AppColors.colorGrayB, width: 1
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(99),
                            borderSide: const BorderSide(
                                color: AppColors.colorDarkA, width: 1
                            )
                        )
                    ),
                    initialCountryCode: 'BD',
                    countries: const [
                      Country(
                        name: "Bangladesh",
                        nameTranslations: {
                          "en": "Bangladesh",
                          "bd": "বাংলাদেশ"
                        },
                        flag: "🇧🇩",
                        code: "BD",
                        dialCode: "880",
                        minLength: 10,
                        maxLength: 10,
                      ),
                    ],
                    onChanged: (phoneNumber) {
                      controller.dialCode = phoneNumber.countryCode;
                      controller.contactNumber = phoneNumber.number;
                    },
                    validator: (value){
                      if(value.toString().isEmpty){
                        return "Please enter number";
                      }else if(!RegExp(r'^0*(\d{3})-*(\d{3})-*(\d{4})$').hasMatch(value.toString())){
                        return "Please enter valid number";
                      }else{
                        return null;
                      }
                    },
                  ),
                  const Gap(12),
                ],
              ) : const SizedBox(),
              /// ------------------ password field
              CustomTextFormField(
                    isPassword: true,
                    textEditingController: controller.passwordController,
                    textInputAction: TextInputAction.next,
                    prefixIcon: Padding(
                      padding: const EdgeInsetsDirectional.only(
                          start: 12, top: 16, bottom: 16, end: 8),
                      child: SvgPicture.asset(AppIcons.passwordField),
                    ),
                    hintText: AppStaticText.enterYourPassword.tr,
                    onChanged: (value) => controller.checkPasswordLength(value),
                    formValidator: (value) {
                      if (value.isEmpty) {
                        return "Please enter password.";
                      } else if(value.toString().length < 4){
                        return "Password must contain at least 4 characters";
                      }else {
                        return null;
                      }
                    }),
              const Gap(12),
              /// ------------------ re-enter password field
              CustomTextFormField(
                    isPassword: true,
                    textEditingController:
                        controller.reenterPasswordController,
                    textInputAction: TextInputAction.done,
                    prefixIcon: Padding(
                      padding: const EdgeInsetsDirectional.only(
                          start: 12, top: 16, bottom: 16, end: 8),
                      child: SvgPicture.asset(AppIcons.passwordField),
                    ),
                    hintText: AppStaticText.reEnterYourPassword.tr,
                  formValidator: (value) {
                    if (value.isEmpty) {
                      return "Please re-enter password.";
                    } else if (controller.passwordController.text != controller.reenterPasswordController.text) {
                      return "Passwords do not match";
                    } else {
                      return null;
                    }
                  }),
              const Gap(20),
              /// ------------------ password length checker section
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(AppIcons.circleCheckbox,
                        height: 16, width: 16),
                    const Gap(8),
                    Text(
                      AppStaticText.mustBeAtLeastFourCharacters.tr,
                      style: AppTextStyle.appTextStyle(
                          textColor: controller.passwordLength > 4
                              ? CupertinoColors.systemGreen
                              : AppColors.colorDarkB,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              const Gap(48),
              /// ------------------ checkbox section
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Checkbox(
                        activeColor: AppColors.colorDarkA,
                        value: controller.rememberMe,
                        side: MaterialStateBorderSide.resolveWith(
                              (states) => BorderSide(
                              width: 1.0,
                              color: controller.rememberMe
                                  ? AppColors.colorDarkB
                                  : AppColors.colorDarkA),
                        ),
                        onChanged: (value) {
                          controller.changeRememberMe();
                        }),
                  ),
                  const Gap(8),
                  InkWell(
                      onTap: () => Get.toNamed(Routes.TERMS_AND_CONDITIONS),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Agree ",
                              style: AppTextStyle.appTextStyle(
                                  textColor: AppColors.colorDarkB,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)),
                          TextSpan(
                              text: "TERMS & CONDITIONS",
                              style: AppTextStyle.appTextStyle(
                                  textColor: Colors.redAccent,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700
                              )
                          )
                        ]
                        ),
                      )
                  )
                ],
              ),
              const Gap(20),
              /// ------------------proceed to registration
              controller.isSubmit ? const CustomLoadingButton() :  CustomButton(
                onPressed: () async{
                  if(controller.countryController.text == "Bangladesh"){
                    if(controller.contactNumber.isEmpty){
                      AppUtils.errorToastMessage("Please enter your contact number");
                    }else{
                      if(formKey.currentState!.validate()){
                        controller.rememberMe ? await controller.registerAsLocalUser() : AppUtils.errorToastMessage("You must agree to Terms & Conditions");
                      }
                    }
                  } else{
                    if(formKey.currentState!.validate()){
                      controller.rememberMe ? await controller.registerAsForeignUser() : AppUtils.errorToastMessage("You must agree to Terms & Conditions");
                    }
                  }
                },
                buttonText: AppStaticText.proceedToRegistration.tr
              ),
              const Gap(20),
              CustomOutlineButton(
                onPressed: () {
                  controller.clearReceiverFormData();
                  Get.offAndToNamed(Routes.LOGIN);
                },
                buttonText: AppStaticText.login.tr
              )
          ]
        )
      )
    );
  }
}
