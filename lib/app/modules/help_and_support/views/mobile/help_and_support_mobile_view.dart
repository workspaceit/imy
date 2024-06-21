import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/help_and_support/controllers/help_and_support_controller.dart';
import 'package:ilu/app/widgets/buttons/custom_button.dart';
import 'package:ilu/app/widgets/text_form_field/custom_text_form_field.dart';

class HelpAndSupportMobileView extends StatelessWidget {
  const HelpAndSupportMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<HelpAndSupportController>(
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
              "Help & Support",
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
              children: [
                Text(
                  "Help & Support",
                  style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkA, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const Gap(12),
                Text(
                  "Need Assistance?\n\n"
                      "We're Here to Help! Welcome to IMY's Help & Support Center. "
                      "If you have any questions, concerns, or need assistance with anything related to the app, you're in the right place. "
                      "Our team is dedicated to ensuring you have a smooth and enjoyable experience on IMY.",
                  style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkB, fontSize: 14, fontWeight: FontWeight.w400),
                ),
                const Gap(12),

                Text(
                  "Frequently Asked Questions (FAQs)",
                  style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkA, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const Gap(12),
                Text(
                  "Browse through our comprehensive FAQs to find quick answers to common questions about using the app, profile setup, matching, chatting, and more.",
                  style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkB, fontSize: 14, fontWeight: FontWeight.w400),
                ),
                const Gap(12),

                Text(
                  "Contact Us",
                  style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkA, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const Gap(12),
                Text(
                  "If you can't find the information you're looking for in our FAQs, feel free to reach out to us directly. We're here to assist you with any specific inquiries you may have.\n\n"
                      "You can contact us through the app's 'Contact Support' feature or by emailing our support team at support@imy.com.",
                  style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkB, fontSize: 14, fontWeight: FontWeight.w400),
                ),
                const Gap(12),

                const CustomTextFormField(hintText: "Write message here"),
                const Gap(12),
                CustomButton(onPressed: (){}, buttonText: "Send"),
                const Gap(12),

                Text(
                  "User Safety and Privacy",
                  style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkA, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const Gap(12),
                Text(
                  "Your safety and privacy are our top priorities. If you encounter any suspicious behavior or need assistance with privacy settings, please let us know.\n\n"
                      "We take all concerns seriously and work diligently to ensure a safe and respectful environment for all users.",
                  style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkB, fontSize: 14, fontWeight: FontWeight.w400),
                ),
                const Gap(12),

                Text(
                  "App Feedback",
                  style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkA, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const Gap(12),
                Text(
                  "We value your feedback and suggestions for improving the app. If you have ideas for new features, improvements, or any other insights, please share them with us. Your input helps us enhance your IMY experience.",
                  style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkB, fontSize: 14, fontWeight: FontWeight.w400),
                ),
                const Gap(12),

                Text(
                  "Stay Connected",
                  style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkA, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const Gap(12),
                Text(
                  "Connect with us on social media to stay updated on app news, tips, and success stories. Follow us on Instagram, Twitter, and Facebook to join the IMY community.\n\n"
                      "At IMY, we're committed to providing you with an exceptional and enjoyable dating experience. Your journey is important to us, and we're here to support you every step of the way.",
                  style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkB, fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
