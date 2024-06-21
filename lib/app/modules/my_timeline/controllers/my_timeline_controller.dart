import 'dart:async';
import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/global/failed_response_model.dart';
import 'package:ilu/app/core/utils/app_images.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/core/utils/app_utils.dart';
import 'package:ilu/app/data/post/timeline_repo.dart';
import 'package:ilu/app/models/post/timeline_response_model.dart';
import 'package:ilu/app/models/profile/profile_response_model.dart';
import 'package:ilu/app/models/timeline/post_liked_user_response_model.dart' as post_liked_users;
import 'package:ilu/app/routes/app_pages.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

import '../../../core/utils/app_colors.dart';

class MyTimelineController extends GetxController {
  TimelineRepo repo;
  MyTimelineController({required this.repo});

  CarouselController carouselController = CarouselController();
  List<CarouselController> ccList = [];
  bool isLoading = false;
  TimelineResponseModel model = TimelineResponseModel();

  List<Results> timelineList = [];

  initialState() async{
    profileImages.clear();
    timelineList.clear();
    postLikedUsersList.clear();
    isLoading = true;
    update();

    await getUserData();
    await loadTimelineData();

    isLoading = false;
    update();
  }

  // ------------------------------ this method is used for get user data -------------------------------
  List<ProfileImages> profileImages = [];
  String username = "";
  String userProfileImage = "";

  Future<void> getUserData() async{
    profileImages.clear();
    ApiResponseModel responseModel = await repo.getUserProfile();

    if(responseModel.statusCode == 200){
      ProfileResponseModel profileResponseModel = ProfileResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      username = "${profileResponseModel.firstName} ${profileResponseModel.lastName}";

      List<ProfileImages>? tempList = profileResponseModel.profileImages;
      if(tempList != null && tempList.isNotEmpty){
        profileImages.addAll(tempList);
      }

      if(profileImages.isNotEmpty){
        userProfileImage = "${ApiUrlContainer.baseUrl}${profileImages[0].file}";
      }

      update();
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  // --------------------- this method is used to get all post data ------------------------------
  Future<void> loadTimelineData() async{
    timelineList.clear();
    currentIndexList.clear();
    ccList.clear();

    ApiResponseModel responseModel = await repo.getAllPost();

    if(responseModel.statusCode == 200){
      model = TimelineResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Results>? tempList = model.results;

      if(tempList != null && tempList.isNotEmpty){
        timelineList.addAll(tempList);
      }

      for(int i = 0; i < timelineList.length; i++){
        ccList.add(CarouselController());
        currentIndexList.add(0);
      }

    }else{
      FailedResponseModel model = FailedResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if(responseModel.statusCode == 400){
        kIsWeb ? AppUtils.errorSnackBarForWeb(model.message ?? "") : AppUtils.errorToastMessage(model.message ?? "");
      }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
        Get.offAllNamed(Routes.LOGIN);
      }else if(responseModel.statusCode == 404){
        kIsWeb ? AppUtils.errorSnackBarForWeb(model.message ?? "") : AppUtils.errorToastMessage(model.message ?? "");
      }else{
        kIsWeb ? AppUtils.errorSnackBarForWeb("Something went wrong. Try again") : AppUtils.errorToastMessage("Something went wrong. Try again");
      }
    }
  }

  // ----------------------- this method is used for deleting post -----------------------------
  bool isDeletePost = false;
  Future<void> postDelete({required int postId}) async{
    isDeletePost = true;
    update();

    ApiResponseModel responseModel = await repo.deletePost(postId: postId);

    if(responseModel.statusCode == 204){
      Get.back();
      await initialState();
      kIsWeb ? AppUtils.successSnackBarForWeb("Post deleted successfully") : AppUtils.successToastMessage("Post deleted successfully");
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }

    isDeletePost = false;
    update();
  }

  // ------------------------ this method is used to see people who liked on the post -------------------
  post_liked_users.PostLikedUserResponseModel postLikedUserResponseModel = post_liked_users.PostLikedUserResponseModel();
  List<post_liked_users.Results> postLikedUsersList = [];

  Future<void> loadPostLikedUsersData(int postLikedUsers, {required int postId}) async{
    postLikedUsersList.clear();
    update();

    ApiResponseModel responseModel = await repo.getPostLikedUsers(postId: postId);

    if(responseModel.statusCode == 200){
      postLikedUserResponseModel = post_liked_users.PostLikedUserResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      List<post_liked_users.Results>? tempList = postLikedUserResponseModel.results;
      if(tempList != null && tempList.isNotEmpty){
        postLikedUsersList.addAll(tempList);
      }

      postLikedUsersBottomSheet(Get.context!, postLikedUsers);
    }else if(responseModel.statusCode == 400){

    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }else{
      kIsWeb ? AppUtils.errorSnackBarForWeb("Something went wrong. Try again") : AppUtils.errorToastMessage("Something went wrong. Try again");
    }

    update();
  }

  // -------------------- change post view --------------------------------
  int timelineIndex = 0;
  List<int> currentIndexList = [];

  changeTimelinePage(int val, int index){
    timelineIndex = val;
    update();

    //carouselController.jumpToPage(timelineIndex);
    ccList[index].jumpToPage(val);
    currentIndexList[index] = val;
    update();
  }

  void postLikedUsersBottomSheet(BuildContext context, int postLikedUsers) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppColors.colorWhite,
        builder: (context) => Padding(
          padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 24),
          child: postLikedUsersList.isEmpty ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$postLikedUsers Peoples liked",
                    style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkB, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.clear, color: AppColors.colorDarkB, size: 20))
                ],
              ),
              const Gap(32),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "No data found",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.appTextStyle(
                      textColor: AppColors.colorDarkA,
                      fontWeight: FontWeight.w600,
                      fontSize: 16
                  ),
                ),
              ),
            ],
          ) : Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$postLikedUsers Peoples liked",
                    style: AppTextStyle.appTextStyle(textColor: AppColors.colorDarkB, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.clear, color: AppColors.colorDarkB, size: 20))
                ],
              ),
              const Gap(16),
              Column(
                  children: List.generate(postLikedUsersList.length, (i) => Container(
                    width: Get.width,
                    margin: const EdgeInsetsDirectional.only(bottom: 12),
                    padding: const EdgeInsetsDirectional.only(start: 4, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                        color: AppColors.colorWhite,
                        borderRadius: BorderRadius.circular(99),
                        border: Border.all(color: AppColors.colorGrayB)
                    ),
                    child: Row(
                      children: [
                        postLikedUsersList[i].profileImage?.file == null ? Container(
                          height: 40, width: 40,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage(AppImages.iluImage),
                                  fit: BoxFit.contain
                              )
                          ),
                        ) : Container(
                          height: 40, width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage("${ApiUrlContainer.baseUrl}/${postLikedUsersList[i].profileImage?.file}"),
                                  fit: BoxFit.contain
                              )
                          ),
                        ),
                        const Gap(8),
                        Text(
                          "${postLikedUsersList[i].firstName ?? ""} ${postLikedUsersList[i].lastName ?? ""}",
                          style: AppTextStyle.appTextStyle(
                              textColor: AppColors.colorDarkB,
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                          ),
                        )
                      ],
                    ),
                  ))
              ),
            ],
          ),
        )
    );
  }

  /// ------------------- this method is used to format date
  String formattedDate(String value){
    String isoString = value;
    DateTime dateTimeUtc = DateTime.parse(isoString);
    DateTime dateTimeLocal = dateTimeUtc.toLocal();
    String formattedDate = DateFormat('hh:mm a').format(dateTimeLocal);
    return formattedDate;
  }
}