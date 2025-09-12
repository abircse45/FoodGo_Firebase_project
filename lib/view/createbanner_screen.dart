import 'package:flutter/material.dart';
import 'package:foodgo/controller/banner_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreatebannerScreen extends GetView<BannerController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => BannerController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Create Banner")),
      body: SingleChildScrollView(
        child: Column(children: [_imagePickerSection()]),
      ),
    );
  }

  Widget _imagePickerSection() {
    return Padding(
      padding: EdgeInsets.all(6.0),
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Obx(() {
                if (controller.selectedImage.value != null) {
                  return Container(
                    height: 200,
                    width: double.infinity,

                    child: Image.file(
                      controller.selectedImage.value!,
                      fit: BoxFit.cover,
                    ),
                  );
                } else {
                  return Center(child: Text("Please Upload Your Image"));
                }
              }),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      controller.pickerImage(ImageSource.camera);
                    },
                    child: Text("Camera"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.pickerImage(ImageSource.gallery);
                    },
                    child: Text("Gallery"),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            Obx(() {
              if (controller.isbvannerLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return ElevatedButton(
                onPressed: () {
                  controller.createBanners();
                },
                child: Text("Create Banner"),
              );
            }),
          ],
        ),
      ),
    );
  }
}
