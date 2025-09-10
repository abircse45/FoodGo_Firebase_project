import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodgo/models/product_model.dart';
import 'package:foodgo/services/cloudinary_services.dart';
import 'package:foodgo/services/product_firebase_services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ProductController extends GetxController {
  final ProductServices productServices = ProductServices();

  var isloading = false.obs;
  var product = <ProductModel>[].obs;

  var selectedImage = Rx<File?>(null);

  var uploadImageUrl = "".obs;

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

  final TextEditingController productnameController = TextEditingController();
  final TextEditingController productDescriptionController =
      TextEditingController();
  final TextEditingController productpriceController = TextEditingController();

  Future fetchProduct() async {
    try {
      isloading.value = true;
      final data = await productServices.getAllProduct();
      if (data.isNotEmpty) {
        product.assignAll(data);
      }
      isloading.value = false;
    } catch (e) {
      throw Exception("Something Went Wrong");
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

  Future addProduct() async {
    isloading.value = true;

    final imageurlFromFirebase = await uploadImageToCloudinary();
    var uuid = Uuid();
    final updateProduct = ProductModel(
      id: uuid.v4(),
      name: productnameController.text,
      description: productDescriptionController.text,
      price: productpriceController.text,
      images: imageurlFromFirebase,
    );

    await productServices.createProduct(updateProduct);

    Get.snackbar(
      "Success",
      "Product Create Successfully",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    isloading.value = false;
    await fetchProduct();
    clearAll();
  }

  clearAll() {
    productnameController.clear();
    productpriceController.clear();
    uploadImageUrl.value = "";
    productDescriptionController.clear();
  }

  @override
  void onInit() {
    super.onInit();
    fetchProduct();
  }
}
