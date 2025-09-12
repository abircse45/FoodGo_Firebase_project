import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodgo/models/user_model.dart';
import 'package:foodgo/services/auth_services.dart';
import 'package:foodgo/view/home_screen.dart';
import 'package:foodgo/view/profile_screen.dart';
import 'package:foodgo/view/splash_screen.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // Auth Services
  final AuthServices _authServices = AuthServices();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Loading State
  var isLoading = false.obs;

  var textFieldEnable = false.obs;

  var isProfileLoading = false.obs;
  Rxn<UserModel> currentUser = Rxn<UserModel>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // Signup Function
  Future<void> signup() async {
    try {
      isLoading.value = true;
      User? user = await _authServices.signUp(
        emailController.text,
        passwordController.text,
        firstNameController.text,
        lastNameController.text,
        addressController.text,
      );
      if (user != null) {
        Get.snackbar(
          "Success",
          "User registration Successfully ",
          backgroundColor: Colors.grey,
          colorText: Colors.white,
        );
      }

      log("${user?.email}");

      Get.offAll(FoodgoHomePage(), transition: Transition.noTransition);

      isLoading.value = false;
    } catch (abir) {
      isLoading.value = false;
      Get.snackbar("Error", "${abir.toString()}");
    }
  }

  // Login Function

  Future<void> signIn() async {
    try {
      isLoading.value = true;
      User? user = await _authServices.signIn(
        emailController.text,
        passwordController.text,
      );

      Get.snackbar(
        "Success",
        "User Login Successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      log("${user?.email}");

      Get.offAll(FoodgoHomePage(), transition: Transition.noTransition);
      isLoading.value = false;
    } catch (exception) {}
  }

  Future<void> fetchUserProfile() async {
    try {
      isProfileLoading.value = true;

      UserModel? userModel = await _authServices.getUserProfile();

      if (userModel != null) {
        currentUser.value = userModel;
        isProfileLoading.value = false;
      }
    } catch (e) {
      isProfileLoading.value = false;
      throw Exception("Profile data not found");
    }
  }

  Future signOut() async {
    await _authServices.signOut();
    Get.snackbar("Success", "User Sign out Succcessfully");
    Get.offAll(SplashScreen(), transition: Transition.noTransition);
  }

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }
}
