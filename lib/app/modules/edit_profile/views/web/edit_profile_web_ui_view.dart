import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:ilu/app/modules/edit_profile/controllers/edit_profile_controller.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:ilu/app/widgets/text_form_field/custom_text_form_field.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class EditProfileWebUiView extends StatelessWidget {
  const EditProfileWebUiView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<EditProfileController>(
          builder: (controller) => Scaffold(
            backgroundColor: AppColors.colorWhite,
            /// ----------------------- appbar ---------------------------------
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColors.colorWhite,
              leading: IconButton(
                onPressed: () => Get.toNamed(Routes.PROFILE),
                alignment: Alignment.center,
                icon: SvgPicture.asset(AppIcons.arrowBack),
                iconSize: 24
              ),
              title: Text(
                "Edit Profile",
                textAlign: TextAlign.center,
                style: AppTextStyle.appTextStyle(
                  textColor: AppColors.colorDarkA,
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                ),
              ),
              centerTitle: true,
              actions: [
                /// --------------------- save button ---------------------------------
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 40),
                  child: TextButton(
                      onPressed: () {
                        if(controller.editProfileFormKey.currentState!.validate()){
                          controller.updateUser();
                        }
                      },
                      child: controller.isSubmit
                          ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(
                          color: AppColors.colorDarkA,
                          strokeWidth: 2,
                        ),
                      ) : GradientText("Save",
                          style: AppTextStyle.appTextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                          colors: const [
                            Color(0xffFFD000),
                            Color(0xffF80261),
                            Color(0xff7017FF)
                          ])),
                )
              ],
            ),
            /// ------------------------- body ----------------------------------------
            body: controller.isLoading ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.colorDarkA,
              ),
            ) : SingleChildScrollView(
              padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 24),
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: 600,
                  child: Column(
                    children: [
                      /// ------------------- user profile update form -----------------------
                      Form(
                        key: controller.editProfileFormKey,
                        child: Column(
                          children: [
                            /// -------------------- username field ------------------------
                            CustomTextFormField(
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.name,
                              textEditingController: controller.usernameController,
                              hintText: "Username",
                              prefixIcon: Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 12,
                                    top: 16,
                                    bottom: 16,
                                    end: 8
                                ),
                                child: SvgPicture.asset(AppIcons.nameField),
                              ),
                              formValidator: (value) {
                                if (value.isEmpty) {
                                  return "Please enter username.";
                                } else if(
                                value.toString().contains("IMY") || value.toString().contains("IMy") || value.toString().contains("ImY")
                                    || value.toString().contains("Imy") || value.toString().contains("imy") || value.toString().contains("iMY")
                                    || value.toString().contains("imY")
                                ){
                                  return "Username can not contain IMY";
                                } else if(RegExp(r'[!@#%^&*(),.?":{}|<>]').hasMatch(value)){
                                  return "Username can not contain special characters";
                                } else if (RegExp(r'[0-9]').hasMatch(value)) {
                                  return 'Username can not contain digits';
                                }else {
                                  return null;
                                }
                              },
                            ),
                            const Gap(12),
                            /// -------------------- gender and dob field ------------------
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                /// -------------- gender field --------------------
                                Expanded(
                                  flex: 1,
                                  child: CustomTextFormField(
                                      readOnly: true,
                                      textInputAction:
                                      TextInputAction.next,
                                      textEditingController:
                                      controller.genderController,
                                      hintText: "Gender",
                                      fillColor:
                                      AppColors.colorLightWhite),
                                ),
                                const Gap(12),
                                /// -------------- date of birth field -------------
                                Expanded(
                                  flex: 2,
                                  child: CustomTextFormField(
                                    readOnly: true,
                                    textInputAction: TextInputAction.next,
                                    textEditingController:
                                    controller.dobController,
                                    hintText: "Date of Birth",
                                    prefixIcon: Padding(
                                      padding: const EdgeInsetsDirectional
                                          .only(
                                          start: 12,
                                          top: 16,
                                          bottom: 16,
                                          end: 8),
                                      child: SvgPicture.asset(
                                          AppIcons.calender),
                                    ),
                                    onTap: () =>
                                        controller.pickDobDate(context),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Gap(20),
                      /// -------------------- upload photo section -------------------------------
                      GridView.builder(// Ensure GridView rebuilds when selectedIndex changes
                        shrinkWrap: true,
                        itemCount: 5,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.zero,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          mainAxisExtent: 250,
                        ),
                        itemBuilder: (context, index) {
                          if (controller.profileImages.isEmpty) {
                            return InkWell(
                              hoverColor: AppColors.colorWhite,
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                controller.picImageFromPc(index);
                              },
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
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: index == controller.selectedPickImageIndex ? const SizedBox(
                                    height: 24, width: 24,
                                    child: CircularProgressIndicator(color: AppColors.colorDarkA, strokeWidth: 2),
                                  ) :  const GradientIcon(
                                    icon: Icons.add,
                                    offset: Offset(0, 0),
                                    gradient: AppColors.primaryGradient,
                                    size: 24,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            if (index < controller.profileImages.length) {
                              return InkWell(
                                hoverColor: AppColors.colorWhite,
                                borderRadius: BorderRadius.circular(12),
                                onTap: () async{
                                  await controller.deleteProfileImage(index);
                                },
                                child: CachedNetworkImage(
                                  imageUrl: "${ApiUrlContainer.baseUrl}${controller.profileImages[index].file.toString()}",
                                  imageBuilder: (context, imageProvider) => Container(
                                    width: Get.width,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: AppColors.colorRedB,
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.contain,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                      border: const GradientBoxBorder(
                                        gradient: AppColors.primaryGradient,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return InkWell(
                                hoverColor: AppColors.colorWhite,
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  controller.picImageFromPc(index);
                                },
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
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: index == controller.selectedPickImageIndex ? const SizedBox(
                                      height: 24, width: 24,
                                      child: CircularProgressIndicator(color: AppColors.colorDarkA, strokeWidth: 2),
                                    ) :  const GradientIcon(
                                      icon: Icons.add,
                                      offset: Offset(0, 0),
                                      gradient: AppColors.primaryGradient,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              );
                            }
                          }
                        },
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
