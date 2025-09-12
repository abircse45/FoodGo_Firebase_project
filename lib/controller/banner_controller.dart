import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodgo/models/banner_model.dart';
import 'package:foodgo/services/banner_services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../services/cloudinary_services.dart';

class BannerController extends GetxController {
  BannerServices bannerServices = BannerServices();

  var bannerList = <BannerModel>[].obs;
  var currentIndex = 0.obs;

  var selectedImage = Rx<File?>(null);
  var isbvannerLoading = false.obs;
  var uploadImageUrl = "".obs;

  ImagePicker imagePicker = ImagePicker();

  Future pickerImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
      }
    } catch (e) {
      print("Image Picker Error $e");
    }
  }

  Future fetchBanner() async {
    isbvannerLoading.value = true;

    try {
      var bannerdata = await bannerServices.getAllbanner();
      bannerList.value = bannerdata;
      isbvannerLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String?> uploadImageToCloudinary() async {
    if (selectedImage.value == null) {
      return null;
    }

    try {
      final imageUrl = await CloudinaryServices.uploadImage(
        selectedImage.value!,
      );

      if (imageUrl != null) {
        uploadImageUrl.value = imageUrl;

        return imageUrl;
      }
    } catch (e) {
      print("Cloudinary Upload Error $e");
      return null;
    }
  }

  Future createBanners() async {
    isbvannerLoading.value = true;

    final imageurlFromFirebase = await uploadImageToCloudinary();
    var uuid = Uuid();
    final updatebanner = BannerModel(
      id: uuid.v4(),
      imageUrl: imageurlFromFirebase,
    );

    await bannerServices.createbanners(updatebanner);

    Get.snackbar(
      "Success",
      "Banner Create Successfully",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    isbvannerLoading.value = false;
    await fetchBanner();
  }

  @override
  void onInit() {
    super.onInit();
    fetchBanner();
  }
}
