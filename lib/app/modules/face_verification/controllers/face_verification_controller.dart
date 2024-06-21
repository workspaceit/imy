import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/global/failed_response_model.dart';
import 'package:ilu/app/core/global/success_response_model.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/core/utils/app_utils.dart';
import 'package:ilu/app/data/face_verification/face_verification_repo.dart';
import 'package:ilu/app/models/face_verification/face_verification_model.dart';
import 'package:ilu/app/routes/app_pages.dart';

class FaceVerificationController extends GetxController {

  FaceVerificationRepo repo;
  FaceVerificationController({required this.repo});

  CameraController? cameraController;
  List<CameraDescription> cameras = [];
  XFile? file;

  // --------------------- initialize camera -------------------------------
  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras[1], ResolutionPreset.medium);
    await cameraController!.initialize();
    update();
  }

  // --------------------- take photo and upload -----------------------------
  takePhotoAndUpload() async{
    try{
      file = await cameraController!.takePicture();
      if(file != null){
        final imageFile = file!.path;
        await uploadImage(imageFile);
      }
    } catch(e){
      AppUtils.errorToastMessage(e.toString());
    }
  }

  bool isSubmit = false;
  uploadImage(String imageFile) async{
    isSubmit = true;
    update();

    if(repo.apiService.sharedPreferences.getString(LocalStorageHelper.userTypeKey) == "Bangladesh"){
      String phoneNumber = repo.apiService.sharedPreferences.getString(LocalStorageHelper.phoneNumberKey) ?? "";

      ApiResponseModel responseModel = await repo.uploadVerificationImageForLocal(imageFile: imageFile, phoneNumber: phoneNumber);

      if(responseModel.statusCode == 200){
        FaceVerificationModel faceVerificationModel = FaceVerificationModel.fromJson(jsonDecode(responseModel.responseJson));
        AppUtils.successToastMessage(faceVerificationModel.message ?? "Image Uploaded Successfully");
        await sendPhoneVerificationCode(phoneNumber);
        Get.offAndToNamed(Routes.REGISTRATION_OTP);
      }else if(responseModel.statusCode == 400){
        FailedResponseModel model = FailedResponseModel.fromJson(jsonDecode(responseModel.responseJson));
        AppUtils.errorToastMessage(model.message ?? "");
        await initializeCamera();
      } else{
        AppUtils.errorToastMessage("Verification Image Upload Failed");
        await initializeCamera();
      }
    }else{
      String email = repo.apiService.sharedPreferences.getString(LocalStorageHelper.emailKey) ?? "";

      ApiResponseModel responseModel = await repo.uploadVerificationImageForForeigner(imageFile: imageFile, email: email);

      if(responseModel.statusCode == 200){
        FaceVerificationModel faceVerificationModel = FaceVerificationModel.fromJson(jsonDecode(responseModel.responseJson));
        AppUtils.successToastMessage(faceVerificationModel.message ?? "Image Uploaded Successfully");
        await sendEmailVerificationCode(email);
        Get.offAndToNamed(Routes.REGISTRATION_OTP);
      }else if(responseModel.statusCode == 400){
        FailedResponseModel model = FailedResponseModel.fromJson(jsonDecode(responseModel.responseJson));
        AppUtils.errorToastMessage(model.message ?? "");
        await initializeCamera();
      } else{
        AppUtils.errorToastMessage("Verification Image Upload Failed");
        await initializeCamera();
      }
    }

    isSubmit = false;
    update();
  }

  sendPhoneVerificationCode(String phoneNumber) async{
    ApiResponseModel responseModel = await repo.sendPhoneVerificationCode(phone: phoneNumber);

    if(responseModel.statusCode == 200){
      SuccessResponseModel model = SuccessResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      AppUtils.successToastMessage(model.message ?? "");
    }else{

    }

    update();
  }

  sendEmailVerificationCode(String email) async{
    ApiResponseModel responseModel = await repo.sendEmailVerificationCode(email: email);

    if(responseModel.statusCode == 200){
      SuccessResponseModel model = SuccessResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      AppUtils.successToastMessage(model.message ?? "");
    }else{

    }

    update();
  }
}
