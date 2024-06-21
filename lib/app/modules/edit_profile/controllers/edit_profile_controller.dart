import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/core/utils/app_utils.dart';
import 'package:ilu/app/data/profile/edit_profile_repo.dart';
import 'package:ilu/app/models/profile/profile_response_model.dart';
import 'package:ilu/app/models/upload_files/upload_files_response_model.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditProfileController extends GetxController{

  EditProfileRepo repo;
  EditProfileController({required this.repo});

  TextEditingController usernameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  TextEditingController districtController = TextEditingController();

  final editProfileFormKey = GlobalKey<FormState>();

  // ------------------------ initial stage of UI -----------------------------
  bool isLoading = false;
  initialStage() async{
    profileImages.clear();
    selectedPickImageIndex = -1;
    isLoading = true;
    update();
    await getUserData();
    isLoading = false;
    update();
  }

  // --------------------------- this method is used for updating user ---------------------------
  bool isSubmit = false;
  Future<void> updateUser() async{
    isSubmit = true;
    update();

    List<String> callerNameSplit = usernameController.text.trim().split(' ');
    String firstName = callerNameSplit.first;
    String lastName = callerNameSplit.length > 1 ? callerNameSplit.last : "";

    if(callerNameSplit.length > 2){
      firstName = callerNameSplit.sublist(0, callerNameSplit.length - 1).join(' ');
    }

    ApiResponseModel responseModel = await repo.updateProfile(
        firstName: firstName,
        lastName: lastName,
        dob: dobController.text.trim(),
    );

    if(responseModel.statusCode == 200){
      ProfileResponseModel model = ProfileResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      await repo.apiService.sharedPreferences.setString(LocalStorageHelper.userNameKey, "${model.firstName} ${model.lastName}");
      await repo.apiService.sharedPreferences.setString(LocalStorageHelper.userDobKey, model.dateOfBirth ?? "");
      kIsWeb ? AppUtils.successSnackBarForWeb("Profile Updated Successfully") : AppUtils.successToastMessage("Profile Updated Successfully");
    } else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }else{

    }

    isSubmit = false;
    update();
  }

  // ------------------------------ this method is used for get user data -------------------------------
  List<ProfileImages> profileImages = [];
  Future<void> getUserData() async{
    profileImages.clear();
    update();

    ApiResponseModel responseModel = await repo.getUserProfile();

    if(responseModel.statusCode == 200){
      ProfileResponseModel profileResponseModel = ProfileResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      dobController.text = profileResponseModel.dateOfBirth ?? "";
      usernameController.text = "${profileResponseModel.firstName} ${profileResponseModel.lastName}";
      genderController.text = "${profileResponseModel.gender.toString()[0].toUpperCase()}${profileResponseModel.gender.toString().substring(1)}";

      List<ProfileImages>? tempList = profileResponseModel.profileImages;
      if(tempList != null && tempList.isNotEmpty){
        profileImages.addAll(tempList);
      }

      await repo.apiService.sharedPreferences.setString(LocalStorageHelper.userDobKey, genderController.text.trim());
      await repo.apiService.sharedPreferences.setString(LocalStorageHelper.userNameKey, usernameController.text.trim());
      await repo.apiService.sharedPreferences.setString(LocalStorageHelper.userGenderKey, genderController.text.trim());
      update();
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  // --------------------------- pick images ---------------------------------
  ImagePicker imagePicker = ImagePicker();
  List<String> imageFileList = [];
  //int selectedIndex = -1;
  String imageFilePath = "";

  pickImage(int index) async {
    imageFileList.clear();

    final pickImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      imageFilePath = pickImage.path;
      imageFileList.add(imageFilePath);
    }
    update();
    await uploadImages(index);
  }

  // ------------------ this method is used to upload profile image files ---------------------
  uploadImages(int selectedIndex) async{
    if(imageFileList.isEmpty){
      selectedPickImageIndex = -1;
      update();
    }else{
      selectedPickImageIndex = selectedIndex;
      update();
    }

    ApiResponseModel responseModel = await repo.uploadFiles(imagePaths: imageFileList);
    if(responseModel.statusCode == 201){
      UploadFilesResponseModel model = UploadFilesResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Files>? tempList = model.results?.storage?.files;
      if(tempList != null && tempList.isNotEmpty){
        // fileList.addAll(tempList);
        AppUtils.successToastMessage("Profile Image Upload Successfully");
      }
      selectedPickImageIndex = -1;
      await getUserData();
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }
  }
  // --------------- web --------------------------
  List<Files> webFileList = [];
  webUploadImages(int index) async{
    if(webImagesList.isEmpty){
      selectedPickImageIndex = -1;
      update();
    }else{
      selectedPickImageIndex = index;
      update();
    }

    ApiResponseModel responseModel = await repo.webUploadFiles(imagePaths: webImagesList);
    if(responseModel.statusCode == 201){
      UploadFilesResponseModel model = UploadFilesResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Files>? tempList = model.results?.storage?.files;
      if(tempList != null && tempList.isNotEmpty){
        kIsWeb ? AppUtils.successSnackBarForWeb("Profile Image Upload Successfully") : AppUtils.successToastMessage("Profile Image Upload Successfully");
      }
      selectedPickImageIndex = -1;
      await getUserData();
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  // ------------------ pick dob ----------------------------------------
  void pickDobDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Colors.blue, // Change this to your desired color
          ),
        ),
        child: child!,
      ),
    );

    if (pickedDate != null) {
      // ------------------- calculate age -----------------------------
      DateTime currentDate = DateTime.now();
      int age = currentDate.year - pickedDate.year;
      if(currentDate.month < pickedDate.month || (currentDate.month == pickedDate.month && currentDate.day < pickedDate.day)){
        age--;
      }

      // -------------------- check if age is less than 18 ---------------
      if(age < 18){
        kIsWeb ? AppUtils.warningSnackBarForWeb("You must be 18 years or older to register") : AppUtils.warningToastMessage("You must be 18 years or older to register");
      }else{
        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        dobController.text = formattedDate;
      }
    }
  }

  // ------------------ pick image from pc ------------------------------
  List<Uint8List?> selectedImages = [];
  Uint8List? pcImageFilePath;
  picImageFromPc(int index) async{
    selectedImages.clear();
    webFileList.clear();
    webImagesList.clear();

    final pickImage = await FilePicker.platform.pickFiles(allowMultiple: false);
    webImagesMethod(pickImage);
    if(pickImage != null){
      pcImageFilePath = pickImage.files.first.bytes!;
      selectedImages.add(pcImageFilePath!);
    }
    await webUploadImages(index);
    update();
  }

  // ----------------------------------- for web -------------------------------
  List<PlatformFile> webImagesList = [];
  void webImagesMethod(FilePickerResult? result) {
    if(result != null){
      webImagesList = result.files.map((file) => file).toList();
      update();
    }
  }

  int selectDeletedImageIndex = -1;
  deleteProfileImage(int index) async{
    selectDeletedImageIndex = index;
    update();

    ApiResponseModel responseModel = await repo.deleteProfileImage(profileImageId: profileImages[selectDeletedImageIndex].id!);
    if(responseModel.statusCode == 204){
      selectedPickImageIndex = -1;
      getUserData();
    }else if(responseModel.statusCode == 401 || responseModel.statusCode == 403){
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  // ---------------------- this method is used to pick selected image
  int selectedPickImageIndex = -1;
}
