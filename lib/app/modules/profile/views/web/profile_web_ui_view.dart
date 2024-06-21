import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:gradient_icon/gradient_icon.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/profile/controllers/profile_controller.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:ilu/app/widgets/bottom_nav/main_bottom_nav.dart';
import 'package:ilu/app/widgets/buttons/custom_button.dart';
import 'package:ilu/app/widgets/buttons/custom_outline_button.dart';
import 'package:ilu/app/widgets/card/menu_profile_card.dart';
import 'package:ilu/app/widgets/dialog/custom_dialog.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ProfileWebUiView extends StatelessWidget {
  const ProfileWebUiView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<ProfileController>(builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.colorWhite,
          body: Column(
            children: [
              // todo -> appbar
              Container(
                width: 600,
                padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 24),
                color: AppColors.colorWhite,
                child: GradientText(
                    "Profile",
                    style: AppTextStyle.appTextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
                    colors: const [
                      Color(0xffFF597B),
                      Color(0xffF5827A),
                    ]
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 24),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: 600,
                      child: Column(
                        children: [
                          /// -------------------- profile top section
                          Container(
                            width: Get.width,
                            padding: const EdgeInsetsDirectional.symmetric(vertical: 12, horizontal: 12),
                            decoration: BoxDecoration(
                                color: AppColors.colorWhite,
                                borderRadius: BorderRadius.circular(8),
                                border: const GradientBoxBorder(
                                    gradient: AppColors.primaryGradient, width: 1
                                )
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    /// --------------------- available recharge balance
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "Recharge Balance",
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
                                                  height: 24, width: 24,
                                                  child: SvgPicture.asset(AppIcons.iluCoin)
                                              ),
                                              const Gap(8),
                                              GradientText(
                                                  controller.rechargeBalance,
                                                  style: AppTextStyle.appTextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w700
                                                  ),
                                                  colors: const [
                                                    Color(0xffFFD000),
                                                    Color(0xffF80261),
                                                    Color(0xff7017FF)
                                                  ]
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Gap(8),
                                    /// --------------------- available reward points
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              "Reward Balance",
                                              style: AppTextStyle.appTextStyle(
                                                  textColor: AppColors.colorDarkB,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400
                                              )
                                          ),
                                          const Gap(8),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                  height: 24, width: 24,
                                                  child: SvgPicture.asset("assets/icons/reward_point.svg", color: const Color(0xfff80261))
                                              ),
                                              const Gap(8),
                                              Text(
                                                controller.rewardPoint,
                                                textAlign: TextAlign.center,
                                                style: AppTextStyle.appTextStyle(
                                                    textColor: const Color(0xfff80261),
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                /// --------------------- divider ------------------------
                                const Gap(16),
                                Divider(color: AppColors.colorDarkA.withOpacity(0.2), height: 1,),
                                const Gap(16),
                                /// --------------------- divider close ------------------

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: InkWell(
                                        hoverColor: AppColors.colorRedB,
                                        borderRadius: BorderRadius.circular(8),
                                        onTap: (){
                                          /// ------------------ recharge balance button bottom sheet
                                          /// ------------------ recharge balance button bottom sheet
                                          showDialog(
                                              context: context,
                                              builder: (context) => CustomDialog(
                                                width: 400,
                                                dialogChild: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
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
                                          width: Get.width,
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
                                                fontSize: 14
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Gap(8),
                                    /// ------------------- reward point button
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
                                )
                              ],
                            ),
                          ),
                          const Gap(20),

                          // todo -> edit profile
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      controller.username,
                                      style: AppTextStyle.appTextStyle(
                                          textColor: AppColors.colorDarkA,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600
                                      )
                                  ),
                                  const Gap(8),
                                  Text(
                                      controller.userAge,
                                      style: AppTextStyle.appTextStyle(
                                          textColor: AppColors.colorDarkA,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400
                                      )
                                  ),
                                ],
                              ),
                              // todo -> edit profile button
                              InkWell(
                                hoverColor: AppColors.colorWhite,
                                borderRadius: BorderRadius.circular(99),
                                onTap: (){
                                  Get.toNamed(Routes.EDIT_PROFILE);
                                },
                                child: Container(
                                  padding: const EdgeInsetsDirectional.symmetric(
                                      vertical: 12, horizontal: 12),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: AppColors.colorWhite,
                                      borderRadius: BorderRadius.circular(99),
                                      border: const GradientBoxBorder(
                                          gradient: AppColors.primaryGradient, width: 1)),
                                  child: GradientText("Edit Profile",
                                      style: AppTextStyle.appTextStyle(
                                          fontSize: 14.0, fontWeight: FontWeight.w500),
                                      colors: const [
                                        Color(0xffFFD000),
                                        Color(0xffF80261),
                                        Color(0xff7017FF)
                                      ]),
                                ),
                              ),
                            ],
                          ),
                          const Gap(20),

                          // my timeline
                          InkWell(
                            hoverColor: AppColors.colorWhite,
                            borderRadius: BorderRadius.circular(99),
                            onTap: () {
                              Get.toNamed(Routes.MY_TIMELINE);
                            },
                            child: Container(
                              width: Get.width,
                              padding: const EdgeInsetsDirectional.symmetric(
                                  vertical: 12, horizontal: 12),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColors.colorWhite,
                                  borderRadius: BorderRadius.circular(99),
                                  border: const GradientBoxBorder(
                                      gradient: AppColors.primaryGradient, width: 1)),
                              child: GradientText("My Timeline",
                                  style: AppTextStyle.appTextStyle(
                                      fontSize: 14.0, fontWeight: FontWeight.w500),
                                  colors: const [
                                    Color(0xffFFD000),
                                    Color(0xffF80261),
                                    Color(0xff7017FF)
                                  ]),
                            ),
                          ),
                          const Gap(20),

                          // upload photo
                          controller.profileImages.isNotEmpty ? GridView.builder(
                              shrinkWrap: true,
                              itemCount: 5,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.zero,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  mainAxisExtent: 135
                              ),
                              itemBuilder: (context, index) => index < controller.profileImages.length ? Container(
                                width: Get.width,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "${ApiUrlContainer.baseUrl}${controller.profileImages[index].file.toString()}"),
                                        fit: BoxFit.contain,
                                        filterQuality:
                                        FilterQuality.medium),
                                    borderRadius:
                                    BorderRadius.circular(12),
                                    border: const GradientBoxBorder(
                                        gradient:
                                        AppColors.primaryGradient,
                                        width: 2)),
                              )
                                  : InkWell(
                                hoverColor: AppColors.colorWhite,
                                borderRadius: BorderRadius.circular(12),
                                onTap: () => Get.toNamed(Routes.EDIT_PROFILE),
                                child: DottedBorder(
                                  color: Colors.redAccent,
                                  dashPattern: const [5, 5],
                                  radius: const Radius.circular(12),
                                  borderType: BorderType.RRect,
                                  child: Container(
                                    width: Get.width,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: AppColors.colorRedB,
                                        borderRadius:
                                        BorderRadius.circular(12)),
                                    child: const GradientIcon(
                                        icon: Icons.add,
                                        offset: Offset(0, 0),
                                        gradient:
                                        AppColors.primaryGradient,
                                        size: 24),
                                  ),
                                ),
                              )
                          ) : GridView.builder(
                            shrinkWrap: true,
                            itemCount: 5,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.zero,
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                mainAxisExtent: 135
                            ),
                            itemBuilder: (context, index) => InkWell(
                              hoverColor: AppColors.colorWhite,
                              borderRadius: BorderRadius.circular(12),
                              onTap: () => Get.toNamed(Routes.EDIT_PROFILE),
                              child: DottedBorder(
                                color: Colors.redAccent,
                                dashPattern: const [5, 5],
                                radius: const Radius.circular(12),
                                borderType: BorderType.RRect,
                                child: Container(
                                  width: Get.width,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: AppColors.colorRedB,
                                      borderRadius:
                                      BorderRadius.circular(12)),
                                  child: const GradientIcon(
                                      icon: Icons.add,
                                      offset: Offset(0, 0),
                                      gradient: AppColors.primaryGradient,
                                      size: 24),
                                ),
                              ),
                            ),
                          ),
                          const Gap(20),

                          // profile menu list
                          MenuProfileCard(
                              onPressed: () => Get.toNamed(Routes.FAVORITE_LIST),
                              leadingImage: AppIcons.favorite,
                              titleText: "Favorite List"),
                          const Gap(8),
                          MenuProfileCard(
                            onPressed: () => Get.toNamed(Routes.CALL_HISTORY),
                            leadingImage: AppIcons.verifyContactField,
                            titleText: "Call History"
                          ),
                          const Gap(8),
                          MenuProfileCard(
                              onPressed: () {
                                Get.toNamed(Routes.PURCHASE_HISTORY);
                              },
                              leadingImage: AppIcons.purchase,
                              titleText: "Recharge History"),
                          const Gap(8),
                          // reward history
                          MenuProfileCard(
                              onPressed: () => Get.toNamed(Routes.REWARD_HISTORY),
                              leadingImage: AppIcons.rewardHistory,
                              titleText: "Reward History"
                          ),
                          const Gap(8),
                          MenuProfileCard(
                              onPressed: () => Get.toNamed(Routes.WITHDRAW_HISTORY),
                              leadingImage: AppIcons.purchase,
                              titleText: "Withdraw History"
                          ),
                          const Gap(8),
                          MenuProfileCard(
                              onPressed: (){
                                Get.toNamed(Routes.ABOUT_US);
                              },
                              leadingImage: AppIcons.aboutUs,
                              titleText: "About Us"
                          ),
                          const Gap(8),
                          MenuProfileCard(
                              onPressed: () {
                                Get.toNamed(Routes.ACCOUNT_SETTINGS);
                              },
                              leadingImage: AppIcons.accountSetting,
                              titleText: "Account Setting"
                          ),
                          const Gap(8),
                          MenuProfileCard(
                              onPressed: () {
                                Get.toNamed(Routes.NOTIFICATION_SETTINGS);
                              },
                              leadingImage: AppIcons.bellInactive,
                              titleText: "Notification"
                          ),
                          const Gap(8),
                          MenuProfileCard(
                              onPressed: () {
                                Get.toNamed(Routes.PRIVACY_POLICY);
                              },
                              leadingImage: AppIcons.privacy,
                              titleText: "Privacy Policy"
                          ),
                          const Gap(8),
                          MenuProfileCard(
                              onPressed: () {
                                Get.toNamed(Routes.HELP_AND_SUPPORT);
                              },
                              leadingImage: AppIcons.helpSupport,
                              titleText: "Help & Support"),
                          const Gap(8),
                          MenuProfileCard(
                              onPressed: () {
                                Get.toNamed(Routes.TERMS_AND_CONDITIONS);
                              },
                              leadingImage: AppIcons.terms,
                              titleText: "Terms & Conditions"),
                          const Gap(8),
                          MenuProfileCard(
                              onPressed: () => Get.toNamed(Routes.BLOCK_LIST),
                              leadingImage: AppIcons.blockUser,
                              titleText: "Block List"),
                          const Gap(8),
                          MenuProfileCard(
                              onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) => CustomDialog(
                                    width: 425,
                                    dialogChild: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Ready to Say Goodbye?",
                                          textAlign: TextAlign.center,
                                          style: AppTextStyle.appTextStyle(
                                              textColor: AppColors.colorDarkA,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const Gap(24),
                                        Text(
                                          "We're here whenever you're ready to come back, but if you're sure you want to log out, just tap the button below.",
                                          textAlign: TextAlign.center,
                                          style: AppTextStyle.appTextStyle(
                                              textColor: AppColors.colorDarkB,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        const Gap(24),
                                        CustomButton(
                                            onPressed: () {
                                              controller.logoutUser();
                                            },
                                            buttonText: "Logout"
                                        ),
                                        const Gap(20),
                                        CustomOutlineButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            buttonText: "Cancel"
                                        )
                                      ],
                                    ),
                                  )
                              ),
                              leadingImage: AppIcons.logout,
                              titleText: "Logout"
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          bottomNavigationBar: const MainBottomNav(currentScreen: 4, isWeb: true),
        );
      }),
    );
  }
}
