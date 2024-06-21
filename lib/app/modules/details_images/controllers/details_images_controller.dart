import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsImagesController extends GetxController {

  DetailsImagesController();

  ScrollController scrollController = ScrollController();
  CarouselController carouselController = CarouselController();

  jumpToSelectedImagePosition(int selectedImage){

    scrollController.jumpTo(
      selectedImage * (320 + 8),
    );
    update();
  }
}

