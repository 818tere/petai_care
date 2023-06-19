import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petai_care/screens/diary/profile_controller.dart';
import 'package:petai_care/screens/diary/text_editor_widget.dart';

class Profile extends GetView<ProfileController> {
  const Profile({super.key});

  Widget _header() {
    return Positioned(
      top: Get.mediaQuery.padding.top,
      left: 0,
      right: 0,
      child: Obx(
        () => Container(
          padding: const EdgeInsets.all(15),
          child: controller.isEditMyProfile.value
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: controller.rollback,
                      child: Row(
                        children: const [
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 16,
                          ),
                          Text(
                            "프로필 편집",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.save,
                      child: const Text(
                        "완료",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.close_sharp, color: Colors.white),
                    Row(
                      children: const [
                        Icon(Icons.qr_code, color: Colors.white),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.settings, color: Colors.white)
                      ],
                    )
                  ],
                ),
        ),
      ),
    );
  }

  Widget _backgroundImage() {
    return Positioned(
      top: 0,
      right: 0,
      bottom: 0,
      left: 0,
      child: GestureDetector(
        onTap: () {
          controller.pickImage(ProfileImageType.BACKGROUND);
        },
        child: Obx(
          () => Container(
            color: Colors.transparent,
            child: controller.myProfile.value.backgroundFile == null
                ? Container()
                : Image.file(
                    controller.myProfile.value.backgroundFile!,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
    );
  }

  Widget _oneButton(IconData icon, String title, Function()? ontap) {
    return GestureDetector(
      onTap: ontap,
      child: Column(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _footer() {
    return Obx(
      () => controller.isEditMyProfile.value
          ? Container()
          : Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 1,
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _oneButton(Icons.chat_bubble, "게시판 이용", () {}),
                    _oneButton(
                        Icons.edit, "프로필 편집", controller.toggleEditProfile),
                    _oneButton(Icons.chat_bubble_outline, "병원 검색", () {}),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _profileImage() {
    return GestureDetector(
      onTap: () {
        controller.pickImage(ProfileImageType.THUMBNAIL);
      },
      child: SizedBox(
        width: 120,
        height: 120,
        child: Stack(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: controller.myProfile.value.avatarFile == null
                      ? Image.network(
                          "https://img.freepik.com/free-icon/user_318-804790.jpg?w=2000",
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          controller.myProfile.value.avatarFile!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            controller.isEditMyProfile.value
                ? Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 20,
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget _profileInfo() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            controller.myProfile.value.name!,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          controller.myProfile.value.discription!,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  Widget _partProfileInto(String value, Function()? ontap) {
    return GestureDetector(
      onTap: ontap,
      child: Stack(
        children: [
          Container(
            height: 45,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: Colors.white),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const Positioned(
            right: 0,
            bottom: 15,
            child: Icon(
              Icons.edit,
              color: Colors.white,
              size: 18,
            ),
          )
        ],
      ),
    );
  }

  Widget _editProfileInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Obx(
        () => Column(
          children: [
            _partProfileInto(controller.myProfile.value.name!, () async {
              var value = await Get.dialog(TextEditorWidget(
                text: controller.myProfile.value.name!,
              ));
              if (value != null) {
                controller.updateName(value);
              }
            }),
            _partProfileInto(controller.myProfile.value.discription!, () async {
              var value = await Get.dialog(TextEditorWidget(
                text: controller.myProfile.value.discription!,
              ));
              if (value != null) {
                controller.updateDiscription(value);
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _myProfile() {
    return Positioned(
      bottom: 120,
      left: 0,
      right: 0,
      child: SizedBox(
        height: 220,
        child: Obx(
          () => Column(
            children: [
              _profileImage(),
              controller.isEditMyProfile.value
                  ? _editProfileInfo()
                  : _profileInfo(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3f3f3f),
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          children: [
            _backgroundImage(),
            _header(),
            _myProfile(),
            _footer(),
          ],
        ),
      ),
    );
  }
}
