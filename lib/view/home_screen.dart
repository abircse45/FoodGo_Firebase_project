import 'package:flutter/material.dart';
import 'package:foodgo/controller/product_controller.dart';
import 'package:foodgo/view/addproduct_screen.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<ProductController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(()=> ProductController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Get.to(AddproductScreen(), transition: Transition.leftToRight);
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Product Screen",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      body: Obx((){
        if(controller.isloading.value){
          return Center(child: CircularProgressIndicator(),);
        }else{
          return ListView.builder(
            itemCount: controller.product.length,
            itemBuilder: (context,index){
              var data = controller.product[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 4,
                  child: ListTile(
       
                    title: Text("${data.name}"),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Description: ${data.description}"),
                        SizedBox(height: 20,),
                        Text("Price: ${data.price}",style: TextStyle(
                          color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold
                        ),),
                        Image.network("${data.images}",height: 100,width: 100,),
                      ],
                    ),

                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
