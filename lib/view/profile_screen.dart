import 'package:flutter/material.dart';
import 'package:foodgo/controller/auth_controller.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<AuthController> {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AuthController());
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        child: Container(
          color: Colors.white,
          height: 80,
          child: Row(
            children: [
              GestureDetector(
                onTap: (){
                  controller.textFieldEnable.value = true;
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Container(
                    height: 70,
                    width: 195,
                    decoration: BoxDecoration(
                      color: Color(0xFF3C2F2F),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Obx(()=> Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          controller.textFieldEnable.value==true ? "Update profile" : "Edit Profile",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 10),

                        controller.textFieldEnable.value==true ? Container() :   Image.asset(
                          "assets/images/edit.png",
                          height: 24,
                          width: 24,
                        ),
                      ],
                    ),),
                  ),
                ),
              ),
              SizedBox(width: 20),

              GestureDetector(
                onTap: () {
                  controller.signOut();
                },
                child: Container(
                  height: 70,
                  width: 175,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 10),

                      Image.asset(
                        "assets/images/sign-out.png",
                        height: 24,
                        width: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0XFFfc8089), Color(0XFFef2a39)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Obx((){

          if(controller.isProfileLoading.value){
            return Center(child: CircularProgressIndicator(),);
          }else{

            controller.firstNameController.text = controller.currentUser.value?.firstName?? "";
            controller.lastNameController.text = controller.currentUser.value?.lastName?? "";
            controller.emailController.text = controller.currentUser.value?.email?? "";
            controller.addressController.text = controller.currentUser.value?.address?? "";


            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 48.0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.settings, color: Colors.white),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 161.0),
                    child: Container(
                      height: 781,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                      ),
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 30),

                            _textField(
                              "Enter your first name",
                              controller.firstNameController,
                            ),
                            _textField(
                              "Enter your last name",
                              controller.lastNameController,
                            ),
                            _textField(
                              "Enter your email",
                              controller.emailController,
                            ),
                            _textField(
                              "Enter your address",
                              controller.addressController,
                            ),

                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

        }),
      ),
    );
  }

  Widget _textField(
    String hint,
    TextEditingController textEditingcontroller, {
    bool isPassword = false,

  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: TextField(
          enabled: controller.textFieldEnable.value,
          controller: textEditingcontroller,
          obscureText: isPassword,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: hint,
          ),
        ),
      ),
    );
  }
}
