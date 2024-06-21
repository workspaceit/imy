import 'dart:async';
import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/global/failed_response_model.dart';
import 'package:ilu/app/core/global/success_response_model.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/core/utils/agora_settings.dart';
import 'package:ilu/app/core/utils/app_utils.dart';
import 'package:ilu/app/data/details_profile/details_profile_repo.dart';
import 'package:ilu/app/models/details_profile/details_profile_report_response_model.dart';
import 'package:ilu/app/models/details_profile/details_profile_response_model.dart';
import 'package:ilu/app/models/details_profile/make_block_user_response_model.dart';
import 'package:ilu/app/models/details_profile/make_favorite_user_response_model.dart';
import 'package:ilu/app/models/post/timeline_response_model.dart';
import 'package:intl/intl.dart';

import '../../../data/chat/chat_repo.dart';
import '../../../models/chat/chat_user.dart';
import '../../../models/chat/message_model.dart';
import '../../../models/details_profile/agora_token_response.dart';
import '../../../models/profile/profile_response_model.dart';
import '../../../routes/app_pages.dart';

class DetailsProfileController extends GetxController {
  DetailsProfileRepo repo;
  DetailsProfileController({required this.repo});

  // ------------------------ get user profile details ----------------------------
  CarouselController carouselController = CarouselController();
  DetailsProfileResponseModel receiverUserInfo = DetailsProfileResponseModel();
  bool isLoading = false;
  List<ProfileImage> profileImages = [];

  String username = "";
  String userId = "";
  String userAge = "";
  String userProfileImage = "";
  String receiverId = "";
  ProfileResponseModel currentUserInfo = ProfileResponseModel();
  int currentUserId = 0;

  Future<void> userDetailsData({required int id}) async {
    isLoading = true;
    update();

    profileImages.clear();

    ApiResponseModel responseModel = await repo.getUserDetails(id: id);

    if (responseModel.statusCode == 200) {
      receiverUserInfo = DetailsProfileResponseModel.fromJson(
          jsonDecode(responseModel.responseJson));
      username =
          "${receiverUserInfo.firstName ?? ""} ${receiverUserInfo.lastName ?? ""}";
      userId = receiverUserInfo.uniqueId ?? "";
      userAge = "${receiverUserInfo.age ?? 0}";
      receiverId = receiverUserInfo.uniqueId ?? "";

      await repo.apiService.sharedPreferences
          .setString(LocalStorageHelper.detailsProfileUsernameKey, username);
      await repo.apiService.sharedPreferences.setString(
          LocalStorageHelper.detailsProfileUserUniqueIdKey, receiverId);
      await repo.apiService.sharedPreferences.setInt(LocalStorageHelper.detailsProfileUserIdKey, receiverUserInfo.id ?? 0);

      List<ProfileImage>? tempList = receiverUserInfo.profileImage;
      if (tempList != null && tempList.isNotEmpty) {
        profileImages.addAll(tempList);
      }

      if (profileImages.isEmpty) {
        userProfileImage = "";
      } else {
        userProfileImage = "${ApiUrlContainer.baseUrl}${profileImages[0].file}";

        for (int i = 0; i < profileImages.length; i++) {
          favoriteCheckingArray.add(profileImages[i].isFavorite == true ? 1 : 0);
          update();
        }
      }


      for (int i = 0; i < profileImages.length; i++) {
        favoriteCheckingArray.add(profileImages[i].isFavorite == true ? 1 : 0);
        update();
      }
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);

    } else {}

    await loadTimelineData(userId: id);
    isLoading = false;
    update();
  }

  int rechargeBalance = 0;

  Future<void> getCurrentUserData() async {
    isLoading = true;
    update();
    ChatRepo repo = ChatRepo(apiService: Get.find());
    ApiResponseModel responseModel = await repo.getUserProfile();

    if (responseModel.statusCode == 200) {
      currentUserInfo = ProfileResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      currentUserId = currentUserInfo.id ?? 0;
      rechargeBalance = currentUserInfo.iluPoints ?? 0;
      update();
    }

    isLoading = false;
    update();
  }

  /// ----------------------------- this method is used to
  Future<void> fetchAgoraToken() async {

    ///create firebase entry

    var isExists = (await FirebaseFirestore.instance
        .collection('call_users')
        .doc(currentUserId.toString())
        .get())
        .exists;
    if (isExists == true) {
      print('user already exists');
      final time = DateTime.now().millisecondsSinceEpoch.toString();

      final chatUser = ChatUser(
          id: currentUserInfo.id.toString(),
          name: '${currentUserInfo.firstName} ${currentUserInfo.lastName}',
          uniqueId: currentUserInfo.uniqueId.toString(),
          about: "Hey, I'm using IMY!",
          image: (currentUserInfo.profileImages?.isNotEmpty == true)
              ? '${ApiUrlContainer.baseUrl}${currentUserInfo.profileImages![0].thumbnail.toString()}'
              : '',
          createdAt: time,
          isOnline: false,
          isBlocked: false,
          lastActive: time,
          pushToken: '');

      ///update myself to call list call_users
      await FirebaseFirestore.instance
          .collection('call_users')
          .doc(currentUserInfo.id.toString())
          .update(chatUser.toJson());
    } else {
      final time = DateTime.now().millisecondsSinceEpoch.toString();

      final chatUser = ChatUser(
          id: currentUserInfo.id.toString(),
          name: '${currentUserInfo.firstName} ${currentUserInfo.lastName}',
          uniqueId: currentUserInfo.uniqueId.toString(),
          about: "Hey, I'm using IMY!",
          image: (currentUserInfo.profileImages?.isNotEmpty == true)
              ? '${ApiUrlContainer.baseUrl}${currentUserInfo.profileImages![0].thumbnail.toString()}'
              : '',
          createdAt: time,
          isOnline: false,
          isBlocked: false,
          lastActive: time,
          pushToken: '');

      ///add myself to call list of call_users
      await FirebaseFirestore.instance
          .collection('call_users')
          .doc(currentUserInfo.id.toString())
          .set(chatUser.toJson());
    }

    ///------------add receiver to the call_users list

    var isReceiverExists = (await FirebaseFirestore.instance
        .collection('call_users')
        .doc(receiverUserInfo.id.toString())
        .get())
        .exists;
    if (isReceiverExists == true) {
      print('user already exists');
      final time = DateTime.now().millisecondsSinceEpoch.toString();

      final chatUser = ChatUser(
          id: receiverUserInfo.id.toString(),
          name: '${receiverUserInfo.firstName} ${receiverUserInfo.lastName}',
          uniqueId: receiverUserInfo.uniqueId.toString(),
          about: "Hey, I'm using IMY!",
          image: (receiverUserInfo.profileImage?.isNotEmpty == true)
              ? '${ApiUrlContainer.baseUrl}${receiverUserInfo.profileImage![0].thumbnail.toString()}'
              : '',
          createdAt: time,
          isOnline: false,
          isBlocked: false,
          lastActive: time,
          pushToken: '');

      ///add second user to chat list chat_users
      await FirebaseFirestore.instance
          .collection('call_users')
          .doc(receiverUserInfo.id.toString())
          .update(chatUser.toJson());
    } else {
      final time = DateTime.now().millisecondsSinceEpoch.toString();

      final chatUser = ChatUser(
          id: receiverUserInfo.id.toString(),
          name: '${receiverUserInfo.firstName} ${receiverUserInfo.lastName}',
          uniqueId: receiverUserInfo.uniqueId.toString(),
          about: "Hey, I'm using IMY!",
          image: (receiverUserInfo.profileImage?.isNotEmpty == true)
              ? '${ApiUrlContainer.baseUrl}${receiverUserInfo.profileImage![0].thumbnail.toString()}'
              : '',
          createdAt: time,
          isOnline: false,
          isBlocked: false,
          lastActive: time,
          pushToken: '');

      ///add second user to chat list call_users
      await FirebaseFirestore.instance
          .collection('call_users')
          .doc(receiverUserInfo.id.toString())
          .set(chatUser.toJson());
    }

    ApiResponseModel responseModel = await repo.callAgoraTokenAPI(channelName: getConversationID(receiverUserInfo.id!));

    if (responseModel.statusCode == 200) {
      AgoraTokenResponse model = AgoraTokenResponse.fromJson(jsonDecode(responseModel.responseJson));
      AgoraConfig.agoraToken = model.token ?? '';
      AgoraConfig.agoraAudioChannelName = getConversationID(receiverUserInfo.id!);
      update();
      ///create call log

      print("Agora TOKEN : ${model.token}");
      print("Agora CHANNEL : ${AgoraConfig.agoraAudioChannelName}");
      final time = DateTime.now().millisecondsSinceEpoch.toString();

      // ------------------------- message to send
      final CallModel message = CallModel(
          toId: receiverUserInfo.id!,
          msg: 'Calling',
          name: getConversationID(receiverUserInfo.id!),
          fromId: currentUserId,
          sent: time,
          token: model.token ?? '');

      var isExists = (await FirebaseFirestore.instance
          .collection('audio_call_room')
          .doc(getConversationID(receiverUserInfo.id!))
          .get())
          .exists;

      if (isExists == true) {
        FirebaseFirestore.instance
            .collection('audio_call_room')
            .doc(getConversationID(receiverUserInfo.id!))
            .update(message.toJson());
      } else {
        FirebaseFirestore.instance
            .collection('audio_call_room')
            .doc(getConversationID(receiverUserInfo.id!))
            .set(message.toJson());
      }

      ///------------end creating call log

      ///add user to callers and receivers my user list

      var chatUser = ChatUser(
          image: (receiverUserInfo.profileImage?.isNotEmpty == true)
              ? '${ApiUrlContainer.baseUrl}${receiverUserInfo.profileImage![0].thumbnail.toString()}'
              : '',
          about: '',
          name: '${receiverUserInfo.firstName} ${receiverUserInfo.lastName}',
          createdAt: time,
          isOnline: true,
          isBlocked: false,
          id: receiverUserInfo.id.toString(),
          lastActive: time,
          uniqueId: receiverUserInfo.uniqueId.toString(),
          pushToken: model.token ?? '');

      /// add other user to my my_users list
      FirebaseFirestore.instance
          .collection('call_users')
          .doc(currentUserId.toString())
          .collection('my_users')
          .doc(receiverUserInfo.id.toString())
          .set(chatUser.toJson());

      var meUser = ChatUser(
          image: (currentUserInfo.profileImages?.isNotEmpty == true)
              ? currentUserInfo.profileImages![0].thumbnail.toString()
              : '',
          about: '',
          name: '${currentUserInfo.firstName} ${currentUserInfo.lastName}',
          createdAt: time,
          isOnline: true,
          isBlocked: false,
          id: currentUserInfo.id.toString(),
          lastActive: time,
          uniqueId: currentUserInfo.uniqueId.toString(),
          pushToken: '');

      /// add myself to other users my_users list
      FirebaseFirestore.instance
          .collection('call_users')
          .doc(receiverUserInfo.id.toString())
          .collection('my_users')
          .doc(currentUserId.toString())
          .set(meUser.toJson());
      ///------------end user to callers and receivers my user list
      Get.toNamed(
        Routes.AUDIO_CALL,
        arguments: [
          getConversationID(receiverUserInfo.id!),
          userProfileImage,
        ]
      );
    } else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }else {
      AppUtils.errorToastMessage("Server is not responding!");
    }
    update();
  }

  /// ---------------------- this method is used to get call id
  String getConversationID(int id) {
    if (currentUserId.hashCode <= id.hashCode) {
      return "${currentUserId}_$id";
    } else {
      return "${id}_$currentUserId";
    }
  }

  int currentIndex = 0;
  void changePage(int val) {
    currentIndex = val;
    update();

    carouselController.jumpToPage(currentIndex);
    update();
  }

  // ---------------------- make favorite profile image ---------------------
  List<int> favoriteCheckingArray = [];

  Future<void> makeFavoriteProfileImage(int index,
      {required int profileImageId}) async {
    ApiResponseModel responseModel =
        await repo.makeFavoriteProfileImage(profileImageId: profileImageId);

    if (responseModel.statusCode == 200) {
      SuccessResponseModel model = SuccessResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      favoriteCheckingArray[index] = 1;
    } else if (responseModel.statusCode == 400) {
      FailedResponseModel model = FailedResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      AppUtils.errorToastMessage(model.message ?? "Image not found");
    } else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }else {
      AppUtils.errorToastMessage("Something went wrong. Try again");
    }

    update();
  }

  // --------------------- remove favorite profile image -------------------------
  Future<void> removeFavoriteProfileImage(int index, {required int profileImageId}) async {
    ApiResponseModel responseModel = await repo.removeFavoriteProfileImage(profileImageId: profileImageId);

    if (responseModel.statusCode == 200) {
      SuccessResponseModel model = SuccessResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      favoriteCheckingArray[index] = 0;
    } else if (responseModel.statusCode == 400) {
      FailedResponseModel model =
          FailedResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      AppUtils.errorToastMessage(model.message ?? "Image not found");
    } else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }else {
      AppUtils.errorToastMessage("Something went wrong. Try again");
    }

    update();
  }

  // --------------------- report user -----------------------------------
  bool isSubmitReport = false;
  TextEditingController reportController = TextEditingController();

  Future<void> reportUser(int userId) async {
    isSubmitReport = true;
    update();

    ApiResponseModel responseModel =
        await repo.reportUser(id: userId, report: reportController.text.trim());

    if (responseModel.statusCode == 200) {
      DetailsProfileReportResponseModel reportModel =
          DetailsProfileReportResponseModel.fromJson(
              jsonDecode(responseModel.responseJson));
      Get.back();

      kIsWeb ? AppUtils.successSnackBarForWeb(reportModel.message.toString()) : AppUtils.successToastMessage(reportModel.message.toString());
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);

    } else {}

    reportController.text = "";
    isSubmitReport = false;
    update();
  }

  // --------------------- make favorite user -----------------------------------
  Future<void> makeUserFavorite(int userId) async {
    update();

    ApiResponseModel responseModel = await repo.makeUserFavorite(id: userId);

    if (responseModel.statusCode == 200) {
      MakeFavoriteUserResponseModel model =
      MakeFavoriteUserResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      update();

      kIsWeb ? AppUtils.successSnackBarForWeb(model.message.toString()) : AppUtils.successToastMessage(model.message.toString());
    } else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }else {}
    update();
  }

  // --------------------- make block user -----------------------------------
  Future<void> makeUserBlock(int userId) async {
    ApiResponseModel responseModel = await repo.makeUserBlock(id: userId);

    if (responseModel.statusCode == 200) {
      MakeBlockUserResponseModel model = MakeBlockUserResponseModel.fromJson(
          jsonDecode(responseModel.responseJson));
      kIsWeb
          ? AppUtils.successSnackBarForWeb(model.message.toString())
          : AppUtils.successToastMessage(model.message.toString());
      Get.offAllNamed(Routes.HOME);
    } else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }else {}
    update();
  }

  // ----------------------- timeline -----------------------
  CarouselController carouselTimelineController = CarouselController();
  List<CarouselController> ccList = [];
  TimelineResponseModel timelineResponseModel = TimelineResponseModel();
  List<Results> timelineList = [];
  List<int> likePostList = [];
  Future<void> loadTimelineData({required int userId}) async {
    timelineList.clear();
    currentIndexList.clear();
    ccList.clear();
    ApiResponseModel responseModel = await repo.getAllPost(userId: userId);

    if (responseModel.statusCode == 200) {
      timelineResponseModel = TimelineResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Results>? tempList = timelineResponseModel.results;

      if (tempList != null && tempList.isNotEmpty) {
        timelineList.addAll(tempList);
      }

      for (int i = 0; i < timelineList.length; i++) {
        likePostList.add(timelineList[i].isLiked == true ? 1 : 0);
        ccList.add(CarouselController());
        currentIndexList.add(0);
      }
    } else {
      FailedResponseModel model =
          FailedResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (responseModel.statusCode == 400) {
        AppUtils.errorToastMessage(model.message ?? "Bad Request");
      } else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
        Get.offAllNamed(Routes.LOGIN);
      }else if (responseModel.statusCode == 404) {
        AppUtils.errorToastMessage(model.message ?? "No Data Found");
      } else {
        AppUtils.errorToastMessage("Something went wrong");
      }
    }
  }

  int timeLineImageIndex = 0;
  List<int> currentIndexList = [];
  void changeTimeLineImagePage(int val, int index) {
    timeLineImageIndex = val;
    update();

    // carouselTimelineController.jumpToPage(timeLineImageIndex);
    ccList[index].jumpToPage(val);
    currentIndexList[index] = val;
    update();
  }

  // ------------------------- this method is used for like post -------------------------
  Future<void> likePost(int index, {required int postId}) async {
    ApiResponseModel responseModel = await repo.likePost(postId: postId);

    if (responseModel.statusCode == 200) {
      SuccessResponseModel model = SuccessResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      likePostList[index] = 1;
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }else{

    }

    update();
  }

  Future<void> unlikePost(int index, {required int postId}) async {
    ApiResponseModel responseModel = await repo.unlikePost(postId: postId);

    if (responseModel.statusCode == 200) {
      SuccessResponseModel model = SuccessResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      likePostList[index] = 0;
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }else{

    }

    update();
  }

  String formattedDate(String value) {
    String isoString = value;
    DateTime dateTimeUtc = DateTime.parse(isoString);
    DateTime dateTimeLocal = dateTimeUtc.toLocal();
    String formattedDate = DateFormat('hh:mm a').format(dateTimeLocal);
    return formattedDate;
  }
}
