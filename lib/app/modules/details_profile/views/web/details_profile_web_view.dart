import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_images.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/details_profile/controllers/details_profile_controller.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:ilu/app/widgets/buttons/custom_button.dart';
import 'package:ilu/app/widgets/buttons/custom_outline_button.dart';
import 'package:ilu/app/widgets/dialog/custom_dialog.dart';
import 'package:ilu/app/widgets/text_form_field/custom_text_form_field.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class DetailsProfileWebView extends StatelessWidget {
  const DetailsProfileWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<DetailsProfileController>(
          builder: (controller) => controller.isLoading ? const Scaffold(
            backgroundColor: AppColors.colorWhite,
            body: Center(
              child: CircularProgressIndicator(
                color: AppColors.colorDarkA,
              ),
            ),
          ) :  Scaffold(
            backgroundColor: AppColors.colorWhite,
            /// --------------------------- appbar -------------------------------
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 80,
              backgroundColor: AppColors.colorWhite,
              leading: IconButton(
                  onPressed: () => Get.toNamed(Routes.HOME),
                  alignment: Alignment.center,
                  icon: SvgPicture.asset(AppIcons.arrowBack),
                  iconSize: 24
              ),
              titleSpacing: 0,
              title: Row(
                children: [
                  controller.profileImages.isEmpty ? Container(
                    height: 42, width: 42,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(AppImages.iluImage),
                            fit: BoxFit.contain
                        ),
                        shape: BoxShape.circle
                    ),
                  ) : Container(
                    height: 42, width: 42,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("${ApiUrlContainer.baseUrl}${controller.profileImages[0].file}"),
                            fit: BoxFit.contain
                        ),
                        shape: BoxShape.circle
                    ),
                  ),
                  const Gap(8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// ------------------- ilu user name section ---------------
                        Text(
                          controller.username,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.appTextStyle(
                              textColor: AppColors.colorDarkA,
                              fontWeight: FontWeight.w600,
                              fontSize: 14
                          ),
                        ),
                        const Gap(4),
                        /// ------------------- ilu user id and age section ----------
                        Row(
                          children: [
                            Text("ID ${controller.userId}",
                                style: AppTextStyle.appTextStyle(
                                    textColor: AppColors.colorDarkB,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400
                                )
                            ),
                            const Gap(8),
                            Container(
                              height: 10,
                              width: 1,
                              color: AppColors.colorDarkB,
                            ),
                            const Gap(8),
                            Text("${controller.userAge} y",
                                style: AppTextStyle.appTextStyle(
                                    textColor: AppColors.colorDarkB,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400
                                )
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              actions: [
                /// ------------------- chat button --------------------------
                IconButton(
                  onPressed: (){
                    Get.toNamed(
                        Routes.CHAT,
                        arguments: [
                          controller.userProfileImage,
                          controller.username,
                          controller.repo.apiService.sharedPreferences.getString(LocalStorageHelper.currentUserIdKey) ?? "",
                          controller.receiverId,
                          controller.repo.apiService.sharedPreferences.getInt(LocalStorageHelper.detailsProfileUserIdKey)
                        ]
                    );
                  },
                  icon: Container(
                    height: 52, width: 52,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: AppColors.colorLightWhite,
                        shape: BoxShape.circle
                    ),
                    child: SvgPicture.asset(AppIcons.messageInactive, color: AppColors.colorDarkA),
                  ),
                ),
                const Gap(12),
                /// ------------------- audio call button --------------------
                IconButton(
                  onPressed: (){
                    controller.rechargeBalance < 2 ? controller.getCurrentUserData().then((value) => showDialog(
                        context: Get.context!,
                        builder: (_) => CustomDialog(
                          width: 400,
                          dialogChild: Align(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Unable to call!",
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.appTextStyle(
                                      textColor: AppColors.colorDarkA,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                                const Gap(12),
                                Text(
                                    "Sorry, You don't have enough Balance to call this person\nPlease Recharge first and enjoy calling.",
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.appTextStyle(
                                        textColor: AppColors.colorDarkA.withOpacity(0.6),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14
                                    )
                                ),
                                const Gap(20),
                                CustomButton(
                                    onPressed: (){
                                      Get.back();
                                      showDialog(
                                        context: Get.context!,
                                        builder: (_) => CustomDialog(
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
                                    buttonText: "Recharge Balance"
                                ),
                                const Gap(12),
                                CustomOutlineButton(
                                    onPressed: (){
                                      Get.back();
                                    },
                                    buttonText: "Close"
                                )
                              ],
                            ),
                          ),
                        ))) : controller.getCurrentUserData().then((value) =>
                        controller.fetchAgoraToken());
                  },
                  icon: Container(
                    height: 52, width: 52,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: AppColors.colorLightWhite,
                        shape: BoxShape.circle
                    ),
                    child: SvgPicture.asset(AppIcons.verifyContactField, color: AppColors.colorDarkA),
                  ),
                ),
                const Gap(12),
                /// ------------------- Popup menu button --------------------
                PopupMenuButton(
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 5, horizontal: 5),
                  elevation: 0,
                  constraints: const BoxConstraints(
                      maxWidth: 400
                  ),
                  offset: const Offset(0, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: AppColors.colorGrayB)
                  ),
                  color: AppColors.colorWhite,
                  child: Container(
                    height: 52, width: 52,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: AppColors.colorLightWhite,
                        shape: BoxShape.circle
                    ),
                    child: SvgPicture.asset(AppIcons.menu, color: AppColors.colorDarkA),
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                        padding: const EdgeInsets.only(top: 6, bottom: 6, left: 12, right: 12),
                        onTap: (){
                          controller.makeUserFavorite(controller.repo.apiService.sharedPreferences.getInt(LocalStorageHelper.detailsProfileUserIdKey) ?? -1);
                        },
                        child: Container(
                          width: Get.width,
                          alignment: Alignment.center,
                          padding: const EdgeInsetsDirectional.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                              color: AppColors.colorWhite,
                              border: Border.all(color: AppColors.colorGrayB, width: 1),
                              borderRadius: BorderRadius.circular(99)
                          ),
                          child: Text(
                            "Add to favorite",
                            textAlign: TextAlign.center,
                            style: AppTextStyle.appTextStyle(
                                textColor: AppColors.colorDarkB,
                                fontSize: 16, fontWeight: FontWeight.w600
                            ),
                          ),
                        )
                    ),
                    PopupMenuItem(
                      padding: const EdgeInsets.only(top: 6, bottom: 6, left: 12, right: 12),
                      onTap: (){
                        showDialog(
                            context: context,
                            builder: (context) => CustomDialog(
                              width: 400,
                              dialogChild:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Are you Sure that you want to Report this user?",
                                    style: AppTextStyle.appTextStyle(
                                        textColor: AppColors.colorDarkA,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  const Gap(24),
                                  const CustomTextFormField(hintText: "Reason to Report", maxLines: 4, radius: 12),
                                  const Gap(12),
                                  InkWell(
                                    borderRadius: BorderRadius.circular(99),
                                    hoverColor: AppColors.colorWhite,
                                    onTap: () => controller.reportUser(controller.repo.apiService.sharedPreferences.getInt(LocalStorageHelper.detailsProfileUserIdKey) ?? -1),
                                    child: Container(
                                        width: Get.width,
                                        padding: const EdgeInsetsDirectional.symmetric(
                                            horizontal: 16, vertical: 16),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: const GradientBoxBorder(gradient: AppColors.redGradient),
                                            borderRadius: BorderRadius.circular(99)
                                        ),
                                        child: GradientText(
                                          "Report",
                                          colors: const [Color(0xffFF597B),Color(0xffF5827A)],
                                          style: AppTextStyle.appTextStyle(
                                              fontSize: 16, fontWeight: FontWeight.w600
                                          ),
                                        )
                                    ),
                                  ),
                                  const Gap(12),
                                  CustomOutlineButton(onPressed: () => Get.back(), buttonText: "Close")
                                ],
                              ),
                            )
                        );
                      },
                      child: Container(
                        width: Get.width,
                        alignment: Alignment.center,
                        padding: const EdgeInsetsDirectional.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                            color: AppColors.colorWhite,
                            border: Border.all(color: AppColors.colorGrayB, width: 1),
                            borderRadius: BorderRadius.circular(99)
                        ),
                        child: Text(
                          "Report this user",
                          textAlign: TextAlign.center,
                          style: AppTextStyle.appTextStyle(
                              textColor: AppColors.colorDarkB,
                              fontSize: 16, fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                        padding: const EdgeInsets.only(top: 6, bottom: 6, left: 12, right: 12),
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (context) => CustomDialog(
                                width: 425,
                                dialogChild:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Are you Sure that you want to Block this user?",
                                      style: AppTextStyle.appTextStyle(
                                          textColor: AppColors.colorDarkA,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    const Gap(24),
                                    InkWell(
                                      borderRadius: BorderRadius.circular(99),
                                      hoverColor: AppColors.colorWhite,
                                      onTap: (){
                                        controller.makeUserBlock(controller.repo.apiService.sharedPreferences.getInt(LocalStorageHelper.detailsProfileUserIdKey) ?? -1);
                                      },
                                      child: Container(
                                          width: Get.width,
                                          padding: const EdgeInsetsDirectional.symmetric(
                                              horizontal: 16, vertical: 16
                                          ),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              border: const GradientBoxBorder(gradient: AppColors.redGradient),
                                              borderRadius: BorderRadius.circular(99)
                                          ),
                                          child: GradientText(
                                            "Block",
                                            colors: const [Color(0xffFF597B),Color(0xffF5827A)],
                                            style: AppTextStyle.appTextStyle(
                                                fontSize: 16, fontWeight: FontWeight.w600
                                            ),
                                          )
                                      ),
                                    ),
                                    const Gap(12),
                                    CustomOutlineButton(onPressed: () => Get.back(), buttonText: "Close")
                                  ],
                                ),
                              )
                          );
                        },
                        child: Container(
                          width: Get.width,
                          alignment: Alignment.center,
                          padding: const EdgeInsetsDirectional.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                              color: AppColors.colorWhite,
                              border: Border.all(color: AppColors.colorGrayB, width: 1),
                              borderRadius: BorderRadius.circular(99)
                          ),
                          child: Text(
                            "Block this user",
                            textAlign: TextAlign.center,
                            style: AppTextStyle.appTextStyle(
                                textColor: AppColors.colorDarkB,
                                fontSize: 16, fontWeight: FontWeight.w600
                            ),
                          ),
                        )
                    )
                  ],
                ),
                const Gap(40)
              ],
            ),
            /// -------------------------- body ----------------------------------
            body: SingleChildScrollView(
              padding: const EdgeInsetsDirectional.symmetric(vertical: 20),
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: 700,
                  child: Column(
                    children: [
                      /// ----------------- list of images -----------------------
                      controller.profileImages.isEmpty ? const SizedBox() : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// ---------------- previous button -------------------
                            IconButton(
                                onPressed: () => controller.carouselController.previousPage(),
                                icon: Container(
                                  height: 40, width: 40,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      color: AppColors.colorLightWhite,
                                      shape: BoxShape.circle
                                  ),
                                  child: const Icon(Icons.arrow_back_ios_new, color: AppColors.colorDarkA, size: 20),
                                )
                            ),
                            const Gap(20),
                            /// ----------------- images slider --------------------
                            Expanded(
                              child: controller.profileImages.length == 1 ? controller.favoriteCheckingArray[0] == 1 ? InkWell(
                                borderRadius: BorderRadius.circular(20),
                                hoverColor: AppColors.colorWhite,
                                onDoubleTap: () => controller.removeFavoriteProfileImage(0, profileImageId: controller.profileImages[0].id ?? -1),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 400, width: 600,
                                      margin: const EdgeInsetsDirectional.only(end: 20),
                                      decoration: BoxDecoration(
                                          color: AppColors.colorRedB,
                                          image: DecorationImage(
                                            image: NetworkImage("${ApiUrlContainer.baseUrl}${controller.profileImages[0].file}"),
                                            fit: BoxFit.contain,
                                          ),
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                    ),
                                    Positioned(
                                      top: 20, right: 48,
                                      child: Container(
                                        height: 40, width: 40,
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                            color: AppColors.colorWhite, shape: BoxShape.circle
                                        ),
                                        child: const Icon(Icons.favorite, color: Colors.redAccent, size: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ) : InkWell(
                                borderRadius: BorderRadius.circular(20),
                                hoverColor: AppColors.colorWhite,
                                onDoubleTap: () => controller.makeFavoriteProfileImage(0, profileImageId: controller.profileImages[0].id ?? -1),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 400, width: 600,
                                      margin: const EdgeInsetsDirectional.only(end: 20),
                                      decoration: BoxDecoration(
                                          color: AppColors.colorRedB,
                                          image: DecorationImage(
                                            image: NetworkImage("${ApiUrlContainer.baseUrl}${controller.profileImages[0].file}"),
                                            fit: BoxFit.contain,
                                          ),
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                    ),
                                    Positioned(
                                      top: 20, right: 48,
                                      child: Container(
                                        height: 40, width: 40,
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                            color: AppColors.colorWhite, shape: BoxShape.circle
                                        ),
                                        child: const Icon(Icons.favorite_border_rounded, color: Colors.redAccent, size: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ) : CarouselSlider(
                                carouselController: controller.carouselController,
                                items: List.generate(controller.profileImages.length, (index) => controller.favoriteCheckingArray[index] == 1 ?
                                InkWell(
                                  hoverColor: AppColors.colorWhite,
                                  borderRadius: BorderRadius.circular(20),
                                  onDoubleTap: () => controller.removeFavoriteProfileImage(index, profileImageId: controller.profileImages[index].id ?? -1),
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 400, width: 600,
                                        margin: const EdgeInsetsDirectional.only(end: 20),
                                        decoration: BoxDecoration(
                                            color: AppColors.colorRedB,
                                            image: DecorationImage(
                                              image: NetworkImage("${ApiUrlContainer.baseUrl}${controller.profileImages[index].file}"),
                                              fit: BoxFit.contain,
                                            ),
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                      ),
                                      Positioned(
                                        top: 20, right: 48,
                                        child: Container(
                                          height: 40, width: 40,
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                              color: AppColors.colorWhite, shape: BoxShape.circle
                                          ),
                                          child: const Icon(Icons.favorite, color: Colors.redAccent, size: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                ) : InkWell(
                                  hoverColor: AppColors.colorWhite,
                                  borderRadius: BorderRadius.circular(20),
                                  onDoubleTap: () => controller.makeFavoriteProfileImage(index, profileImageId: controller.profileImages[index].id ?? -1),
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 400, width: 600,
                                        margin: const EdgeInsetsDirectional.only(end: 20),
                                        decoration: BoxDecoration(
                                            color: AppColors.colorRedB,
                                            image: DecorationImage(
                                              image: NetworkImage("${ApiUrlContainer.baseUrl}${controller.profileImages[index].file}"),
                                              fit: BoxFit.contain,
                                            ),
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                      ),
                                      Positioned(
                                        top: 20, right: 48,
                                        child: Container(
                                          height: 40, width: 40,
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                              color: AppColors.colorWhite, shape: BoxShape.circle
                                          ),
                                          child: const Icon(Icons.favorite_border_rounded, color: Colors.redAccent, size: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                                options: CarouselOptions(
                                    height: 400,
                                    viewportFraction: 0.7,
                                    autoPlay: false,
                                    onPageChanged: (val, _) {
                                      controller.changePage(val);
                                    }
                                ),
                              ),
                            ),
                            const Gap(20),
                            /// ----------------- next button ----------------------
                            IconButton(
                                onPressed: () => controller.carouselController.nextPage(),
                                icon: Container(
                                  height: 40, width: 40,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      color: AppColors.colorLightWhite,
                                      shape: BoxShape.circle
                                  ),
                                  child: const Icon(Icons.arrow_forward_ios, color: AppColors.colorDarkA, size: 20),
                                )
                            )
                          ]
                      ),
                      const Gap(20),
                      /// ---------------- timeline posts ------------------------
                      controller.timelineList.isEmpty ? Padding(
                        padding: EdgeInsets.symmetric(vertical: Get.height * 0.4),
                        child: Center(
                          child: Text(
                            "No Posts Available",
                            textAlign: TextAlign.center,
                            style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkA, fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ) : SizedBox(
                        width: 600,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(controller.timelineList.length, (index) => Padding(
                            padding: index == controller.timelineList.length - 1 ? EdgeInsets.zero : const EdgeInsetsDirectional.only(bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                controller.timelineList[index].files!.isEmpty ? const SizedBox() : SizedBox(
                                  width: Get.width,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      CarouselSlider(
                                        carouselController: controller.ccList[index],
                                        items: List.generate(controller.timelineList[index].files!.length, (images) => Container(
                                          height: 400, width: 600,
                                          decoration: BoxDecoration(
                                              color: AppColors.colorRedB,
                                              borderRadius: BorderRadius.circular(35),
                                              image: DecorationImage(
                                                image: NetworkImage("${ApiUrlContainer.baseUrl}${controller.timelineList[index].files![images].file.toString()}"),
                                                fit: BoxFit.scaleDown,
                                              )
                                          ),
                                        )),
                                        options: CarouselOptions(
                                            height: 400,
                                            viewportFraction: 1,
                                            autoPlay: false,
                                            scrollPhysics: controller.timelineList[index].files!.length == 1 ? const NeverScrollableScrollPhysics() : null,
                                            onPageChanged: (val, _) {
                                              controller.changeTimeLineImagePage(val,index);
                                            }
                                        ),
                                      ),
                                      // todo -> arrow button
                                      controller.timelineList[index].files!.length == 1 ? const SizedBox() : Positioned.fill(
                                        left: -20,
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              height: 40, width: 40,
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                  color: AppColors.colorLightWhite,
                                                  shape: BoxShape.circle
                                              ),
                                              child: IconButton(
                                                onPressed: () {
                                                  controller.ccList[index].previousPage();
                                                  controller.update();
                                                },
                                                icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.colorDarkA, size: 20),
                                                iconSize: 20,
                                              ),
                                            )
                                        ),
                                      ),
                                      controller.timelineList[index].files!.length == 1 ? const SizedBox() : Positioned.fill(
                                        right: -20,
                                        child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              height: 40, width: 40,
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                  color: AppColors.colorLightWhite,
                                                  shape: BoxShape.circle
                                              ),
                                              child: IconButton(
                                                onPressed: () {
                                                  controller.ccList[index].nextPage();
                                                  controller.update();
                                                },
                                                icon: const Icon(Icons.arrow_forward_ios, color: AppColors.colorDarkA, size: 20),
                                                iconSize: 20,
                                              ),
                                            )
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Gap(8),
                                RichText(
                                  text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: "${controller.username} ",
                                            style: AppTextStyle.appTextStyle(
                                                textColor: AppColors.colorDarkA,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600
                                            )
                                        ),
                                        TextSpan(
                                            text: controller.timelineList[index].caption,
                                            style: AppTextStyle.appTextStyle(
                                                textColor: AppColors.colorDarkB,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal
                                            )
                                        )
                                      ]
                                  ),
                                ),
                                const Gap(8),
                                Text(
                                    controller.formattedDate(controller.timelineList[index].updatedAt ?? ""),
                                    style: AppTextStyle.appTextStyle(
                                        textColor: AppColors.colorDarkB,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal
                                    )
                                ),
                                const Gap(8),
                                controller.likePostList[index] == 1 ? IconButton(
                                    onPressed: () => controller.unlikePost(index, postId: controller.timelineList[index].id ?? -1),
                                    icon: const Icon(Icons.favorite, color: Colors.red, size: 24)
                                ) : IconButton(
                                    onPressed: () => controller.likePost(index, postId: controller.timelineList[index].id ?? -1),
                                    icon: const Icon(Icons.favorite_border_rounded, color: AppColors.colorDarkB, size: 24)
                                )
                              ],
                            ),
                          )),
                        ),
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
