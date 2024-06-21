import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/home/controllers/home_controller.dart';
import 'package:ilu/app/modules/home/views/mobile/home_mobile_ui_view.dart';
import 'package:ilu/app/modules/home/views/web/home_web_ui_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final ScrollController scrollController = ScrollController();

  void scrollListener(){
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      if(Get.find<HomeController>().hasNext()){
        Get.find<HomeController>().loadPaginationData();
      }
    }
  }

  @override
  void initState() {
    final controller = Get.find<HomeController>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialState();
      controller.getDeviceInfo();
      scrollController.addListener(scrollListener);
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      mobileUI: HomeMobileUiView(scrollController: scrollController),
      desktopUI: HomeWebUiView(scrollController: scrollController)
    );
  }
}
