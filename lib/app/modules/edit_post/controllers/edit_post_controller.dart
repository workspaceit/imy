import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/global/api_url_container.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/core/utils/app_images.dart';
import 'package:ilu/app/core/utils/app_utils.dart';
import 'package:ilu/app/data/edit_post/edit_post_repo.dart';
import 'package:ilu/app/models/post/edit_post_response_model.dart';
import 'package:ilu/app/models/profile/profile_response_model.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:image_picker/image_picker.dart';

class EditPostController extends GetxController {
  EditPostRepo repo;
  EditPostController({required this.repo});

  bool isLoading = false;
  bool isUpdate = false;
  TextEditingController postController = TextEditingController();

  // todo ---------------------------- initial stage ---------------------------
  Future<void> initialState() async{
    profileImages.clear();
    fileList.clear();
    selectedImages.clear();
    webImages.clear();
    isLoading = true;
    update();

    await loadProfileData();
    await loadPostData();

    isLoading = false;
    update();
  }

  // todo ---------------------------- both ------------------------------------
  String username = "";
  String userProfileImage = "";
  List<ProfileImages> profileImages = [];
  // --------------------------------------- load profile data --------------------------------------
  Future<void> loadProfileData() async{
    ApiResponseModel responseModel = await repo.getProfileData();

    if(responseModel.statusCode == 200){
      ProfileResponseModel model = ProfileResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      username = "${model.firstName ?? ""} ${model.lastName ?? ""}";

      List<ProfileImages>? tempList = model.profileImages;
      if(tempList != null && tempList.isNotEmpty){
        profileImages.addAll(tempList);
      }

      if(profileImages.isNotEmpty){
        userProfileImage = "${ApiUrlContainer.baseUrl}${profileImages[0].file}";
      }else{
        userProfileImage = AppImages.iluImage;
      }
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }

    update();
  }

  // --------------------------------------- load post data -----------------------------------------
  List<Files> fileList = [];
  Future<void> loadPostData() async{
    ApiResponseModel responseModel = await repo.getAllPost();

    if(responseModel.statusCode == 200){
      EditPostResponseModel model = EditPostResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      postController.text = model.caption ?? "";
      List<Files>? tempList = model.files;
      if(tempList != null && tempList.isNotEmpty){
        fileList.addAll(tempList);
      }
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }

    update();
  }

  // todo ---------------------------- for mobile ------------------------------
  ImagePicker imagePicker = ImagePicker();
  List<File> imageFileList = [];
  pickImage() async {
    final pickImageFile = await imagePicker.pickMultiImage(
      imageQuality: 100,
    );

    List<XFile> xFilePick = pickImageFile;
    if(xFilePick.length > 5){
      AppUtils.errorToastMessage("You cannot upload more than 5 pictures");
    }else if((xFilePick.length + fileList.length) > 5){
      AppUtils.errorToastMessage("You cannot upload more than 5 pictures");
    }else if((xFilePick.length + fileList.length) < 5){
      if(xFilePick.isNotEmpty){
        for(int i = 0; i < xFilePick.length; i++){
          imageFileList.add(File(xFilePick[i].path));
        }
      }
    }else{
      if(xFilePick.isNotEmpty){
        for(int i = 0; i < xFilePick.length; i++){
          imageFileList.add(File(xFilePick[i].path));
        }
      }
    }
    update();
  }

  bool isSubmit = false;
  /// -------------------------- this method is used to update post in mobile
  updatePostInMobile() async{
    isSubmit = true;
    update();

    ApiResponseModel responseModel = await repo.updatePost(caption: postController.text.trim(), files: imageFileList);
    if(responseModel.statusCode == 200){
        kIsWeb ? AppUtils.successSnackBarForWeb("Post Updated Successfully") : AppUtils.successToastMessage("Post Updated Successfully");
        repo.apiService.sharedPreferences.remove(LocalStorageHelper.deletedPostImageIndexKey);
        Get.offAllNamed(Routes.MY_TIMELINE);
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }else{
      kIsWeb ? AppUtils.errorSnackBarForWeb("More then 5 files not allowed") : AppUtils.errorToastMessage("More then 5 files not allowed");
    }

    clearData();
    isSubmit = false;
    update();
  }


  // todo ---------------------------- for web ---------------------------------
  updatePostInWeb() async{
    isSubmit = true;
    update();

    ApiResponseModel responseModel = await repo.updateWebPost(
      caption: postController.text.trim(),
      files: webImages,
      postImageId: repo.apiService.sharedPreferences.getInt(LocalStorageHelper.deletedPostImageIndexKey)
    );
    if(responseModel.statusCode == 200){
      kIsWeb ? AppUtils.successSnackBarForWeb("Post Updated Successfully") : AppUtils.successToastMessage("Post Updated Successfully");
      repo.apiService.sharedPreferences.remove(LocalStorageHelper.deletedPostImageIndexKey);
      Get.offAllNamed(Routes.MY_TIMELINE);
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }else{
      kIsWeb ? AppUtils.errorSnackBarForWeb("More then 5 files not allowed") : AppUtils.errorToastMessage("More then 5 files not allowed");
    }

    clearData();
    isSubmit = false;
    update();
  }

  List<PlatformFile> webImages = [];
  List<Uint8List?> selectedImages = [];

  // --------------------- pick images from directory  -------------------------
  Future<void> pickMultipleImagesForWeb() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    webImagesMethod(result);
    if(webImages.length > 5){
      AppUtils.errorSnackBarForWeb("You cannot upload more than 5 pictures");
    }else if((webImages.length + fileList.length) > 5){
      AppUtils.errorSnackBarForWeb("You cannot upload more than 5 pictures");
    }else if((webImages.length + fileList.length) < 5){
      if (result != null) {
        selectedImages = result.files.map((e) {
          return e.bytes;
        }).toList();
      }
    }else{
      if (result != null) {
        selectedImages = result.files.map((e) {
          return e.bytes;
        }).toList();
      }
    }
    update();
  }

  // --------------------------- web images -----------------------------
  void webImagesMethod(FilePickerResult? result) {
    if(result != null){
      webImages = result.files.map((file) => file).toList();
      update();
    }
  }

  /// ---------------------------- this method is used to delete post image
  int selectedPostImageIndex = -1;
  deleteProfileImage(int index) async{
    selectedPostImageIndex = index;
    update();

    ApiResponseModel responseModel = await repo.deletePostImage(postImageId: fileList[selectedPostImageIndex].id!);
    if(responseModel.statusCode == 204){
      repo.apiService.sharedPreferences.setInt(LocalStorageHelper.deletedPostImageIndexKey, fileList[selectedPostImageIndex].id!);
      await initialState();
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }
  }


  clearData(){
    postController.text = "";
    imageFileList.clear();
    selectedImages.clear();
    webImages.clear();
    update();
  }
}
