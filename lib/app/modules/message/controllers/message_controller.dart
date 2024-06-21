import 'dart:async';
import 'dart:convert';
import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/utils/app_icons.dart';
import 'package:ilu/app/data/message/message_repo.dart';
import 'package:ilu/app/models/call_history/call_history_model.dart' as chm;
import 'package:ilu/app/models/details_profile/make_block_user_response_model.dart';
import 'package:ilu/app/models/profile/profile_response_model.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:intl/intl.dart';

import '../../../core/global/api_url_container.dart';
import '../../../core/helper/local_storage_helper.dart';
import '../../../core/utils/agora_settings.dart';
import '../../../core/utils/app_utils.dart';
import '../../../models/chat/chat_user.dart';
import '../../../models/chat/message_model.dart';
import '../../../models/details_profile/agora_token_response.dart';
import '../../../models/details_profile/details_profile_response_model.dart';

class MessageController extends GetxController {
  MessageRepo repo;
  MessageController({required this.repo});

  TextEditingController searchTextField = TextEditingController();

  List<Map<String, String>> inactiveTablist = [
    {"icon": AppIcons.messageInactive, "title": "Message"},
    {"icon": AppIcons.verifyContactField, "title": "Call History"},
  ];

  List<Map<String, String>> activeTablist = [
    {"icon": AppIcons.messageActive, "title": "Message"},
    {"icon": AppIcons.activePhoneCall, "title": "Call History"},
  ];

  int selectedTab = 0; // this variable represents default selected tab
  final PageController pageController = PageController();

  // ------------------------------------ this method is used to change tab
  changeTab(int index) {
    selectedTab = index;
    pageController.jumpToPage(index);
    update();
  }

  /// ------------------------------------- this method is used to change pages
  void changePage(int pageIndex) {
    selectedTab = pageIndex;
    update();
  }

  bool isLoading = false;

  /// ---------------------- this method is used to get current user data
  ProfileResponseModel currentUserInfo = ProfileResponseModel();
  int currentUserId = 0;
  int rechargeBalance = 0;

  Future<void> getCurrentUserData() async {
    searchTextField.text = "";
    isLoading = true;
    update();

    ApiResponseModel responseModel = await repo.getUserProfile();

    if (responseModel.statusCode == 200) {
      currentUserInfo = ProfileResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      currentUserId = currentUserInfo.id ?? 0;
      rechargeBalance = currentUserInfo.iluPoints ?? 0;
       getCurrentUserChatList();
       loadCallHistory();
      getCurrentUserChatList();

      update();
    } else if (responseModel.statusCode == 401 ||
        responseModel.statusCode == 403) {
      Get.offAllNamed(Routes.LOGIN);
    }

    isLoading = false;
    update();
  }

  /// ------------------------- this message is used to show the chat list of current logged in user
  List<ChatUser> chatList = [];
  final chatUserImages = [];

  Stream<QuerySnapshot<Map<String, dynamic>>> getMyUsersId() {
    return FirebaseFirestore.instance
        .collection('chat_users')
        .doc(currentUserId.toString())
        .collection('my_users')
        .snapshots();
  }

  getCurrentUserChatList() async {
    print("---------------------- enter ---------------");
    FirebaseFirestore.instance
        .collection('chat_users')
        .doc(currentUserId.toString())
        .collection('my_users')
        .orderBy('created_at', descending: true)
        .snapshots()
        .listen((event) {
      chatList.clear();
      chatList = event.docs.map((e) => ChatUser.fromJson(e.data())).toList();
      update();
    });

    print("--------------- length: ${chatList.length}");
  }

  /// ------------------------ this method is used to search chat user
  List<ChatUser> searchList = [];
  bool isSearch = false;

  void searchCheck() {
    isSearch = !isSearch;
    update();
  }

  void searchData() {
    isSearch = true;
    searchList.clear();
    update();

    for (var i in chatList) {
      if (i.name
          .toLowerCase()
          .contains(searchTextField.text.trim().toLowerCase())) {
        searchList.add(i);
        update();
      }
    }

  }

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

    print('channelName ${getConversationID(receiverUserInfo.id!)}');
    ApiResponseModel responseModel = await repo.callAgoraTokenAPI(
        channelName: getConversationID(receiverUserInfo.id!));

    if (responseModel.statusCode == 200) {
      var model =
          AgoraTokenResponse.fromJson(jsonDecode(responseModel.responseJson));

      AgoraConfig.agoraToken = model.token ?? '';
      AgoraConfig.agoraAudioChannelName =
          getConversationID(receiverUserInfo.id!);

      ///create call log

      print("Agora TOKEN : ${model.token}");
      print("Agora CHANNEL : $getConversationID(receiverUserInfo.id!)");
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

      update();

      Get.toNamed(Routes.AUDIO_CALL, arguments: [
        getConversationID(receiverUserInfo.id!),
        userProfileImage,
      ]);
    } else if (responseModel.statusCode == 401 &&
        responseModel.statusCode == 403) {
      Get.offAllNamed(Routes.LOGIN);
    } else {
      AppUtils.errorToastMessage("Server is not responding!");

      print('not getting success');
    }

    update();
  }

  /// ---------------------- this method is used to get call id
  String getConversationID(int id) {
    if (currentUserId.hashCode <= id.hashCode) {
      print("-------------- conversationId: ${currentUserId}_$id");
      return "${currentUserId}_$id";
    } else {
      print("-------------- conversation id: ${id}_$currentUserId");
      return "${id}_$currentUserId";
    }
  }

  DetailsProfileResponseModel receiverUserInfo = DetailsProfileResponseModel();
  List<ProfileImage> profileImages = [];

  String username = "";
  String userId = "";
  String userAge = "";
  String userProfileImage = "";
  String receiverId = "";

  Future<void> userDetailsData({required int id}) async {
    print("-------------- user details id: $id");
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
      await repo.apiService.sharedPreferences.setInt(
          LocalStorageHelper.detailsProfileUserIdKey, receiverUserInfo.id ?? 0);

      List<ProfileImage>? tempList = receiverUserInfo.profileImage;
      if (tempList != null && tempList.isNotEmpty) {
        profileImages.addAll(tempList);
      }

      if (profileImages.isEmpty) {
        userProfileImage = "";
      } else {
        userProfileImage = "${ApiUrlContainer.baseUrl}${profileImages[0].file}";
      }
    } else if (responseModel.statusCode == 401 &&
        responseModel.statusCode == 403) {
      Get.offAllNamed(Routes.LOGIN);
    } else {}

    isLoading = false;
    update();
  }

  // --------------------- make block user -----------------------------------
  Future<void> makeUserBlock(int userId) async {
    ApiResponseModel responseModel = await repo.makeUserBlock(id: userId);

    if (responseModel.statusCode == 200) {
      MakeBlockUserResponseModel model = MakeBlockUserResponseModel.fromJson(jsonDecode(responseModel.responseJson));

      FirebaseFirestore.instance.collection('chat_users')
          .doc(currentUserId.toString())
          .collection('my_users').doc(userId.toString()).update({
        "is_blocked": true
      });

      kIsWeb
          ? AppUtils.successSnackBarForWeb(model.message.toString())
          : AppUtils.successToastMessage(model.message.toString());
      Get.offAllNamed(Routes.MESSAGE);
    } else if (responseModel.statusCode == 401 ||
        responseModel.statusCode == 403) {
      Get.offAllNamed(Routes.LOGIN);
    } else {
      kIsWeb
          ? AppUtils.successSnackBarForWeb("Something went wrong, Try again")
          : AppUtils.successToastMessage("Something went wrong, Try again");
    }
    update();
  }

  /// -------------- this method is used to get call history
  chm.CallHistoryModel callHistoryModel = chm.CallHistoryModel();
  List<chm.Results> callHistoryList = [];
  bool isCallHistoryLoading = false;

  /// ---------------------- this method is used to initial state of the screen
  int page = 0;
  String nextPageUrl = "";
  int totalPage = 0;

  Future<void> loadPaginationData() async{
    await loadCallHistory();
  }

  Future<void> loadCallHistory() async{
    // isCallHistoryLoading = true;
    // update();

    page = page + 1;

    if(page == 0){
      callHistoryList.clear();
    }

    ApiResponseModel responseModel = await repo.getCallHistory(page: page);

    if(responseModel.statusCode == 200){
      callHistoryModel = chm.CallHistoryModel.fromJson(jsonDecode(responseModel.responseJson));
      nextPageUrl = callHistoryModel.next ?? "";
      totalPage = callHistoryModel.totalPage ?? 0;
      List<chm.Results>? tempList = callHistoryModel.results;
      if(tempList != null && tempList.isNotEmpty){
        callHistoryList.addAll(tempList);
        update();
      }
    }else if(responseModel.statusCode == 400){

    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){

    }else{

    }

    // isCallHistoryLoading = false;
    // update();
  }

  bool hasNext(){
    return nextPageUrl.isNotEmpty && nextPageUrl != null ? true : false;
  }

  String formattedDate(String value){
    String isoString = value;
    DateTime dateTimeUtc = DateTime.parse(isoString);
    //DateTime dateTimeLocal = dateTimeUtc.toLocal();
    String formattedDate = DateFormat('hh:mm a').format(dateTimeUtc);
    return formattedDate;
  }
}
