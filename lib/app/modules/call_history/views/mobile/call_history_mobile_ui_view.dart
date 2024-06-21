import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_images.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/call_history/controllers/call_history_controller.dart';

class CallHistoryMobileUiView extends StatelessWidget {
  final ScrollController scrollController;
  const CallHistoryMobileUiView({required this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<CallHistoryController>(builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.colorWhite,
          /// ------------------ appbar
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.colorWhite,
            leading: IconButton(
                onPressed: () => Get.back(),
                alignment: Alignment.center,
                icon: SvgPicture.asset(AppIcons.arrowBack),
                iconSize: 24),
            title: Text(
              "Call History",
              textAlign: TextAlign.center,
              style: AppTextStyle.appTextStyle(
                  textColor: AppColors.colorDarkA,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: controller.isLoading ? const Center(
            child: CircularProgressIndicator(
              color: AppColors.colorDarkA,
            )
          ) : controller.callHistoryList.isEmpty ? Center(
            child: Text(
              "No Call History Available",
              textAlign: TextAlign.center,
              style: AppTextStyle.appTextStyle(
                textColor: AppColors.colorDarkA,
                fontSize: 16,
                fontWeight: FontWeight.w600
              ),
            )
          ) : SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 24),
            child: Column(
              children: [
                Column(
                  children: List.generate(controller.callHistoryList.length, (index) {
                    if(controller.currentUserId == controller.callHistoryList[index].caller!.id){
                      return Padding(
                        padding: index == (controller.callHistoryList.length - 1) ?
                        EdgeInsets.zero : const EdgeInsetsDirectional.only(bottom: 12),
                        child: Row(
                          children: [
                            controller.callHistoryList[index].receiver?.profileImage?.file == null ? Container(
                              height: 52,
                              width: 52,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(AppImages.iluImage)
                                  )
                              ),
                            ) : CachedNetworkImage(
                              imageUrl: "${ApiUrlContainer.baseUrl}${controller.callHistoryList[index].receiver?.profileImage?.file.toString()}",
                              errorWidget: (context, url, error) => Image.asset(
                                AppImages.iluImage,
                                height: 52,
                                width: 52,
                              ),
                              imageBuilder: (context, imageProvider) => Container(
                                height: 52,
                                width: 52,
                                decoration: BoxDecoration(
                                    shape:
                                    BoxShape.circle,
                                    image: DecorationImage(
                                        image:
                                        imageProvider,
                                        fit: BoxFit
                                            .contain)),
                              ),
                            ),
                            const Gap(12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${controller.callHistoryList[index].receiver?.firstName ?? ""} ${controller.callHistoryList[index].receiver?.lastName ?? ""}",
                                    style: AppTextStyle.appTextStyle(
                                      textColor: AppColors.colorDarkA,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700
                                    ),
                                  ),
                                  const Gap(4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          controller.callHistoryList[index].callDuration.toString().replaceAll('-', ''),
                                          style:
                                          AppTextStyle.appTextStyle(
                                              textColor: AppColors.colorDarkA,
                                              fontSize: 12,
                                              fontWeight:
                                              FontWeight.w400
                                          )
                                      ),
                                      Text(
                                          controller.formattedDate(controller.callHistoryList[index].endTime ?? ""),
                                          style: AppTextStyle.appTextStyle(
                                              textColor: AppColors.colorDarkA,
                                              fontSize: 12,
                                              fontWeight:
                                              FontWeight.w500
                                          )
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }else{
                      return Padding(
                        padding: index == (controller.callHistoryList.length - 1) ?
                        EdgeInsets.zero : const EdgeInsetsDirectional.only(bottom: 12),                        child: Row(
                          children: [
                            controller.callHistoryList[index].caller?.profileImage?.file == null ? Container(
                              height: 52,
                              width: 52,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(AppImages.iluImage)
                                  )
                              ),
                            ) : CachedNetworkImage(
                              imageUrl: "${ApiUrlContainer.baseUrl}${controller.callHistoryList[index].caller?.profileImage?.file.toString()}",
                              errorWidget: (context, url, error) => Image.asset(
                                AppImages.iluImage,
                                height: 52,
                                width: 52,
                              ),
                              imageBuilder: (context, imageProvider) => Container(
                                height: 52,
                                width: 52,
                                decoration: BoxDecoration(
                                    shape:
                                    BoxShape.circle,
                                    image: DecorationImage(
                                        image:
                                        imageProvider,
                                        fit: BoxFit
                                            .contain)),
                              ),
                            ),
                            const Gap(12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${controller.callHistoryList[index].caller?.firstName ?? ""} ${controller.callHistoryList[index].caller?.lastName ?? ""}",
                                    style: AppTextStyle.appTextStyle(
                                        textColor: AppColors.colorDarkA,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700
                                    ),
                                  ),
                                  const Gap(4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          controller.callHistoryList[index].callDuration.toString().replaceAll('-', ''),
                                          style:
                                          AppTextStyle.appTextStyle(
                                              textColor: AppColors.colorDarkA,
                                              fontSize: 12,
                                              fontWeight:
                                              FontWeight.w400
                                          )
                                      ),
                                      Text(
                                          controller.formattedDate(controller.callHistoryList[index].endTime ?? ""),
                                          style: AppTextStyle.appTextStyle(
                                              textColor: AppColors.colorDarkA,
                                              fontSize: 12,
                                              fontWeight:
                                              FontWeight.w500
                                          )
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  }),
                ),

                /// --------------- pagination loader
                controller.hasNext() ? const Padding(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 16),
                  child: CircularProgressIndicator(color: AppColors.colorDarkA),
                ) : const SizedBox(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
