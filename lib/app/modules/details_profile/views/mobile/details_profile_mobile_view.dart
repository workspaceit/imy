import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:ilu/app/modules/details_profile/inner_widgets/mobile_details_profile_image_widget.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:ilu/app/widgets/buttons/custom_button.dart';
import 'package:ilu/app/widgets/buttons/custom_outline_button.dart';
import 'package:ilu/app/widgets/dialog/custom_dialog.dart';
import 'package:ilu/app/widgets/text_form_field/custom_text_form_field.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class DetailsProfileMobileView extends StatelessWidget {
  const DetailsProfileMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<DetailsProfileController>(

          /// ----------------- data loading state
          builder: (controller) => controller.isLoading
              ? const Scaffold(
                  backgroundColor: AppColors.colorWhite,
                  body: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.colorDarkA,
                    ),
                  ),
                )
              : Scaffold(
                  backgroundColor: AppColors.colorWhite,

                  /// ------------------------ app bar
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: AppColors.colorWhite,

                    /// ---------------------- back button
                    leading: IconButton(
                        onPressed: () => Get.toNamed(Routes.HOME),
                        alignment: Alignment.center,
                        icon: SvgPicture.asset(AppIcons.arrowBack),
                        iconSize: 24),
                    titleSpacing: 0,
                    title: Row(
                      children: [
                        controller.profileImages.isEmpty
                            ? Container(
                                height: 42,
                                width: 42,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(AppImages.iluImage),
                                        fit: BoxFit.contain),
                                    shape: BoxShape.circle),
                              )
                            : Container(
                                height: 42,
                                width: 42,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "${ApiUrlContainer.baseUrl}${controller.profileImages[0].file}"),
                                    ),
                                    shape: BoxShape.circle),
                              ),
                        const Gap(8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.username,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.appTextStyle(
                                    textColor: AppColors.colorDarkA,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                              const Gap(4),
                              Row(
                                children: [
                                  Text("ID ${controller.userId}",
                                      style: AppTextStyle.appTextStyle(
                                          textColor: AppColors.colorDarkB,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400)),
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
                                          fontWeight: FontWeight.w400)),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  body: SingleChildScrollView(
                    padding: const EdgeInsetsDirectional.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // todo -> list of images
                        controller.profileImages.isEmpty
                            ? Container(
                                height: 550,
                                width: Get.width,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    color: AppColors.colorRedB,
                                    image: DecorationImage(
                                        image: AssetImage(AppImages.iluImage),
                                        fit: BoxFit.contain)),
                              )
                            : SizedBox(
                                height: 550,
                                width: Get.width,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    CarouselSlider(
                                      carouselController:
                                          controller.carouselController,
                                      items: List.generate(
                                          controller.profileImages.length,
                                          (index) => MobileDetailsProfileImageWidget(imageIndex: index)),
                                      options: CarouselOptions(
                                          height: 550,
                                          scrollPhysics: controller.profileImages.length == 1
                                              ? const NeverScrollableScrollPhysics()
                                              : null,
                                          viewportFraction: 1,
                                          autoPlay: false,
                                          onPageChanged: (val, _) {
                                            controller.changePage(val);
                                          }),
                                    ),
                                    Positioned.fill(
                                      bottom: 20,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          height: 40,
                                          width: Get.width,
                                          alignment: Alignment.center,
                                          padding:
                                              const EdgeInsetsDirectional.all(
                                                  12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: List.generate(
                                                controller.profileImages.length,
                                                (index) => index ==
                                                        controller.currentIndex
                                                    ? Container(
                                                        height: 12,
                                                        width: 12,
                                                        margin: index ==
                                                                controller
                                                                        .profileImages
                                                                        .length -
                                                                    1
                                                            ? EdgeInsets.zero
                                                            : const EdgeInsetsDirectional
                                                                .only(end: 12),
                                                        decoration:
                                                            const BoxDecoration(
                                                                gradient: AppColors
                                                                    .primaryGradient,
                                                                shape: BoxShape
                                                                    .circle),
                                                      )
                                                    : Container(
                                                        height: 6,
                                                        width: 6,
                                                        margin: index ==
                                                                controller
                                                                        .profileImages
                                                                        .length -
                                                                    1
                                                            ? EdgeInsets.zero
                                                            : const EdgeInsetsDirectional
                                                                .only(end: 12),
                                                        decoration:
                                                            const BoxDecoration(
                                                                color: AppColors
                                                                    .colorWhite,
                                                                shape: BoxShape
                                                                    .circle),
                                                      )),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                        const Gap(20),

                        // todo -> buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /// ------------------ chat button
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.CHAT);
                              },
                              child: Container(
                                height: 52,
                                width: 52,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    color: AppColors.colorLightWhite,
                                    shape: BoxShape.circle),
                                child: SvgPicture.asset(
                                    AppIcons.messageInactive,
                                    color: AppColors.colorDarkA),
                              ),
                            ),
                            const Gap(12),

                            /// ------------------ audio call button
                            GestureDetector(
                              onTap: () {
                                controller.rechargeBalance < 2 ? controller.getCurrentUserData().then((value) => showDialog(
                                    context: Get.context!,
                                    builder: (_) => CustomDialog(
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
                                                showModalBottomSheet(
                                                    context: Get.context!,
                                                    backgroundColor: AppColors.colorWhite,
                                                    constraints: const BoxConstraints(maxHeight: 250),
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                                                    ),
                                                    builder: (_) => Container(
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
                                    ))) : controller.getCurrentUserData().then(
                                    (value) => controller.fetchAgoraToken());
                              },
                              child: Container(
                                height: 52,
                                width: 52,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    color: AppColors.colorLightWhite,
                                    shape: BoxShape.circle),
                                child: SvgPicture.asset(
                                    AppIcons.verifyContactField,
                                    color: AppColors.colorDarkA),
                              ),
                            ),
                            const Gap(12),

                            /// ------------------ menu button
                            GestureDetector(
                              onTap: () => showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: AppColors.colorWhite,
                                  context: context,
                                  builder: (context) => Padding(
                                        padding: const EdgeInsetsDirectional
                                            .symmetric(
                                            vertical: 20, horizontal: 24),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // add to favorite
                                            GestureDetector(
                                              onTap: () {
                                                controller.makeUserFavorite(controller
                                                        .repo
                                                        .apiService
                                                        .sharedPreferences
                                                        .getInt(LocalStorageHelper
                                                            .detailsProfileUserIdKey) ??
                                                    -1);
                                                Get.back();
                                              },
                                              child: Container(
                                                width: Get.width,
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .symmetric(
                                                        vertical: 12),
                                                decoration: BoxDecoration(
                                                    color: AppColors.colorWhite,
                                                    border: Border.all(
                                                        color: AppColors
                                                            .colorGrayB,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            99)),
                                                child: Text(
                                                  "Add to favorite",
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      AppTextStyle.appTextStyle(
                                                          textColor: AppColors
                                                              .colorDarkB,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                            const Gap(12),
                                            // report this user
                                            GestureDetector(
                                              onTap: () {
                                                Get.back();
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (context) =>
                                                            CustomDialog(
                                                              dialogChild:
                                                                  Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Are you Sure that you want to Report this user?",
                                                                    style: AppTextStyle.appTextStyle(
                                                                        textColor:
                                                                            AppColors
                                                                                .colorDarkA,
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  const Gap(24),
                                                                  const CustomTextFormField(
                                                                      hintText:
                                                                          "Reason to Report",
                                                                      maxLines:
                                                                          4,
                                                                      radius:
                                                                          12),
                                                                  const Gap(12),
                                                                  controller
                                                                          .isSubmitReport
                                                                      ? Container(
                                                                          width: Get
                                                                              .width,
                                                                          padding: const EdgeInsetsDirectional
                                                                              .symmetric(
                                                                              horizontal:
                                                                                  16,
                                                                              vertical:
                                                                                  16),
                                                                          alignment: Alignment
                                                                              .center,
                                                                          decoration: BoxDecoration(
                                                                              border: const GradientBoxBorder(gradient: AppColors.redGradient),
                                                                              borderRadius: BorderRadius.circular(99)),
                                                                          child: const SizedBox(
                                                                            height:
                                                                                16,
                                                                            width:
                                                                                16,
                                                                            child:
                                                                                CircularProgressIndicator(
                                                                              color: Colors.red,
                                                                            ),
                                                                          ))
                                                                      : GestureDetector(
                                                                          onTap: () =>
                                                                              controller.reportUser(controller.repo.apiService.sharedPreferences.getInt(LocalStorageHelper.detailsProfileUserIdKey) ?? -1),
                                                                          child: Container(
                                                                              width: Get.width,
                                                                              padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 16),
                                                                              alignment: Alignment.center,
                                                                              decoration: BoxDecoration(border: const GradientBoxBorder(gradient: AppColors.redGradient), borderRadius: BorderRadius.circular(99)),
                                                                              child: GradientText(
                                                                                "Report",
                                                                                colors: const [
                                                                                  Color(0xffFF597B),
                                                                                  Color(0xffF5827A)
                                                                                ],
                                                                                style: AppTextStyle.appTextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                                                              )),
                                                                        ),
                                                                  const Gap(12),
                                                                  CustomOutlineButton(
                                                                      onPressed:
                                                                          () => Get
                                                                              .back(),
                                                                      buttonText:
                                                                          "Close")
                                                                ],
                                                              ),
                                                            ));
                                              },
                                              child: Container(
                                                width: Get.width,
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .symmetric(
                                                        vertical: 12),
                                                decoration: BoxDecoration(
                                                    color: AppColors.colorWhite,
                                                    border: Border.all(
                                                        color: AppColors
                                                            .colorGrayB,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            99)),
                                                child: Text(
                                                  "Report this user",
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      AppTextStyle.appTextStyle(
                                                          textColor: AppColors
                                                              .colorDarkB,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                            const Gap(12),
                                            // block this user
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (context) =>
                                                            CustomDialog(
                                                              dialogChild:
                                                                  Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Are you Sure that you want to Block this user?",
                                                                    style: AppTextStyle.appTextStyle(
                                                                        textColor:
                                                                            AppColors
                                                                                .colorDarkA,
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  const Gap(24),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      controller.makeUserBlock(controller
                                                                              .repo
                                                                              .apiService
                                                                              .sharedPreferences
                                                                              .getInt(LocalStorageHelper.detailsProfileUserIdKey) ??
                                                                          -1);
                                                                    },
                                                                    child: Container(
                                                                        width: Get.width,
                                                                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 16),
                                                                        alignment: Alignment.center,
                                                                        decoration: BoxDecoration(border: const GradientBoxBorder(gradient: AppColors.redGradient), borderRadius: BorderRadius.circular(99)),
                                                                        child: GradientText(
                                                                          "Block",
                                                                          colors: const [
                                                                            Color(0xffFF597B),
                                                                            Color(0xffF5827A)
                                                                          ],
                                                                          style: AppTextStyle.appTextStyle(
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w600),
                                                                        )),
                                                                  ),
                                                                  const Gap(12),
                                                                  CustomOutlineButton(
                                                                      onPressed:
                                                                          () => Get
                                                                              .back(),
                                                                      buttonText:
                                                                          "Close")
                                                                ],
                                                              ),
                                                            ));
                                              },
                                              child: Container(
                                                width: Get.width,
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .symmetric(
                                                        vertical: 12),
                                                decoration: BoxDecoration(
                                                    color: AppColors.colorWhite,
                                                    border: Border.all(
                                                        color: AppColors
                                                            .colorGrayB,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            99)),
                                                child: Text(
                                                  "Block this user",
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      AppTextStyle.appTextStyle(
                                                          textColor: AppColors
                                                              .colorDarkB,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                              child: Container(
                                height: 52,
                                width: 52,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    color: AppColors.colorLightWhite,
                                    shape: BoxShape.circle),
                                child: SvgPicture.asset(AppIcons.menu,
                                    color: AppColors.colorDarkA),
                              ),
                            ),
                          ],
                        ),
                        const Gap(20),

                        /// --------------------------- timeline
                        if (controller.timelineList.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50),
                            child: Center(
                              child: Text(
                                "No Posts Available",
                                textAlign: TextAlign.center,
                                style: AppTextStyle.appTextStyle(
                                    textColor: AppColors.colorDarkA,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        else
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                                controller.timelineList.length,
                                (index) => Padding(
                                      padding: index ==
                                              controller.timelineList.length - 1
                                          ? EdgeInsets.zero
                                          : const EdgeInsetsDirectional.only(
                                              bottom: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          controller.timelineList[index].files!
                                                  .isEmpty
                                              ? const SizedBox()
                                              : SizedBox(
                                                  width: Get.width,
                                                  child: Stack(
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      CarouselSlider(
                                                        carouselController:
                                                            controller
                                                                .ccList[index],
                                                        items: List.generate(
                                                            controller
                                                                .timelineList[
                                                                    index]
                                                                .files!
                                                                .length,
                                                            (images) =>
                                                                CachedNetworkImage(
                                                                  imageUrl:
                                                                      "${ApiUrlContainer.baseUrl}${controller.timelineList[index].files![images].file.toString()}",
                                                                  imageBuilder:
                                                                      (context,
                                                                              imageProvider) =>
                                                                          Container(
                                                                    height: Get
                                                                        .height,
                                                                    width: Get
                                                                        .width,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            color:
                                                                                AppColors.colorRedB,
                                                                            image: DecorationImage(
                                                                              image: imageProvider,
                                                                              fit: BoxFit.contain,
                                                                            )),
                                                                  ),
                                                                )),
                                                        options:
                                                            CarouselOptions(
                                                                height: 360,
                                                                viewportFraction:
                                                                    1,
                                                                scrollPhysics: controller
                                                                            .timelineList[
                                                                                index]
                                                                            .files!
                                                                            .length ==
                                                                        1
                                                                    ? const NeverScrollableScrollPhysics()
                                                                    : const ScrollPhysics(),
                                                                autoPlay:
                                                                    false, //controller.timelineList[index].files!.length == 1 ? false : true,
                                                                onPageChanged:
                                                                    (val, _) {
                                                                  controller
                                                                      .changeTimeLineImagePage(
                                                                          val,
                                                                          index);
                                                                }),
                                                      ),
                                                      controller
                                                                  .timelineList[
                                                                      index]
                                                                  .files!
                                                                  .length ==
                                                              1
                                                          ? const SizedBox()
                                                          : Positioned.fill(
                                                              bottom: 20,
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .bottomCenter,
                                                                child:
                                                                    Container(
                                                                  height: 40,
                                                                  width:
                                                                      Get.width,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  padding:
                                                                      const EdgeInsetsDirectional
                                                                          .all(
                                                                          12),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: List.generate(
                                                                        controller
                                                                            .timelineList[
                                                                                index]
                                                                            .files!
                                                                            .length,
                                                                        (idx) {
                                                                      return idx ==
                                                                              controller.timeLineImageIndex
                                                                          ? Container(
                                                                              height: 12,
                                                                              width: 12,
                                                                              margin: const EdgeInsetsDirectional.only(end: 12),
                                                                              decoration: const BoxDecoration(gradient: AppColors.primaryGradient, shape: BoxShape.circle),
                                                                            )
                                                                          : Container(
                                                                              height: 6,
                                                                              width: 6,
                                                                              margin: const EdgeInsetsDirectional.only(end: 12),
                                                                              decoration: const BoxDecoration(color: AppColors.colorWhite, shape: BoxShape.circle),
                                                                            );
                                                                    }),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                    ],
                                                  ),
                                                ),
                                          const Gap(8),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .symmetric(horizontal: 24),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                        text:
                                                            "${controller.username} ",
                                                        style: AppTextStyle
                                                            .appTextStyle(
                                                                textColor: AppColors
                                                                    .colorDarkA,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                    TextSpan(
                                                        text: controller
                                                            .timelineList[index]
                                                            .caption,
                                                        style: AppTextStyle
                                                            .appTextStyle(
                                                                textColor: AppColors
                                                                    .colorDarkB,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal))
                                                  ]),
                                                ),
                                                const Gap(8),
                                                Text(
                                                    controller.formattedDate(
                                                        controller
                                                                .timelineList[
                                                                    index]
                                                                .updatedAt ??
                                                            ""),
                                                    style: AppTextStyle
                                                        .appTextStyle(
                                                            textColor: AppColors
                                                                .colorDarkB,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal)),
                                                const Gap(8),
                                                controller.likePostList[index] == 1
                                                    ? IconButton(
                                                        onPressed: () =>
                                                            controller.unlikePost(index,
                                                                postId: controller.timelineList[index].id ??
                                                                    -1),
                                                        icon: const Icon(
                                                            Icons.favorite,
                                                            color: Colors.red,
                                                            size: 24))
                                                    : IconButton(
                                                        onPressed: () =>
                                                            controller.likePost(index,
                                                                postId: controller.timelineList[index].id ??
                                                                    -1),
                                                        icon: const Icon(
                                                            Icons.favorite_border_rounded,
                                                            color: AppColors.colorDarkB,
                                                            size: 24))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                          )
                      ],
                    ),
                  ),
                )),
    );
  }
}
