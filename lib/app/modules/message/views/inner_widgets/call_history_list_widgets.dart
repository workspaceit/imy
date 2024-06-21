import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/message/controllers/message_controller.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:ilu/app/widgets/buttons/custom_button.dart';
import 'package:ilu/app/widgets/buttons/custom_outline_button.dart';
import 'package:ilu/app/widgets/dialog/custom_dialog.dart';

import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/my_date_utils.dart';

class CallHistoryListWidgets extends StatelessWidget {
  final ScrollController scrollController;
  const CallHistoryListWidgets({required this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
        builder: (controller) => controller.isCallHistoryLoading ? const Center(
          child: CircularProgressIndicator(color: AppColors.colorWhite),
        ) : controller.callHistoryList.isEmpty ? Center(
                    child: Text(
                      "No call history available",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.appTextStyle(
                          textColor: AppColors.colorDarkA,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                : SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.only(left: 24, bottom: 20, right: 24),
          child: Column(
                      children: [
                        Column(
                          children: List.generate(
                            controller.callHistoryList.length, (index) {
                              if(controller.callHistoryList[index].caller!.id == controller.currentUserId){
                                return Container(
                                  margin: index == (controller.callHistoryList.length - 1 ) ? EdgeInsets.zero : const EdgeInsetsDirectional.only(bottom: 12),
                                  width: Get.width,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
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
                                            const Gap(8),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${controller.callHistoryList[index].receiver?.firstName ?? ""} ${controller.callHistoryList[index].receiver?.lastName ?? ""}",
                                                    style: AppTextStyle.appTextStyle(
                                                        textColor: AppColors.colorDarkA,
                                                        fontSize: 16,
                                                        fontWeight:
                                                        FontWeight.w700
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                          controller.formattedDate(controller.callHistoryList[index].endTime ?? ""),
                                                          style: AppTextStyle.appTextStyle(
                                                              textColor: AppColors.colorDarkA,
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight.w500
                                                          )
                                                      ),
                                                      const Gap(12),
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
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                         controller.rechargeBalance < 2 ? showDialog(
                                             context: Get.context!,
                                             builder: (_) => CustomDialog(
                                               width: kIsWeb ? 400 : null,
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
                                                           kIsWeb ? showDialog(
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
                                                               )
                                                           ) : showModalBottomSheet(
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
                                             )) : controller.userDetailsData(id: controller.callHistoryList[index].receiver?.id ?? 0)
                                              .then((value) {
                                            controller.fetchAgoraToken();
                                          });
                                        },
                                        alignment: Alignment.center,
                                        padding: EdgeInsetsDirectional.zero,
                                        icon: Container(
                                            height: 52,
                                            width: 52,
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                                color: AppColors.colorGrayB,
                                                shape: BoxShape.circle),
                                            child: SizedBox(
                                              height: 16,
                                              width: 16,
                                              child: SvgPicture.asset(
                                                  AppIcons.verifyContactField,
                                                  color:
                                                  AppColors.colorDarkA),
                                            )),
                                      ),
                                    ],
                                  ),
                                );
                              }else{
                                return Container(
                                  margin: index == (controller.callHistoryList.length - 1 ) ? EdgeInsets.zero : const EdgeInsetsDirectional.only(bottom: 12),
                                  width: Get.width,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
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
                                            const Gap(8),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${controller.callHistoryList[index].caller?.firstName ?? ""} ${controller.callHistoryList[index].caller?.lastName ?? ""}",
                                                    style: AppTextStyle.appTextStyle(
                                                        textColor: AppColors.colorDarkA,
                                                        fontSize: 16,
                                                        fontWeight:
                                                        FontWeight.w700
                                                    ),
                                                  ),
                                                  const Gap(4),
                                                  Row(
                                                    children: [
                                                      Text(
                                                          controller.formattedDate(controller.callHistoryList[index].endTime ?? ""),
                                                          style: AppTextStyle.appTextStyle(
                                                              textColor: AppColors.colorDarkA,
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight.w500
                                                          )
                                                      ),
                                                      const Gap(12),
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
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          controller.userDetailsData(id: controller.callHistoryList[index].caller?.id ?? 0)
                                              .then((value) {
                                            controller.fetchAgoraToken();
                                          });
                                        },
                                        alignment: Alignment.center,
                                        padding: EdgeInsetsDirectional.zero,
                                        icon: Container(
                                            height: 52,
                                            width: 52,
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                                color: AppColors.colorGrayB,
                                                shape: BoxShape.circle),
                                            child: SizedBox(
                                              height: 16,
                                              width: 16,
                                              child: SvgPicture.asset(
                                                  AppIcons.verifyContactField,
                                                  color:
                                                  AppColors.colorDarkA),
                                            )),
                                      ),
                                    ],
                                  ),
                                );
                              }
                          }),
                        ),
                        controller.hasNext() ?
                        const Padding(
                          padding: EdgeInsetsDirectional.symmetric(vertical: 16),
                          child: CircularProgressIndicator(color: AppColors.colorDarkA),
                        ) : const SizedBox(),
                      ],
                    )
        )
    );
  }
}
