import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/modules/details_images/controllers/details_images_controller.dart';

class DetailsImagesWebView extends StatefulWidget {

  final String imageSrc;

  const DetailsImagesWebView({required this.imageSrc, super.key});

  @override
  State<DetailsImagesWebView> createState() => _DetailsImagesWebViewState();
}

class _DetailsImagesWebViewState extends State<DetailsImagesWebView> {
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: false,
      child: GetBuilder<DetailsImagesController>(
          builder: (controller) => Scaffold(
            backgroundColor: AppColors.colorDarkB,
            /// ----------------------- body -------------------------------
            body: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 600,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 120, left: 40, right: 40),
                      child: SizedBox(
                        width: 600,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              /// ---------------------- back button ------------------------
                              InkWell(
                                hoverColor: AppColors.colorWhite,
                                borderRadius: BorderRadius.circular(100),
                                onTap: () => Get.back(),
                                child: Container(
                                  height: 40, width: 40,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      color: AppColors.colorWhite,
                                      shape: BoxShape.circle
                                  ),
                                  child: SvgPicture.asset(AppIcons.arrowBack),
                                ),
                              ),
                              /// ---------------------- image download button ---------------
                              // GestureDetector(
                              //   onTap: (){},
                              //   child: Container(
                              //     height: 40, width: 40,
                              //     alignment: Alignment.center,
                              //     decoration: const BoxDecoration(
                              //         color: AppColors.colorWhite,
                              //         shape: BoxShape.circle
                              //     ),
                              //     child: SvgPicture.asset(AppIcons.download),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    /// ------------------- images ---------------------------------------
                    Flexible(
                      child: Center(
                        child: SizedBox(
                          width: 600,
                          child: CachedNetworkImage(
                            imageUrl: widget.imageSrc,
                            imageBuilder: (context, imageProvider) => Container(
                              height: 550, width: 600,
                              margin: const EdgeInsetsDirectional.symmetric(vertical: 100, horizontal: 40),
                              decoration: BoxDecoration(
                                  color: AppColors.colorRedB,
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.contain,
                      
                                  )
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}
