import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/details_images/controllers/details_images_controller.dart';
import 'package:ilu/app/modules/details_images/views/mobile/details_images_mobile_view.dart';
import 'package:ilu/app/modules/details_images/views/web/details_images_web_view.dart';

class DetailsImagesView extends StatefulWidget {
  const DetailsImagesView({super.key});

  @override
  State<DetailsImagesView> createState() => _DetailsImagesViewState();
}

class _DetailsImagesViewState extends State<DetailsImagesView> {

  String imageSrc = "";

  @override
  void initState() {
    imageSrc = Get.arguments;
    final controller = Get.find<DetailsImagesController>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //controller.carouselController.jumpToPage(selectedImage);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      mobileUI: DetailsImagesMobileView(imageSrc: imageSrc),
      desktopUI: DetailsImagesWebView(imageSrc: imageSrc),
    );
  }
}
