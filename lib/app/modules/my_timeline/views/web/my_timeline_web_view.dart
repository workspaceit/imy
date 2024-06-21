import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/date_convert_helper.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_images.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/my_timeline/controllers/my_timeline_controller.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:ilu/app/widgets/buttons/custom_outline_button.dart';
import 'package:ilu/app/widgets/dialog/custom_dialog.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class MyTimeLineWebView extends StatelessWidget {
  const MyTimeLineWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<MyTimelineController>(
        builder: (controller) => Scaffold(
          backgroundColor: AppColors.colorWhite,
          appBar: AppBar(
            backgroundColor: AppColors.colorWhite,
            leading: IconButton(
                onPressed: () => Get.toNamed(Routes.PROFILE),
                alignment: Alignment.center,
                icon: SvgPicture.asset(AppIcons.arrowBack),
                iconSize: 24),
            title: Text(
              "My Timeline",
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
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 700,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // todo -> post section
                    InkWell(
                      hoverColor: AppColors.colorWhite,
                      onTap: () => Get.toNamed(Routes.CREATE_POST),
                      child: Container(
                        width: 600,
                        padding: const EdgeInsetsDirectional.symmetric(vertical: 16, horizontal: 24),
                        decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(color: AppColors.colorGrayB, width: 2),
                              bottom: BorderSide(color: AppColors.colorGrayB, width: 2),
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  controller.profileImages.isEmpty ? Container(
                                    height: 40, width: 40,
                                    decoration: const BoxDecoration(
                                      color: AppColors.colorRedB,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage(AppImages.iluImage),
                                          fit: BoxFit.contain,
                                      ),
                                    ),
                                  ) : Container(
                                    height: 36, width: 36,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(controller.userProfileImage),
                                          fit: BoxFit.contain,

                                      ),
                                    ),
                                  ),
                                  const Gap(12),
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      "What's on your mind?",
                                      style: AppTextStyle.appTextStyle(
                                          textColor: AppColors.colorDarkB,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(12),
                            SvgPicture.asset(AppIcons.gallery),
                          ],
                        ),
                      )
                    ),
                    const Gap(20),

                    // todo -> timeline
                    controller.isLoading ? Padding(
                      padding: EdgeInsetsDirectional.symmetric(vertical: Get.height * 0.4),
                      child: const Center(child: CircularProgressIndicator(color: AppColors.colorDarkA)),
                    ) : controller.timelineList.isEmpty ? Padding(
                      padding: EdgeInsetsDirectional.symmetric(vertical: Get.height * 0.4),
                      child: Center(
                        child: Text(
                          "No Post Available",
                          textAlign: TextAlign.center,
                          style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkA, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ) : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(controller.timelineList.length, (index) => Container(
                        width: 600,
                        padding: const EdgeInsetsDirectional.symmetric(vertical: 20),
                        decoration: const BoxDecoration(
                            color: AppColors.colorWhite,
                            border: Border(
                                bottom: BorderSide(color: AppColors.colorGrayB, width: 1)
                            )
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// --------------------------- user info $ pop up menu section ----------------------------
                                Padding(
                                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        /// ----------------- user info ----------------------------------
                                        Row(
                                          children: [
                                            controller.profileImages.isEmpty ? Container(
                                              height: 40, width: 40,
                                              decoration: const BoxDecoration(
                                                color: AppColors.colorRedB,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: AssetImage(AppImages.iluImage),
                                                    fit: BoxFit.contain,
                                                ),
                                              ),
                                            ) : Container(
                                              height: 40, width: 40,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: NetworkImage(controller.userProfileImage),
                                                    fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                            const Gap(8),
                                            Text(
                                              controller.username,
                                              style: AppTextStyle.appTextStyle(
                                                  textColor: AppColors.colorDarkA,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600
                                              ),
                                            )
                                          ],
                                        ),
                                        /// ---------------------- pop up button ---------------------------
                                        PopupMenuButton(
                                          elevation: 0,
                                          constraints: const BoxConstraints(
                                              maxWidth: 400
                                          ),
                                          offset: const Offset(0, 60),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                          color: AppColors.colorWhite,
                                          child: const Icon(Icons.more_horiz_rounded, color: AppColors.colorDarkA, size: 20),
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                                onTap: (){
                                                  int editPostId = controller.timelineList[index].id ?? 0;
                                                  log("----------------- post id: $editPostId");
                                                  controller.repo.apiService.sharedPreferences.setInt(LocalStorageHelper.editPostIdKey, editPostId);
                                                  Get.toNamed(Routes.EDIT_POST);
                                                },
                                                padding: const EdgeInsets.only(top: 6, bottom: 6, left: 12, right: 12),
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
                                                    "Edit",
                                                    textAlign: TextAlign.center,
                                                    style: AppTextStyle.appTextStyle(
                                                        textColor: AppColors.colorDarkB,
                                                        fontSize: 16, fontWeight: FontWeight.w600
                                                    ),
                                                  ),
                                                )
                                            ),
                                            PopupMenuItem(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) => CustomDialog(
                                                      width: 400,
                                                      dialogChild: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            "Are you Sure that you want to delete this post?",
                                                            textAlign: TextAlign.center,
                                                            style: AppTextStyle.appTextStyle(
                                                                textColor: AppColors.colorDarkA,
                                                                fontSize: 18,
                                                                fontWeight: FontWeight.w600
                                                            ),
                                                          ),
                                                          const Gap(24),
                                                          // delete button
                                                          InkWell(
                                                            borderRadius: BorderRadius.circular(99),
                                                            hoverColor: AppColors.colorWhite,
                                                            onTap: (){
                                                              controller.postDelete(postId: controller.timelineList[index].id ?? -1);
                                                            },
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
                                                                  "Delete",
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
                                              padding: const EdgeInsets.only(top: 6, bottom: 6, left: 12, right: 12),
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
                                                  "Delete",
                                                  textAlign: TextAlign.center,
                                                  style: AppTextStyle.appTextStyle(
                                                      textColor: AppColors.colorDarkB,
                                                      fontSize: 16, fontWeight: FontWeight.w600
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                ),
                                const Gap(12),
                                /// ---------------------------- post section --------------------------------
                                controller.timelineList[index].files!.isNotEmpty ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// --------------------------------- slider image -------------------------------
                                    SizedBox(
                                      width: Get.width,
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          CarouselSlider(
                                            carouselController: controller.ccList[index],
                                            items: List.generate(controller.timelineList[index].files!.length, (images) => Container(
                                              height: Get.height, width: Get.width,
                                              decoration: BoxDecoration(
                                                color: AppColors.colorRedB,
                                                  borderRadius: BorderRadius.circular(35),
                                                  image: DecorationImage(
                                                      image: NetworkImage("${ApiUrlContainer.baseUrl}${controller.timelineList[index].files![images].file.toString()}"),
                                                      fit: BoxFit.contain,

                                                  )
                                              ),
                                            )),
                                            options: CarouselOptions(
                                                height: 550,
                                                viewportFraction: 1,
                                                scrollPhysics: controller.timelineList[index].files!.length == 1 ? const NeverScrollableScrollPhysics() : null,
                                                autoPlay: false,
                                                onPageChanged: (val, _) {
                                                  controller.changeTimelinePage(val, index);
                                                }
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Gap(12),
                                    /// --------------------------------- caption ------------------------------------
                                    Padding(
                                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          controller.timelineList[index].caption == null ? const SizedBox() : Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  controller.timelineList[index].caption ?? "",
                                                  style: AppTextStyle.appTextStyle(
                                                      textColor: AppColors.colorDarkA,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600
                                                  )
                                              ),
                                              const Gap(12),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                  children: [
                                                    Text(
                                                      controller.formattedDate(controller.timelineList[index].updatedAt ?? ""),
                                                      style: AppTextStyle.appTextStyle(
                                                          textColor: AppColors.colorDarkB,
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 12
                                                      ),
                                                    ),
                                                    const Gap(4),
                                                    Container(
                                                      height: 4, width: 4,
                                                      decoration: const BoxDecoration(
                                                          color: AppColors.colorDarkB,
                                                          shape: BoxShape.circle
                                                      ),
                                                    ),
                                                    const Gap(4),
                                                    Text(
                                                      DateConvertHelper.isoStringToLocalDateOnly(controller.timelineList[index].createdAt ?? ""),
                                                      style: AppTextStyle.appTextStyle(
                                                          textColor: AppColors.colorDarkB,
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 12
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              controller.timelineList[index].liked == 0 ? const SizedBox() :InkWell(
                                                  borderRadius: BorderRadius.circular(12),
                                                  onTap: () async{
                                                    await controller.loadPostLikedUsersData(
                                                        controller.timelineList[index].liked ?? -1,
                                                        postId: controller.timelineList[index].id ?? -1
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                                    child: Align(
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        "${controller.timelineList[index].liked ?? 0} Likes",
                                                        style: AppTextStyle.appTextStyle(
                                                            textColor: AppColors.colorDarkA,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 12
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ]
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ) : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// -------------------------------- caption --------------------------------------
                                    Padding(
                                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  controller.timelineList[index].caption ?? "",
                                                  style: AppTextStyle.appTextStyle(
                                                      textColor: AppColors.colorDarkA,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600
                                                  )
                                              ),
                                              const Gap(12),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    controller.formattedDate(controller.timelineList[index].updatedAt ?? ""),
                                                    style: AppTextStyle.appTextStyle(
                                                        textColor: AppColors.colorDarkB,
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 12
                                                    ),
                                                  ),
                                                  const Gap(4),
                                                  Container(
                                                    height: 4, width: 4,
                                                    decoration: const BoxDecoration(
                                                        color: AppColors.colorDarkB,
                                                        shape: BoxShape.circle
                                                    ),
                                                  ),
                                                  const Gap(4),
                                                  Text(
                                                    DateConvertHelper.isoStringToLocalDateOnly(controller.timelineList[index].createdAt ?? ""),
                                                    style: AppTextStyle.appTextStyle(
                                                        textColor: AppColors.colorDarkB,
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 12
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              controller.timelineList[index].liked == 0 ? const SizedBox() : InkWell(
                                                borderRadius: BorderRadius.circular(12),
                                                onTap: () async {
                                                  await controller.loadPostLikedUsersData(
                                                      controller.timelineList[index].liked ?? -1,
                                                      postId: controller.timelineList[index].id ?? -1
                                                  );
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "${controller.timelineList[index].liked} Likes",
                                                      style: AppTextStyle.appTextStyle(
                                                          textColor: AppColors.colorDarkA,
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 12
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            /// ---------------------------- arrow button --------------------------------------
                            controller.timelineList[index].files!.isNotEmpty ?
                            controller.timelineList[index].files!.length == 1 ?
                            const SizedBox() : Positioned.fill(
                              left: -20,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                  hoverColor: AppColors.colorWhite,
                                  borderRadius: BorderRadius.circular(100),
                                  onTap: () {
                                    controller.ccList[index].previousPage();
                                    controller.update();
                                  },
                                  child: Container(
                                    height: 40, width: 40,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                        color: AppColors.colorLightWhite,
                                        shape: BoxShape.circle
                                    ),
                                    child: const Icon(Icons.arrow_back_ios_new, color: AppColors.colorDarkA, size: 20),
                                  ),
                                ),
                              ),
                            ) : const SizedBox(),

                            controller.timelineList[index].files!.isNotEmpty ?
                            controller.timelineList[index].files!.length == 1 ?
                            const SizedBox() : Positioned.fill(
                              right: -20,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                    hoverColor: AppColors.colorWhite,
                                    borderRadius: BorderRadius.circular(100),
                                    onTap: () {
                                      controller.ccList[index].nextPage();
                                      controller.update();
                                    },
                                    child: Container(
                                      height: 40, width: 40,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          color: AppColors.colorLightWhite,
                                          shape: BoxShape.circle
                                      ),
                                      child: const Icon(Icons.arrow_forward_ios, color: AppColors.colorDarkA, size: 20),
                                    )
                                ),
                              ),
                            ) : const SizedBox(),
                          ],
                        ),
                      ))
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
