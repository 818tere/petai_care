import 'dart:io';

import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petai_care/screens/diary/image_crop_controller.dart';
import 'package:petai_care/screens/diary/profile.dart';
import 'package:petai_care/screens/diary/profile_controller.dart';



class DiaryScreen extends StatelessWidget {
  const DiaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ImageCropper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(primaryColor: Colors.white),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut<ProfileController>(()=>ProfileController());
        Get.lazyPut<ImageCropController>(()=>ImageCropController());
      }),
      home: Profile(),
    );
  }
}