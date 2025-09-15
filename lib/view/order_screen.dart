import 'package:flutter/material.dart';
import 'package:foodgo/controller/cart_controller.dart';
import 'package:get/get.dart';

class OrderScreen extends GetView<CartController> {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CartController());
    return Scaffold(
      appBar: AppBar(title: Text("order list")),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.orders.length,
          itemBuilder: (context, index) {
            var data = controller.orders[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: ListTile(
                  title: Text("TotalItems ${data.totalItems}"),
                  subtitle: Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(" Total amount ${data.totalAmount}"),

                        ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: data.items!.length,
                          itemBuilder: (context, orderDatIndex) {
                            var orderData = data.items![orderDatIndex];
                            return Card(
                              elevation: 5,
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    "${orderData["prouctImage"]}",
                                  ),
                                ),
                                title: Text("${orderData["productname"]}"),
                                subtitle: Text(
                                  "Price : ${orderData!["productPrice"]}",
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
