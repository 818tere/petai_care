import 'dart:io';

import 'package:get/get.dart';
import 'package:petai_care/screens/diary/image_crop_controller.dart';
import 'package:petai_care/screens/diary/user_model.dart';

enum ProfileImageType { THUMBNAIL, BACKGROUND }

class ProfileController extends GetxController {
  RxBool isEditMyProfile = false.obs;
  UserModel originMyProfile = UserModel(
    name: "펫 이름",
    discription: "펫 정보",
  );
  Rx<UserModel> myProfile = UserModel().obs;

  @override
  void onInit() {
    isEditMyProfile(false);
    myProfile(UserModel.clone(originMyProfile));
    super.onInit();
  }

  void toggleEditProfile() {
    isEditMyProfile(!isEditMyProfile.value);
  }

  void rollback() {
    myProfile.value.initImageFile();
    myProfile(originMyProfile);
    toggleEditProfile();
  }

  void updateName(String updateName) {
    myProfile.update((my) {
      my?.name = updateName;
    });
  }

  void updateDiscription(String updateDiscription) {
    myProfile.update((my) {
      my?.discription = updateDiscription;
    });
  }

  void pickImage(ProfileImageType type) async {
    if (!isEditMyProfile.value) return;
    File? file = await ImageCropController.to.selectImage();
    if (file == null) return;
    switch (type) {
      case ProfileImageType.THUMBNAIL:
        myProfile.update((my) => my?.avatarFile = file);
        break;
      case ProfileImageType.BACKGROUND:
        myProfile.update((my) => my?.backgroundFile = file);
        break;
    }
  }

  void save(){
    originMyProfile = myProfile.value;
    toggleEditProfile();
  }
}
