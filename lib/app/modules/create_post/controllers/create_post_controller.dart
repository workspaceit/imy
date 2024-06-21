import 'dart:convert';
import 'dart:io';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/utils/app_utils.dart';
import 'package:ilu/app/data/post/create_post_repo.dart';
import 'package:ilu/app/models/post/create_post_response_model.dart';
import 'package:ilu/app/models/profile/profile_response_model.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class CreatePostController extends GetxController {

  CreatePostRepo repo;
  CreatePostController({required this.repo});

  bool isLoading = false;
  initialState() async{
    profileImages.clear();
    isLoading = true;
    update();

    await getUserData();

    isLoading = false;
    update();
  }

  ImagePicker imagePicker = ImagePicker();
  List<File> imageFileList = [];
  TextEditingController postController = TextEditingController();
  String fileExtension = "";
  List<VideoPlayerController>? videoControllers;

  // ------------------------ pick image from gallery for mobile --------------------------
  pickImage() async {
    try{
      final pickImageFile = await imagePicker.pickMultipleMedia(
        imageQuality: 100,
      );
      List<XFile> xFilePick = pickImageFile;

      if(xFilePick.length > 5){
        AppUtils.errorToastMessage("You cannot upload more than 5 pictures");
      }else{
        if(xFilePick.isNotEmpty){
          if (videoControllers != null) {
            for (var controller in videoControllers!) {
              controller.dispose();
            }
            update();
          }
          videoControllers = [];
          update();

          for(int i = 0; i < xFilePick.length; i++){
            imageFileList.add(File(xFilePick[i].path));
          }

          for(var file in imageFileList){
            fileExtension = extension(file.path);
            print("--------------- file extension: $fileExtension");
            update();
          }
          initializeVideoController();
          update();
        }
      }
      update();
    }catch(e){
      print(e.toString());
    }
  }

  void initializeVideoController(){
    videoControllers = imageFileList.map((video) {
      final videoController = VideoPlayerController.file(File(video.path))
        ..initialize().then((_) {
          update();
        }).catchError((error) {
          print("Error initializing video controller: $error");
        });
      return videoController;
    }).toList();
  }

  // --------------------- pick images from directory for web -------------------------
  List<PlatformFile> webImages = [];
  List<Uint8List?> selectedImages = [];

  Future<void> pickMultipleImagesForWeb() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    webImagesMethod(result);
    if(webImages.length > 5){
      AppUtils.errorSnackBarForWeb("You cannot upload more than 5 pictures");
    }else{
      if (result != null) {
        selectedImages = result.files.map((e) {
          return e.bytes;
        }).toList();
      }
    }
    update();
  }

  // todo -> this method is used to create post
  bool isSubmit = false;
  createPost() async{
    isSubmit = true;
    update();

    if(postController.text.trim().isEmpty && imageFileList.isEmpty){
      AppUtils.warningToastMessage("You can't create any blank post.");
    }else{
      ApiResponseModel responseModel = await repo.createPost(files: imageFileList, caption: postController.text.trim());

      if(responseModel.statusCode == 201){
        CreatePostResponseModel model = CreatePostResponseModel.fromJson(jsonDecode(responseModel.responseJson));
        kIsWeb ? AppUtils.successSnackBarForWeb(model.message ?? "Post Created Successfully") : AppUtils.successToastMessage(model.message ?? "Post Created Successfully");
        Get.offAllNamed(Routes.HOME);
      }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
        Get.offAllNamed(Routes.LOGIN);
      }else{
        kIsWeb ? AppUtils.errorSnackBarForWeb("Something went wrong") : AppUtils.errorToastMessage("Something went wrong");
      }
    }

    clearData();
    isSubmit = false;
    update();
  }

  // --------------------- web post -----------------
  createWebPost() async{
    isSubmit = true;
    update();

    if(postController.text.trim().isEmpty && webImages.isEmpty){
      AppUtils.warningSnackBarForWeb("You can't create any blank post");
    }else{
      ApiResponseModel responseModel = await repo.createWebPost(files: webImages, caption: postController.text.trim());

      if(responseModel.statusCode == 201){
        CreatePostResponseModel model = CreatePostResponseModel.fromJson(jsonDecode(responseModel.responseJson));
        kIsWeb ? AppUtils.successSnackBarForWeb(model.message ?? "Post Created Successfully") : AppUtils.successToastMessage(model.message ?? "Post Created Successfully");
        Get.offAllNamed(Routes.HOME);
      }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
        Get.offAllNamed(Routes.LOGIN);
      }else{
        kIsWeb ? AppUtils.errorSnackBarForWeb("Something went wrong") : AppUtils.errorToastMessage("Something went wrong");
      }
    }

    clearData();
    isSubmit = false;
    update();
  }

  bool showPostText = false;
  changeValue(String value) {
    postController.text = value;
    if(value.isNotEmpty){
      showPostText = true;
    }else{
      showPostText = false;
    }
    update();
  }

  clearData(){
    postController.text = "";
    showPostText = false;
    imageFileList.clear();
    selectedImages.clear();
    webImages.clear();
    videoControllers?.clear();
    update();
  }

  void webImagesMethod(FilePickerResult? result) {
    if(result != null){
      webImages = result.files.map((file) => file).toList();
      update();
    }
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
}
