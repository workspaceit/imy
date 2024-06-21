import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/utils/agora_settings.dart';
import 'package:ilu/app/core/utils/app_utils.dart';
import 'package:ilu/app/data/chat/chat_repo.dart';
import 'package:ilu/app/models/chat/message_model.dart';
import 'package:ilu/app/models/details_profile/agora_token_response.dart';
import 'package:ilu/app/models/profile/profile_response_model.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

import '../../../models/chat/chat_user.dart';
import '../../../models/details_profile/details_profile_response_model.dart';

class ChatController extends GetxController {
  ChatRepo repo;
  ChatController({required this.repo});

  /// ------------------ declare variables
  bool isLoading = false;
  TextEditingController messageController = TextEditingController();
  bool sender = false;

  /// ---------------------- this method is used to get current user data
  ProfileResponseModel currentUserInfo = ProfileResponseModel();
  int currentUserId = 0;

  /// ---------------------- this method is used to get current user data
  int rechargeBalance = 0;
  Future<void> getCurrentUserData() async {
    isLoading = true;
    update();

    ApiResponseModel responseModel = await repo.getUserProfile();

    if (responseModel.statusCode == 200) {
      currentUserInfo = ProfileResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      currentUserId = currentUserInfo.id ?? 0;
      rechargeBalance = currentUserInfo.iluPoints ?? 0;
      update();
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }

    isLoading = false;
    update();

    var isExists = (await FirebaseFirestore.instance
        .collection('chat_users')
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

      ///add myself to chat list chat_users
      await FirebaseFirestore.instance
          .collection('chat_users')
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

      ///add myself to chat list chat_users
      await FirebaseFirestore.instance
          .collection('chat_users')
          .doc(currentUserInfo.id.toString())
          .set(chatUser.toJson());
    }
  }

  /// ------------------------- this method is used to get others user data
  DetailsProfileResponseModel receiverUserInfo = DetailsProfileResponseModel();
  String receiverName = "";
  String receiverAge = "";
  String receiverImage = "";
  int receiverId = 0;
  List<ProfileImage> receiverProfileImages = [];

  Future<void> userDetailsData({required int id}) async {
    isLoading = true;
    update();

    ApiResponseModel responseModel = await repo.getUserDetails(id: id);

    isLoading = false;
    update();

    if (responseModel.statusCode == 200) {

      receiverUserInfo = DetailsProfileResponseModel.fromJson(
          jsonDecode(responseModel.responseJson));
      receiverName =
      "${receiverUserInfo.firstName ?? ""} ${receiverUserInfo.lastName ?? ""}";
      receiverAge = "${receiverUserInfo.age ?? 0}";
      receiverId = receiverUserInfo.id ?? 0;
      update();

      List<ProfileImage>? tempList = receiverUserInfo.profileImage;
      if (tempList != null && tempList.isNotEmpty) {
        receiverProfileImages.addAll(tempList);
        update();
      }

      if (receiverProfileImages.isNotEmpty) {
        receiverImage =
        "${ApiUrlContainer.baseUrl}${receiverProfileImages[0].file}";
        update();
      }


      var isExists = (await FirebaseFirestore.instance
          .collection('chat_users')
          .doc(receiverId.toString())
          .get())
          .exists;
      if (isExists == true) {
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
            .collection('chat_users')
            .doc(receiverId.toString())
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

        ///add second user to chat list chat_users
        await FirebaseFirestore.instance
            .collection('chat_users')
            .doc(receiverId.toString())
            .set(chatUser.toJson());
      }
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }

    isLoading = false;
    update();
  }

  /// ---------------------- image picker section
  ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFiles = [];

  Future<void> pickImages() async {
    List<XFile>? images = await imagePicker.pickMultiImage(imageQuality: 80);
    if (images.isNotEmpty) {
      if(images.length > 4){
        AppUtils.errorToastMessage("You cannot upload more than 4 pictures");
        imageFiles.clear();
        update();
      }else{
        imageFiles.addAll(images);
        for (var i in imageFiles) {
          await sendChatImage(File(i.path));
        }

        imageFiles.clear();
        update();
      }
    }
  }

  /// ---------------------- web image picker section
  List<Uint8List?> selectedImages = [];

  Future<void> sendImageToWeb() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      selectedImages = result.files.map((file) => file.bytes).toList();

      if(selectedImages.length > 4){
        AppUtils.errorSnackBarForWeb("You cannot upload more than 4 pictures");
        selectedImages.clear();
        update();
      }else{
        for(var bytes in selectedImages){
          if(bytes != null) {
            await sendChatImageInWeb(bytes);
          }
        }

        selectedImages.clear();
        update();
      }
      update();
    }
  }

  Future<void> sendChatImageInWeb(Uint8List bytes) async {
    try {
      // Getting image file extension
      final ext = 'png'; // Assuming the image format is PNG, adjust as needed

      // Storage file reference with path
      final ref = FirebaseStorage.instance
          .ref()
          .child('images/${getConversationID(receiverId)}/${DateTime.now().millisecondsSinceEpoch}.$ext');

      // Uploading image
      await ref.putData(bytes, SettableMetadata(contentType: 'image/$ext'));

      // Updating image in Firestore database
      final imageUrl = await ref.getDownloadURL();
      await sendMessage(imageUrl, MessageType.image);
    } catch (e) {
      print('Error uploading image: $e');
      // Handle error as needed
    }
  }

  /// ---------------------- this method is used to get chat id
  String getConversationID(int id) {
    if (currentUserId.hashCode <= id.hashCode) {
      print("-------------- conversationId: ${currentUserId}_$id");
      return "${currentUserId}_$id";
    } else {
      print("-------------- conversation id: ${id}_$currentUserId");
      return "${id}_$currentUserId";
    }
  }

  /// ---------------------- this method is used to send message
  bool isSendMessage = false;
  sendMessage(String msg, MessageType type) async {
    isSendMessage = true;
    update();

    // ------------------------- message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    // ------------------------- message to send
    final MessageModel message = MessageModel(
        toId: receiverId,
        msg: msg,
        read: '',
        type: type,
        fromId: currentUserId,
        sent: time);

    final ref = FirebaseFirestore.instance
        .collection('chat')
        .doc(getConversationID(receiverId))
        .collection("messages");
    await ref.doc(time).set(message.toJson());

    // ---------- store data inside chat collection based on photo and message --------------------
    final MessageModel messageListModel = MessageModel(
        toId: receiverId,
        msg: type == MessageType.image ? "Photo" : msg,
        read: '',
        type: type,
        fromId: currentUserId,
        sent: time);

    FirebaseFirestore.instance
        .collection('chat')
        .doc(getConversationID(receiverId)).update(messageListModel.toJson());


    var chatUser = ChatUser(image: receiverImage, about: type == MessageType.image ? "Photo" : msg, name: receiverName, createdAt: time, isOnline: true, id: receiverId.toString(),
        lastActive: time, uniqueId: receiverUserInfo.uniqueId.toString(), pushToken: '', isBlocked: false);

    /// add other user to my my_users list
    FirebaseFirestore.instance
        .collection('chat_users')
        .doc(currentUserId.toString())
        .collection('my_users')
        .doc(receiverId.toString())
        .update(chatUser.toJson());



    var meUser = ChatUser(image: (currentUserInfo.profileImages?.isNotEmpty == true)
        ? "${ApiUrlContainer.baseUrl}${currentUserInfo.profileImages![0].thumbnail.toString()}"
        : '', about: type == MessageType.image ? "Photo" : msg, name: '${currentUserInfo.firstName} ${currentUserInfo.lastName}', createdAt: time, isOnline: true, id: currentUserInfo.id.toString(),
        lastActive: time, uniqueId: currentUserInfo.uniqueId.toString(), pushToken: '', isBlocked: false);


    /// add myself to other users my_users list
    FirebaseFirestore.instance
        .collection('chat_users')
        .doc(receiverId.toString())
        .collection('my_users')
        .doc(currentUserId.toString())
        .update(meUser.toJson());

    messageController.text = "";
    isSendMessage = false;
    update();
  }

///send first message
  sendFirstMessage(String msg, MessageType type) async {
    isSendMessage = true;
    update();

    // ------------------------- message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    // ------------------------- message to send
    final MessageModel message = MessageModel(
        toId: receiverId,
        msg: msg,
        read: '',
        type: type,
        fromId: currentUserId,
        sent: time);

    final ref = FirebaseFirestore.instance
        .collection('chat')
        .doc(getConversationID(receiverId))
        .collection("messages");
    await ref.doc(time).set(message.toJson());

    // ---------- store data inside chat collection based on photo and message --------------------
    final MessageModel messageListModel = MessageModel(
        toId: receiverId,
        msg: type == MessageType.image ? "Photo" : msg,
        read: '',
        type: type,
        fromId: currentUserId,
        sent: time);

    FirebaseFirestore.instance
        .collection('chat')
        .doc(getConversationID(receiverId)).set(messageListModel.toJson());



    var chatUser = ChatUser(image: receiverImage, about: type == MessageType.image ? "Photo" : msg, name: receiverName, createdAt: time, isOnline: true, id: receiverId.toString(),
        lastActive: time, uniqueId: receiverUserInfo.uniqueId.toString(), pushToken: '', isBlocked: false);

    /// add other user to my my_users list
    FirebaseFirestore.instance
        .collection('chat_users')
        .doc(currentUserId.toString())
        .collection('my_users')
        .doc(receiverId.toString())
        .set(chatUser.toJson());



    var meUser = ChatUser(image: (currentUserInfo.profileImages?.isNotEmpty == true)
        ? "${ApiUrlContainer.baseUrl}${currentUserInfo.profileImages![0].thumbnail.toString()}"
        : '', about: type == MessageType.image ? "Photo" : msg, name: '${currentUserInfo.firstName} ${currentUserInfo.lastName}', createdAt: time, isOnline: true, id: currentUserInfo.id.toString(),
        lastActive: time, uniqueId: currentUserInfo.uniqueId.toString(), pushToken: '', isBlocked: false);
    /// add myself to other users my_users list
    FirebaseFirestore.instance
        .collection('chat_users')
        .doc(receiverId.toString())
        .collection('my_users')
        .doc(currentUserId.toString())
        .set(meUser.toJson());



    messageController.text = "";
    isSendMessage = false;
    update();
  }

  /// ------------------------- this method is used to send image
  Future<void> sendChatImage(File file) async {
    // ------------------ getting image file extension
    final ext = file.path.split('.').last;

    // ------------------ storage file ref with path
    final ref = FirebaseStorage.instance.ref().child(
        'images/${getConversationID(receiverId)}/${DateTime.now().millisecondsSinceEpoch}.$ext');

    // ------------------ uploading image
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext'));

    // ------------------ updating image in fire store database
    final imageUrl = await ref.getDownloadURL();
    await sendMessage(imageUrl, MessageType.image);
  }

  /// ---------------------- this method is used to get all message
  bool isChatMessageLoading = false;
  List<MessageModel> messageList = [];

  List<MessageModel> getMessages() {
    messageList.clear();
    isChatMessageLoading = true;
    update();

    FirebaseFirestore.instance
        .collection('chat')
        .doc(getConversationID(receiverId))
        .collection("messages")
        .snapshots()
        .listen((messages) {
      messageList =
          messages.docs.map((e) => MessageModel.fromJson(e.data())).toList();
      update();
    });

    isChatMessageLoading = false;
    update();

    return messageList;
  }

  // ------------------------------------ update read status of message
  Future<void> updateMessageReadStatus({required int fromId, required String sent}) async {
    FirebaseFirestore.instance
        .collection('chat')
        .doc(getConversationID(fromId))
        .collection("messages")
        .doc(sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()}
    );
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
          isBlocked: true,
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
            receiverImage,
          ]
      );
    } else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }else {
      AppUtils.errorToastMessage("Server is not responding!");
    }
    update();
  }

}
