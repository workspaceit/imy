import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_images.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/message/controllers/message_controller.dart';
import 'package:ilu/app/routes/app_pages.dart';

import '../../../../core/utils/my_date_utils.dart';

class MessageListWidgets extends StatelessWidget {
  const MessageListWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
      builder: (controller) {
        if(controller.isSearch){
          return controller.isLoading ? const Center(
            child: CircularProgressIndicator(),
          ) : controller.searchList.isEmpty ? Center(
            child: Text(
              "No messages available",
              textAlign: TextAlign.center,
              style: AppTextStyle.appTextStyle(
                  textColor: AppColors.colorDarkA,
                  fontWeight: FontWeight.w600,
                  fontSize: 14
              ),
            ),
          ) : SingleChildScrollView(
            padding: const EdgeInsets.only(left: 24, bottom: 20),
            child: Column(
              children: List.generate(controller.searchList.length, (index) {
                  if(controller.searchList[index].isBlocked == true){
                    return const SizedBox();
                  }else{
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          /// -------------------- profile button
                          GestureDetector(
                            onTap: () {
                              controller
                                  .repo.apiService.sharedPreferences
                                  .setInt(
                                  LocalStorageHelper
                                      .detailsProfileUserIdKey,
                                  int.parse(controller
                                      .searchList[index].id));
                              controller.update();
                              Get.toNamed(Routes.DETAILS_PROFILE);
                              controller.isSearch = false;
                              controller.searchTextField.text = "";
                            },
                            child: Container(
                              padding: const EdgeInsetsDirectional
                                  .symmetric(
                                  horizontal: 12, vertical: 24),
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: AppColors.colorYellow),
                              child: Text(
                                "Profile",
                                textAlign: TextAlign.center,
                                style: AppTextStyle.appTextStyle(
                                    textColor: AppColors.colorDarkA,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          /// -------------------- block button
                          GestureDetector(
                            onTap: (){
                              controller.makeUserBlock(int.tryParse(controller.chatList[index].id) ?? 0);
                            },
                            child: Container(
                              padding:
                              const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 24),
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  gradient: AppColors.redGradient),
                              child: Text(
                                "Block",
                                textAlign: TextAlign.center,
                                style: AppTextStyle.appTextStyle(
                                    textColor: AppColors.colorWhite,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(bottom: 12, end: 24),
                        child: InkWell(
                            onTap: () {
                              controller.repo.apiService.sharedPreferences.setInt(LocalStorageHelper.detailsProfileUserIdKey,
                                  int.parse(controller.searchList[index].id));
                              Get.toNamed(Routes.CHAT);
                            },
                            child: Row(
                              children: [
                                (controller.searchList[index].image == '')
                                    ? Container(
                                  height: 52,
                                  width: 52,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              AppImages
                                                  .iluImage))),
                                ) : CachedNetworkImage(
                                  imageUrl: controller
                                      .searchList[index].image,
                                  errorWidget:
                                      (context, url, error) =>
                                      Image.asset(
                                        AppImages.iluImage,
                                        height: 52,
                                        width: 52,
                                      ),
                                  imageBuilder:
                                      (context, imageProvider) =>
                                      Container(
                                        height: 52,
                                        width: 52,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.contain)),
                                      ),
                                ),
                                const Gap(12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      /// ------------------ chat user name
                                      Text(
                                          controller.searchList[index].name,
                                          style:
                                          AppTextStyle.appTextStyle(
                                              textColor: AppColors
                                                  .colorDarkA,
                                              fontSize: 16,
                                              fontWeight:
                                              FontWeight.w700)),
                                      const Gap(4),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          (controller.searchList[index]
                                              .about ==
                                              '' ||
                                              controller
                                                  .searchList[
                                              index]
                                                  .about
                                                  .contains(
                                                  'http') ==
                                                  true)
                                              ? Expanded(
                                            child: Text('photo',
                                                maxLines: 1,
                                                style: AppTextStyle.appTextStyle(
                                                    textColor: AppColors
                                                        .colorDarkA
                                                        .withOpacity(
                                                        0.5),
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight
                                                        .w400)),
                                          )
                                              : Expanded(
                                            child: Text(
                                                controller
                                                    .searchList[
                                                index]
                                                    .about,
                                                maxLines: 1,
                                                style: AppTextStyle.appTextStyle(
                                                    textColor: AppColors
                                                        .colorDarkA
                                                        .withOpacity(
                                                        0.5),
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight
                                                        .w400)),
                                          ),
                                          Text(
                                              MyDateUtil
                                                  .getLastMessageTime(
                                                  context: context,
                                                  time: controller
                                                      .searchList[
                                                  index]
                                                      .createdAt),
                                              style: AppTextStyle
                                                  .appTextStyle(
                                                  textColor: AppColors
                                                      .colorDarkA,
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight
                                                      .w500)),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                        ),
                      ),
                    );
                  }
              })
            ),
          );
        }else{
          return controller.isLoading ?
          const Center(
            child: CircularProgressIndicator(),
          ) : controller.chatList.isEmpty ? Center(
            child: Text(
              "No messages available",
              textAlign: TextAlign.center,
              style: AppTextStyle.appTextStyle(
                  textColor: AppColors.colorDarkA,
                  fontWeight: FontWeight.w600,
                  fontSize: 14
              ),
            ),
          ) : SingleChildScrollView(
            padding: const EdgeInsets.only(left: 24, bottom: 20),
            child: Column(
               children: List.generate(controller.chatList.length, (index){
                   if(controller.chatList[index].isBlocked == true){
                     return const SizedBox();
                   }else{
                     return Slidable(
                       endActionPane: ActionPane(
                         motion: const ScrollMotion(),
                         children: [
                           /// -------------------- profile button
                           GestureDetector(
                             onTap: () {
                               controller
                                   .repo.apiService.sharedPreferences
                                   .setInt(
                                   LocalStorageHelper
                                       .detailsProfileUserIdKey,
                                   int.parse(controller
                                       .chatList[index].id));
                               controller.update();
                               Get.toNamed(Routes.DETAILS_PROFILE);
                               controller.isSearch = false;
                               controller.searchTextField.text = "";
                             },
                             child: Container(
                               padding: const EdgeInsetsDirectional
                                   .symmetric(
                                   horizontal: 12, vertical: 24),
                               alignment: Alignment.center,
                               decoration: const BoxDecoration(
                                   color: AppColors.colorYellow),
                               child: Text(
                                 "Profile",
                                 textAlign: TextAlign.center,
                                 style: AppTextStyle.appTextStyle(
                                     textColor: AppColors.colorDarkA,
                                     fontSize: 14,
                                     fontWeight: FontWeight.w400),
                               ),
                             ),
                           ),
                           /// -------------------- block button
                           GestureDetector(
                             onTap: (){
                               controller.makeUserBlock(int.tryParse(controller.chatList[index].id) ?? 0);
                             },
                             child: Container(
                               padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 24),
                               alignment: Alignment.center,
                               decoration: const BoxDecoration(gradient: AppColors.redGradient),
                               child: Text(
                                 "Block",
                                 textAlign: TextAlign.center,
                                 style: AppTextStyle.appTextStyle(
                                     textColor: AppColors.colorWhite,
                                     fontSize: 14,
                                     fontWeight: FontWeight.w400
                                 ),
                               ),
                             ),
                           )
                         ],
                       ),
                       child: Padding(
                         padding: const EdgeInsetsDirectional.only(bottom: 12, end: 24),
                         child: InkWell(
                           onTap: () {
                             controller.repo.apiService.sharedPreferences.setInt(LocalStorageHelper.detailsProfileUserIdKey, int.parse(controller.chatList[index].id));
                             Get.toNamed(Routes.CHAT);
                           },
                           child: Row(
                             children: [
                               (controller.chatList[index].image == '') ? Container(
                                 height: 52,
                                 width: 52,
                                 decoration: const BoxDecoration(
                                     shape: BoxShape.circle,
                                     image: DecorationImage(
                                         image: AssetImage(
                                             AppImages
                                                 .iluImage))),
                               ) : CachedNetworkImage(
                                 imageUrl: controller
                                     .chatList[index].image,
                                 errorWidget:
                                     (context, url, error) =>
                                     Image.asset(
                                       AppImages.iluImage,
                                       height: 52,
                                       width: 52,
                                     ),
                                 imageBuilder:
                                     (context, imageProvider) =>
                                     Container(
                                       height: 52,
                                       width: 52,
                                       decoration: BoxDecoration(
                                           shape: BoxShape.circle,
                                           image: DecorationImage(
                                               image: imageProvider,
                                               fit: BoxFit.contain)),
                                     ),
                               ),
                               const Gap(12),
                               Expanded(
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     /// ------------------ chat user name
                                     Text(
                                         '${controller.chatList[index].name}',
                                         // "${controller.chatList[index]["chat_user"]["first_name"]} ${controller.chatList[index]["chat_user"]["last_name"]}",
                                         style:
                                         AppTextStyle.appTextStyle(
                                             textColor: AppColors
                                                 .colorDarkA,
                                             fontSize: 16,
                                             fontWeight:
                                             FontWeight.w700)),
                                     const Gap(4),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         (controller.chatList[index].about == '' || controller.chatList[index].about.contains('http') == true)
                                             ? Expanded(
                                           child: Text('photo',
                                               maxLines: 1,
                                               style: AppTextStyle.appTextStyle(
                                                   textColor: AppColors.colorDarkA.withOpacity(0.5),
                                                   fontSize: 14,
                                                   fontWeight:
                                                   FontWeight.w400
                                               )
                                           ),
                                         ) : Expanded(
                                           child: Text(
                                               controller.chatList[index].about,
                                               maxLines: 1,
                                               style: AppTextStyle.appTextStyle(
                                                   textColor: AppColors.colorDarkA.withOpacity(0.5),
                                                   fontSize: 14,
                                                   fontWeight: FontWeight.w400
                                               )
                                           ),
                                         ),
                                         Text(
                                             MyDateUtil.getLastMessageTime(context: context, time: controller.chatList[index].createdAt),
                                             style: AppTextStyle.appTextStyle(
                                                 textColor: AppColors.colorDarkA,
                                                 fontSize: 12,
                                                 fontWeight: FontWeight.w500
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
                       ),
                     );
                   }
               })
            ),
          );
        }
      }
    );
  }
}
