import 'package:flutter/material.dart';
import 'package:foodgo/controller/product_controller.dart';
import 'package:foodgo/models/product_model.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../component/widget/custom_button.dart';

class AddproductScreen extends GetView<ProductController> {
  const AddproductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProductController());
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.red,
        title: Text(
          "Create Product",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),

            _textField(
              "Enter your product name",
              controller.productnameController,
            ),
            _textField(
              "Enter your product image url",
              controller.productImageController,
            ),

            _textField(
              "Enter your product price",
              controller.productpriceController,
            ),
            _textField(
                "Enter your product description",
                controller.productDescriptionController,


            ),

            SizedBox(height: 30),

            Obx(() {
              if (controller.isloading.value) {
                return Center(child: CircularProgressIndicator());
              } else {
                return CustomButton(
                  onTab: () {
                    var uuid = Uuid();

                    final newProduct = ProductModel(
                      id: uuid.v4(),
                      name: controller.productnameController.text,
                      images: controller.productImageController.text,
                      description: controller.productDescriptionController.text,
                      price: controller.productpriceController.text,
                    );

                    controller.addProduct(newProduct);
                  },
                  text: "Create Product",
                  bgColor: Colors.red,
                  textColor: Colors.white,
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _textField(
    String hint,
    TextEditingController textEditingcontroller, {
    bool isPassword = false,

  }) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Card(
        color: Colors.white,
        elevation: 6,

        child: Padding(
          padding: EdgeInsets.all(15),
          child: Container(
            child: TextField(
              controller: textEditingcontroller,
              obscureText: isPassword,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
