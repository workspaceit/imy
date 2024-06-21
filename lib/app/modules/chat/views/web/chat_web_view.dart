import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_images.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/core/utils/app_utils.dart';
import 'package:ilu/app/models/chat/message_model.dart';
import 'package:ilu/app/modules/chat/controllers/chat_controller.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:ilu/app/widgets/buttons/custom_button.dart';
import 'package:ilu/app/widgets/buttons/custom_outline_button.dart';

import '../../../../widgets/dialog/custom_dialog.dart';

class ChatWebView extends StatefulWidget {
  const ChatWebView({super.key});
  @override
  State<ChatWebView> createState() => _ChatWebViewState();
}

class _ChatWebViewState extends State<ChatWebView> {

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: false,
      child: GetBuilder<ChatController>(builder: (controller) {
        return controller.isLoading && controller.isChatMessageLoading ? const Scaffold(
          backgroundColor: AppColors.colorWhite,
          body: Center(
            child: CircularProgressIndicator(color: AppColors.colorDarkA, strokeWidth: 2),
          ),
        ) :  Scaffold(
          backgroundColor: AppColors.colorWhite,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.colorWhite,
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: SvgPicture.asset(AppIcons.arrowBack),
                alignment: Alignment.center
            ),
            titleSpacing: 0,
            title: Row(
              children: [
                /// ----------------------- receiver image section
                controller.receiverProfileImages.isEmpty && controller.receiverImage.isEmpty ? Container(
                  height: 42,
                  width: 42,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(AppImages.iluImage),
                          fit: BoxFit.contain
                      )
                  ),
                ) : CachedNetworkImage(
                  imageUrl: controller.receiverImage,
                  imageBuilder: (context, imageProvider) =>  Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.contain
                        )
                    ),
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Text(
                    controller.receiverName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.appTextStyle(
                        textColor: AppColors.colorDarkA,
                        fontWeight: FontWeight.w600,
                        fontSize: 14
                    ),
                  ),
                )
              ],
            ),
            actions: [
              /// ------------------------- enable free chat button
              IconButton(
                onPressed: () => showDialog(
                    context: context,
                    builder: (context) => CustomDialog(
                      width: 400,
                      dialogChild: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "You're about to pay for your recepient",
                            textAlign: TextAlign.center,
                            style: AppTextStyle.appTextStyle(
                                textColor: AppColors.colorDarkA,
                                fontWeight: FontWeight.w600,
                                fontSize: 16
                            ),
                          ),
                          const Gap(4),
                          Text(
                            "Are you sure?",
                            textAlign: TextAlign.center,
                            style: AppTextStyle.appTextStyle(
                                textColor: AppColors.colorDarkA,
                                fontWeight: FontWeight.w600,
                                fontSize: 16
                            ),
                          ),
                          const Gap(20),
                          CustomButton(
                              onPressed: (){},
                              buttonText: "YES"
                          ),
                          const Gap(12),
                          InkWell(
                            hoverColor: AppColors.colorWhite,
                            borderRadius: BorderRadius.circular(99),
                            onTap: () => Get.back(),
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
                                "NO",
                                textAlign: TextAlign.center,
                                style: AppTextStyle.appTextStyle(
                                    textColor: AppColors.colorDarkB,
                                    fontSize: 16, fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                ),
                iconSize: 24,
                icon: const Icon(Icons.contact_support_outlined),
              ),
              const Gap(12),
              /// ------------------------- audio call button
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
                  icon: SvgPicture.asset(AppIcons.verifyContactField,color: AppColors.colorDarkA)
              ),
              const Gap(24),
            ],
          ),
          body: controller.messageList.isEmpty ? Center(
            child: Text(
              "No Messages Available",
              style: AppTextStyle.appTextStyle(
                  textColor: AppColors.colorDarkA,
                  fontSize: 16,
                  fontWeight: FontWeight.w700
              ),
            ),
          ) :  SingleChildScrollView(
              padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 24),
              physics: const BouncingScrollPhysics(),
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: controller.messageList.length,
                  separatorBuilder: (context, index) => const Gap(12),
                  itemBuilder: (context, index) {
                    if(controller.currentUserId == controller.messageList[index].fromId){
                      if(controller.messageList[index].read.isEmpty){
                        controller.updateMessageReadStatus(fromId: controller.messageList[index].toId, sent: controller.messageList[index].sent);
                      }
                      return Align(
                        alignment: Alignment.topRight,
                        child: controller.messageList[index].type == MessageType.text ? Container(
                          padding: const EdgeInsetsDirectional.symmetric(vertical: 12, horizontal: 12),
                          decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              borderRadius: BorderRadius.circular(4)
                          ),
                          child: Text(
                            controller.messageList[index].msg,
                            style: AppTextStyle.appTextStyle(
                                textColor: AppColors.colorWhite,
                                fontSize: 14,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                        ) : InkWell(
                          hoverColor: AppColors.colorWhite,
                          borderRadius: BorderRadius.circular(4),
                          onTap: () {
                            Get.toNamed(
                                Routes.DETAILS_IMAGES,
                                arguments: controller.messageList[index].msg
                            );
                          },
                          child: Container(
                            height: 150, width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: AppColors.colorRedB,
                                border: const GradientBoxBorder(gradient: AppColors.primaryGradient, width: 1),
                                image: DecorationImage(image: NetworkImage(controller.messageList[index].msg))
                            ),
                          ),
                        ),
                      );
                    } else{
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Row(
                                children: [
                                  /// ------------------------ receiver image
                                  controller.receiverProfileImages.isEmpty && controller.receiverImage.isEmpty ? Container(
                                    height: 42,
                                    width: 42,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(AppImages.iluImage),
                                            fit: BoxFit.contain
                                        )
                                    ),
                                  ) : CachedNetworkImage(
                                    imageUrl: controller.receiverImage,
                                    imageBuilder: (context, imageProvider) =>  Container(
                                      height: 42,
                                      width: 42,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.contain
                                          )
                                      ),
                                    ),
                                  ),
                                  const Gap(12),
                                  /// ------------------------ receiver message
                                  Flexible(
                                    child: controller.messageList[index].type == MessageType.text ? Container(
                                      padding: const EdgeInsetsDirectional.symmetric(vertical: 12, horizontal: 12),
                                      decoration: BoxDecoration(
                                          color: AppColors.colorLightWhite,
                                          borderRadius: BorderRadius.circular(4)
                                      ),
                                      child: Text(
                                        controller.messageList[index].msg,
                                        style: AppTextStyle.appTextStyle(
                                            textColor: AppColors.colorDarkA,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14
                                        ),
                                      ),
                                    ) : InkWell(
                                      hoverColor: AppColors.colorWhite,
                                      borderRadius: BorderRadius.circular(4),
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.DETAILS_IMAGES,
                                          arguments: controller.messageList[index].msg
                                        );
                                      },
                                      child: Container(
                                        height: 150, width: 150,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: AppColors.colorRedB,
                                            border: const GradientBoxBorder(gradient: AppColors.primaryGradient, width: 1),
                                            image: DecorationImage(
                                              image: NetworkImage(controller.messageList[index].msg)
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(12),
                            controller.messageList[index].read.isNotEmpty ? const Icon(
                                Icons.done_all_rounded,
                                color: Colors.blue,
                                size: 20
                            ) : const SizedBox()
                          ],
                        ),
                      );
                    }
                  }
              )
          ),
          bottomNavigationBar: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 50),
              curve: Curves.decelerate,
              child: Container(
                width: Get.width,
                padding: const EdgeInsetsDirectional.symmetric(vertical: 12, horizontal: 24),
                color: AppColors.colorGrayB.withOpacity(0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// ------------------ this section is used for showing picked images
                    controller.imageFiles.isEmpty ? const SizedBox() : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: List.generate(
                            controller.imageFiles.length, (index) => Padding(
                          padding: const EdgeInsetsDirectional.only(bottom: 8, end: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.memory(
                              controller.selectedImages[index]!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                          ),
                        )),
                      ),
                    ),
                    Container(
                      width: Get.width,
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 6),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppColors.colorWhite,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.colorGrayB, width: 1)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: TextField(
                                controller: controller.messageController,
                                cursorColor: AppColors.colorDarkB,
                                textInputAction: TextInputAction.done,
                                maxLines: null,
                                style: AppTextStyle.appTextStyle(
                                    textColor: AppColors.colorDarkA,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.colorWhite,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  hintText: "Type Message...",
                                  hintStyle: AppTextStyle.appTextStyle(
                                      textColor: AppColors.colorDarkB,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Gap(12),
                          IconButton(
                              onPressed: () => controller.sendImageToWeb(),
                              icon: SvgPicture.asset(AppIcons.gradientGallery)
                          ),
                          const Gap(12),

                          /// ---------------------- send message button
                          IconButton(
                              onPressed: () {
                                if (controller.messageController.text.isEmpty == true &&
                                    controller.imageFiles.isEmpty == true) {
                                  AppUtils.errorSnackBarForWeb("Please type something or select an image");
                                } else if(controller.messageController.text.trim().isEmpty){
                                  AppUtils.errorSnackBarForWeb("You can't send blank message");
                                } else {
                                  if( controller.messageList.isNotEmpty == true){

                                    controller.sendMessage(
                                        controller.messageController.text.trim(),
                                        MessageType.text
                                    );
                                  }else{

                                    controller.sendFirstMessage(
                                        controller.messageController.text.trim(),
                                        MessageType.text
                                    );
                                  }
                                }
                              },
                              icon: SvgPicture.asset(AppIcons.send)
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
