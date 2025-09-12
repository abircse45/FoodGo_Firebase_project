import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodgo/models/cart_model.dart';
import 'package:foodgo/models/product_model.dart';
import 'package:foodgo/services/cart_services.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CartController extends GetxController {
  CartServices cartServices = CartServices();

  var cartItems = <CartModel>[].obs;
  RxDouble totalAmount = 0.0.obs;

  RxInt totalItems = 0.obs;
  var isLoading = false.obs;

  var uuid = Uuid();

  Future fetchItemcart() async {
    isLoading.value = false;
    var cartdata = await cartServices.getCart();
    cartItems.assignAll(cartdata!);

    isLoading.value = false;
  }

  Future addTocart(ProductModel productModel, int quantity) async {
    await fetchItemcart();

    CartModel cartModel = CartModel(
      id: uuid.v4(),
      productId: productModel.id,
      productname: productModel.name,
      prouctImage: productModel.images,
      productPrice: productModel.price,
      productDescription: productModel.description,
      qunatity: quantity,
      userId:
          FirebaseAuth.instance.currentUser?.uid, // Replace with actual user ID
    );

   await cartServices.addTocart(cartModel);

    Get.snackbar(
      "Success",
      "Cart Item Successfully",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    isLoading.value = false;
  }
}
