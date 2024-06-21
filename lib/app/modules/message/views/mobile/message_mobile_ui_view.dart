import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/message/controllers/message_controller.dart';
import 'package:ilu/app/modules/message/views/inner_widgets/call_history_list_widgets.dart';
import 'package:ilu/app/modules/message/views/inner_widgets/message_list_widgets.dart';
import 'package:ilu/app/widgets/bottom_nav/main_bottom_nav.dart';
import 'package:ilu/app/widgets/text_form_field/custom_text_form_field.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class MessageMobileUiView extends StatefulWidget {
  final ScrollController scrollController;
  const MessageMobileUiView({required this.scrollController, super.key});

  @override
  State<MessageMobileUiView> createState() => _MessageMobileUiViewState();
}

class _MessageMobileUiViewState extends State<MessageMobileUiView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<MessageController>(builder: (controller) {
        return GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: PopScope(
            canPop: !controller.isSearch,
            onPopInvoked: (_){
              if (controller.isSearch) {
                controller.searchCheck();
              }
            },
            child: Scaffold(
              backgroundColor: AppColors.colorWhite,
              appBar: AppBar(
                backgroundColor: AppColors.colorWhite,
                automaticallyImplyLeading: false,
                title: GradientText("Messages",
                    style: AppTextStyle.appTextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.w700),
                    colors: const [
                      Color(0xffFF597B),
                      Color(0xffF5827A),
                    ]),
              ),
              body: Column(
                children: [
                  // ------------------- screen search bar
                  Padding(
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        CustomTextFormField(
                          textInputAction: TextInputAction.done,
                          textEditingController: controller.searchTextField,
                          prefixIcon: Padding(
                            padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
                            child: SvgPicture.asset(AppIcons.search),
                          ),
                          hintText: "Search in message ...",
                          onChanged: (_) {
                            controller.searchData();
                          },
                        ),
                        const Gap(12),

                        // todo - tab
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                              controller.inactiveTablist.length,
                              (index) => Expanded(
                                    child: GestureDetector(
                                    onTap: () => controller.changeTab(index),
                                    child: index == controller.selectedTab
                                        ? Container(
                                            width: Get.width,
                                            margin: EdgeInsetsDirectional.only(
                                                end: index ==
                                                        controller.inactiveTablist
                                                                .length -
                                                            1
                                                    ? 0
                                                    : 8),
                                            padding:
                                                const EdgeInsetsDirectional.symmetric(
                                                    vertical: 6, horizontal: 30),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: AppColors.colorWhite,
                                                border: const GradientBoxBorder(
                                                    gradient:
                                                        AppColors.primaryGradient),
                                                borderRadius:
                                                    BorderRadius.circular(99)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 16,
                                                  width: 16,
                                                  child: SvgPicture.asset(controller
                                                      .activeTablist[index]["icon"]
                                                      .toString()),
                                                ),
                                                const Gap(10),
                                                Expanded(
                                                  child: GradientText(
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      controller.activeTablist[index]
                                                              ["title"]
                                                          .toString(),
                                                      style: AppTextStyle.appTextStyle(
                                                          fontSize: 16.0,
                                                          fontWeight: FontWeight.w600),
                                                      colors: const [
                                                        Color(0xffFFD000),
                                                        Color(0xffF80261),
                                                        Color(0xff7017FF)
                                                      ]),
                                                )
                                              ],
                                            ),
                                          )
                                        : Container(
                                            width: Get.width,
                                            margin: EdgeInsetsDirectional.only(
                                                end: index ==
                                                        controller.inactiveTablist
                                                                .length -
                                                            1
                                                    ? 0
                                                    : 8),
                                            padding:
                                                const EdgeInsetsDirectional.symmetric(
                                                    vertical: 6, horizontal: 30),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: AppColors.colorWhite,
                                                border: Border.all(
                                                    color: AppColors.colorDarkA,
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(99)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 16,
                                                  width: 16,
                                                  child: SvgPicture.asset(controller
                                                      .inactiveTablist[index]["icon"]
                                                      .toString()),
                                                ),
                                                const Gap(10),
                                                Expanded(
                                                  child: Text(
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    controller.inactiveTablist[index]
                                                            ["title"]
                                                        .toString(),
                                                    style: AppTextStyle.appTextStyle(
                                                        textColor: AppColors.colorDarkA,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w600),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                  ))),
                        )
                      ],
                    ),
                  ),
                  const Gap(20),
                  // --------------- list
                  Flexible(
                    child: PageView(
                      controller: controller.pageController,
                      onPageChanged: (value) => controller.changePage(value),
                      children: List.generate(
                          controller.inactiveTablist.length,
                          (index) => controller.selectedTab == 0
                              ? const MessageListWidgets()
                              : CallHistoryListWidgets(scrollController: widget.scrollController)
                      ),
                    ),
                  )
                ],
              ),
              bottomNavigationBar: const MainBottomNav(currentScreen: 1),
            ),
          ),
        );
      }),
    );
  }
}
