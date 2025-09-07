import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodgo/view/home_screen.dart';
import 'package:foodgo/view/profile_screen.dart';
import 'package:foodgo/view/signup_screens.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      checkLoginStatus();
    });
  }

  checkLoginStatus() {
    User? currentuser = FirebaseAuth.instance.currentUser;
    if (currentuser != null) {
      Get.offAll(ProfileScreen(), transition: Transition.noTransition);
    } else {
      Get.offAll(SignupScreens(), transition: Transition.noTransition);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0XFFfc8089), Color(0XFFef2a39)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 280),
                Center(
                  child: Text(
                    "FoodGo",
                    style: TextStyle(
                      fontSize: 60,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),

            Positioned(
              bottom: 0,
              left: -15,
              child: Image.asset(
                "assets/images/burger1.png",
                width: 180,
                height: 200,
              ),
            ),

            Positioned(
              bottom: 0,
              right: 0,
              left: -70,
              child: Image.asset(
                "assets/images/burger2.png",
                width: 120,
                height: 130,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
