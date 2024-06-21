import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/modules/face_verification/controllers/face_verification_controller.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:ilu/app/widgets/buttons/custom_button.dart';
import 'package:ilu/app/widgets/buttons/custom_loading_button.dart';

class FaceVerificationMobileUiView extends StatelessWidget {
  const FaceVerificationMobileUiView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<FaceVerificationController>(builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.colorWhite,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.colorWhite,
            leading: IconButton(
                onPressed: () => Get.offAndToNamed(Routes.REGISTRATION),
                alignment: Alignment.center,
                icon: SvgPicture.asset(AppIcons.arrowBack),
                iconSize: 24),
            title: Text(
              "Registration",
              textAlign: TextAlign.center,
              style: AppTextStyle.appTextStyle(
                  textColor: AppColors.colorDarkA,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: controller.cameraController == null
              ? const SizedBox()
              : SingleChildScrollView(
                  padding: const EdgeInsetsDirectional.only(
                      start: 24, top: 20, end: 24, bottom: 20),
                  child: Column(
                    children: [
                      ClipOval(
                        child: CameraPreview(controller.cameraController!),
                      ),
                      const Gap(60),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "\u2022",
                                style: AppTextStyle.appTextStyle(
                                    textColor: AppColors.colorDarkB,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                              const Gap(4),
                              Expanded(
                                child: Text(
                                  "Your picture won't be shown anywhere.",
                                  style: AppTextStyle.appTextStyle(
                                      textColor: AppColors.colorDarkB,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                          const Gap(4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "\u2022",
                                style: AppTextStyle.appTextStyle(
                                    textColor: AppColors.colorDarkB,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                              const Gap(4),
                              Expanded(
                                child: Text(
                                  "Remove you eye-glass, hijab and other materials that may block you entire face.",
                                  style: AppTextStyle.appTextStyle(
                                      textColor: AppColors.colorDarkB,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                          const Gap(4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "\u2022",
                                style: AppTextStyle.appTextStyle(
                                    textColor: AppColors.colorDarkB,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                              const Gap(4),
                              Expanded(
                                child: Text(
                                  "Make sure that you have enough light wherever you are now.",
                                  style: AppTextStyle.appTextStyle(
                                      textColor: AppColors.colorDarkB,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Gap(20),
                      controller.isSubmit ? const CustomLoadingButton() : CustomButton(
                        onPressed: (){
                          controller.takePhotoAndUpload();
                        },
                        buttonText: "Proceed to Registration"
                      )
                    ],
                  ),
                ),
        );
      }),
    );
  }
}
