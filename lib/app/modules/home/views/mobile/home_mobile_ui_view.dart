import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:gradient_icon/gradient_icon.dart';
import 'package:ilu/app/core/constants/country/country_list.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_images.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/core/utils/app_utils.dart';
import 'package:ilu/app/modules/home/controllers/home_controller.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:ilu/app/widgets/bottom_nav/main_bottom_nav.dart';
import 'package:ilu/app/widgets/buttons/custom_button.dart';
import 'package:ilu/app/widgets/card/custom_card.dart';
import 'package:ilu/app/widgets/card/custom_card_empty_image.dart';
import 'package:ilu/app/widgets/text_form_field/custom_text_form_field.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class HomeMobileUiView extends StatelessWidget {
  final ScrollController scrollController;
  const HomeMobileUiView({required this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<HomeController>(builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.colorWhite,
          /// ------------------ appbar
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.colorWhite,
            automaticallyImplyLeading: false,
            title: SizedBox(
                height: 100,
                width: 100,
                child: Image.asset(AppImages.appLogoImage)
            ),
            actions: [
              /// ------------------- reward point button
              InkWell(
                hoverColor: AppColors.colorRedB,
                borderRadius: BorderRadius.circular(8),
                onTap: (){
                  /// ----------- this method is used to withdraw reward points
                  controller.withdrawRewardPoints();
                },
                child: Container(
                  width: 120, height: 40,
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: const GradientBoxBorder(
                        gradient: AppColors.primaryGradient,
                        width: 1
                      )
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                          height: 20, width: 20,
                          child: SvgPicture.asset("assets/icons/reward_point.svg", color: const Color(0xfff80261))
                      ),
                      const Gap(8),
                      Text(
                        "${controller.rewardPoints}",
                        textAlign: TextAlign.start,
                        style: AppTextStyle.appTextStyle(
                            textColor: const Color(0xfff80261),
                            fontWeight: FontWeight.w700,
                            fontSize: 16
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(12),
              /// ------------------- gender pop up
              PopupMenuButton(
                shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          color: AppColors.colorGrayA
                      ),
                      borderRadius: BorderRadius.circular(12)
                  ),
                elevation: 0,
                color: AppColors.colorWhite,
                padding: const EdgeInsetsDirectional.symmetric(vertical: 12, horizontal: 12),
                offset: const Offset(0, 55),
                onSelected: (value){},
                child: Container(
                    height: 42,
                    padding: const EdgeInsetsDirectional.symmetric(vertical: 8, horizontal: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.colorWhite,
                        border: const GradientBoxBorder(
                            gradient: AppColors.primaryGradient,
                            width: 1
                        ),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GradientText(
                            controller.gender,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.appTextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400),
                            colors: const [
                              Color(0xffFFD000),
                              Color(0xffF80261),
                              Color(0xff7017FF)
                            ]
                        ),
                        const Gap(8),
                        const GradientIcon(
                          icon: Icons.keyboard_arrow_down,
                          gradient: AppColors.primaryGradient,
                          size: 20,
                          offset: Offset(0, 0),
                        )
                      ],
                    ),
                  ),
                itemBuilder: (context) => List.generate(controller.genderList.length, (index) => PopupMenuItem(
                  onTap: () => controller.chooseGender(index),
                    child: Text(
                      controller.genderList[index],
                      style: AppTextStyle.appTextStyle(
                        textColor: AppColors.colorDarkA,
                        fontWeight: FontWeight.w400,
                        fontSize: 14
                      ),
                    )
                  ),
                )
              ),
              const Gap(24),
            ],
          ),
          /// ----------------------------- body
          body: controller.isLoading ? const Center(
            child: CircularProgressIndicator(
              color: AppColors.colorDarkB,
            ),
          ) : SingleChildScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsetsDirectional.symmetric( vertical: 20, horizontal: 24),
            child: Column(
              children: [
                /// ---------------------- home screen top section
                Container(
                  width: Get.width,
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.colorRedB,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// ------------------------ show recharge balance amount
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "My Recharge Balance",
                                style: AppTextStyle.appTextStyle(
                                  textColor: AppColors.colorDarkA,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                              const Gap(8),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 24, width: 24,
                                    child: SvgPicture.asset(AppIcons.iluCoin),
                                  ),
                                  const Gap(4),
                                  GradientText(
                                      "${controller.rechargeBalance}",
                                      style: AppTextStyle.appTextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold
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
                          /// ------------------------ recharge button
                          InkWell(
                            hoverColor: AppColors.colorRedB,
                            borderRadius: BorderRadius.circular(8),
                            onTap: (){
                              /// ------------------ recharge balance button bottom sheet
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: AppColors.colorWhite,
                                constraints: const BoxConstraints(maxHeight: 250),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                                ),
                                builder: (context) => Container(
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
                            child: Container(
                              width: 100,
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
                                  fontSize: 12
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const Gap(16),
                      /// ------------------- divider start
                      Divider(color: AppColors.colorDarkA.withOpacity(0.2), height: 1),
                      const Gap(16),
                      /// ------------------- select country and gender section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// -------------------- select country section
                          Row(
                            children: [
                              const GradientIcon(
                                offset: Offset(0, 0),
                                icon: Icons.language_rounded,
                                gradient: AppColors.primaryGradient,
                                size: 16,
                              ),
                              const Gap(8),
                              Text(
                                "Country",
                                style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkA, fontWeight: FontWeight.w600, fontSize: 12),
                              )
                            ],
                          ),
                          const Gap(12),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  backgroundColor: AppColors.colorWhite,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                                  ),
                                  context: context, builder: (context) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 24, vertical: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Select Country",
                                            textAlign:
                                            TextAlign.left,
                                            style: AppTextStyle.appTextStyle(
                                                textColor: AppColors.colorDarkA,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () async{
                                                Get.back();
                                                controller.isFilterLoading = true;
                                                controller.update();
                                                controller.page = 0;
                                                controller.userDataList.clear();
                                                controller.selectedCountryIndex = -1;
                                                controller.selectedCityIndex = -1;
                                                controller.cityId = 0;
                                                controller.district = "";
                                                controller.country = "";
                                                await controller.loadUserData();
                                                controller.isFilterLoading = false;
                                                controller.update();
                                              },
                                              iconSize: 20,
                                              icon: const Icon(Icons.clear, color: AppColors.colorDarkA)
                                          )
                                        ],
                                      )
                                  ),
                                  Flexible(
                                    child: SingleChildScrollView(
                                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
                                      physics: const BouncingScrollPhysics(),
                                      child:
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: List.generate(
                                            countryList.length, (index) => GestureDetector(
                                          onTap: (){
                                            controller.chooseCountry(index, context);
                                          },
                                          child: Container(
                                            padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
                                            margin: const EdgeInsetsDirectional.only(bottom: 8),
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                                color: index == controller.selectedCountryIndex ? const Color(0xff7017ff) : AppColors.colorWhite,
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: index == controller.selectedCountryIndex ? const Color(0xff7017ff) : AppColors.colorGrayB,
                                                    width: 1
                                                )
                                            ),
                                            child: Text(
                                              countryList[index].name,
                                              style: AppTextStyle.appTextStyle(
                                                  textColor: index == controller.selectedCountryIndex ? AppColors.colorWhite : AppColors.colorDarkB,
                                                  fontSize: 14, fontWeight: FontWeight.w400
                                              ),
                                            ),
                                          ),
                                        )),
                                      ),
                                    ),
                                  )
                                ],
                              ));
                            },
                            child: Container(
                              width: Get.width,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsetsDirectional.symmetric(vertical: 8, horizontal: 16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: const GradientBoxBorder(gradient: AppColors.primaryGradient)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: controller.district.isEmpty && controller.country.isEmpty ? Text(
                                        "All",
                                        style: AppTextStyle.appTextStyle(
                                            textColor: AppColors.colorDarkA,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400
                                        )
                                    ) :
                                    controller.district.isNotEmpty ? Text("${controller.district}, ${controller.country}",
                                        style: AppTextStyle.appTextStyle(
                                            textColor: AppColors.colorDarkA,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400
                                        )
                                    ) : Text(
                                        controller.country,
                                        style: AppTextStyle.appTextStyle(
                                            textColor: AppColors.colorDarkA,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400
                                        )
                                    ),
                                  ),
                                  const Gap(12),
                                  const GradientIcon(
                                      offset: Offset(0, 0),
                                      icon: Icons.keyboard_arrow_down,
                                      gradient: AppColors.primaryGradient,
                                      size: 24
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const Gap(16),
                /// ----------------------- screen search bar ------------------------------
                CustomTextFormField(
                  textEditingController: controller.searchController,
                  textInputAction: TextInputAction.done,
                  prefixIcon: Padding(
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 12, vertical: 12),
                    child: SvgPicture.asset(AppIcons.search),
                  ),
                  hintText: "Search by name and id...",
                  onChanged: (value) async {
                    if(!controller.isFiltering){
                      controller.isFiltering = true;
                      Get.find<HomeController>().update();

                      await controller.filterSearchData();

                      controller.isFiltering = false;
                      Get.find<HomeController>().update();
                    }
                  },
                ),
                const Gap(16),
                /// ----------------------- grid content
                controller.isFilterLoading ? const Padding(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 150),
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.colorDarkA),
                  ),
                ) : controller.userDataList.isEmpty ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Gap(150),
                      Text(
                        "No User Available",
                        textAlign: TextAlign.center,
                        style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkA, fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const Gap(150),
                    ],
                  ),
                ) : Column(
                  children: [
                    GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsetsDirectional.zero,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          mainAxisExtent: 225
                      ),
                      children: List.generate(controller.userDataList.length, (index) {
                        // if (index == controller.userDataList.length) {
                        //   return controller.hasNext() ?
                        //   const CircularProgressIndicator(color: AppColors.colorDarkA) : const SizedBox();
                        // }
                        return                         GestureDetector(
                          onTap: () {
                            controller.homeRepo.apiService.sharedPreferences.setInt(LocalStorageHelper.detailsProfileUserIdKey, controller.userDataList[index].id ?? -1);
                            controller.update();
                            Get.toNamed(Routes.DETAILS_PROFILE);
                          },
                          child: controller.userDataList[index].profileImage == null ? CustomCardEmptyImage(
                              imageSrc: AppImages.iluImage,
                              username: "${controller.userDataList[index].firstName} ${controller.userDataList[index].lastName}",
                              userId: "ID ${controller.userDataList[index].uniqueId ?? ""}",
                              userAge: "${controller.userDataList[index].age ?? ""} y"
                          ) : CustomCard(
                              imageSrc: "${ApiUrlContainer.baseUrl}${controller.userDataList[index].profileImage?.file}",
                              username: "${controller.userDataList[index].firstName} ${controller.userDataList[index].lastName}",
                              userId: "ID ${controller.userDataList[index].uniqueId ?? ""}",
                              userAge: "${controller.userDataList[index].age ?? ""} y"
                          ),
                        )
                        ;
                      }),
                    ),
                    controller.hasNext() ?
                    const Padding(
                      padding: EdgeInsetsDirectional.symmetric(vertical: 16),
                      child: CircularProgressIndicator(color: AppColors.colorDarkA),
                    ) : const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
          bottomNavigationBar: const MainBottomNav(currentScreen: 0),
        );
      }),
    );
  }
}
