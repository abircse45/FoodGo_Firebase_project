import 'package:flutter/material.dart';
import 'package:foodgo/controller/cart_controller.dart';
import 'package:get/get.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CartController());
    return Scaffold(
      appBar: AppBar(title: Text("cart")),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: controller.cartItems.length,
                  itemBuilder: (context, index) {
                    var data = controller.cartItems[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        child: ListTile(
                          title: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage("${data.prouctImage}"),
                              ),
                              SizedBox(width: 20),
                              Text("${data.productname}"),
                            ],
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Quantity : ${data.quantity}",style: TextStyle(
                                fontSize: 20,fontWeight: FontWeight.bold
                              ),),

                              Text("Price : ${data.productPrice}"),

                              SizedBox(height: 30),

                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      controller.incrementQuantity(data);
                                    },
                                    icon: Icon(Icons.add),
                                  ),

                                  SizedBox(width: 20),
                                  IconButton(
                                    onPressed: () {
                                      controller.decrementQuantity(data);
                                    },
                                    icon: Icon(Icons.minimize_rounded),
                                  ),
                                  SizedBox(width: 20),
                                  IconButton(
                                    onPressed: () {
                                      controller.remove(data);
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(bottom: 38.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total Items : ${controller.totalItems.value}",style: TextStyle(
                    fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold
                  ),),
                  Text("Total Price : ${controller.totalAmount.value}",style: TextStyle(
                      fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold
                  ),),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 38.0),
              child: ElevatedButton(onPressed: (){
                controller.placeOrder();

              }, child: Text("Checkout")),
            ),

          ],
        ),
      ),
    );
  }
}
