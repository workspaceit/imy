import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/modules/details_images/controllers/details_images_controller.dart';

class DetailsImagesMobileView extends StatefulWidget {

  final String imageSrc;

  const DetailsImagesMobileView({required this.imageSrc, super.key});

  @override
  State<DetailsImagesMobileView> createState() => _DetailsImagesMobileViewState();
}

class _DetailsImagesMobileViewState extends State<DetailsImagesMobileView> {
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: false,
      child: GetBuilder<DetailsImagesController>(
          builder: (controller) => Scaffold(
            backgroundColor: AppColors.colorDarkB,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // todo -> top section
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 24, top: 40, end: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
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

                // todo -> images
                Center(
                  child: CachedNetworkImage(
                    imageUrl: widget.imageSrc,
                    imageBuilder:(context, imageProvider) => Container(
                      height: 420, width: 320,
                      margin: const EdgeInsetsDirectional.symmetric(vertical: 100, horizontal: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.contain,
                          )
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
