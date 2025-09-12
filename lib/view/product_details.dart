import 'package:flutter/material.dart';
import 'package:foodgo/controller/cart_controller.dart';
import 'package:foodgo/view/cart_screen.dart';
import 'package:get/get.dart';

import '../models/product_model.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel productModel;

  const ProductDetailPage({Key? key, required this.productModel})
      : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {

  final CartController cartController = Get.put(CartController());
  int quantity = 1;
  double spiciness = 0.3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.arrow_back, color: Colors.black87),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: (){
                      Get.to(CartScreen(),transition: Transition.noTransition);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.shopping_cart_outlined, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),

            // Product Image
            Container(
              height: 250,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Container(
                  width: double.infinity,
                  height: 250,

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),

                    child: Image.network(
                      "${widget.productModel.images}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 30),

            // Product Details
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.productModel.name}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    SizedBox(height: 10),

                    Row(
                      children: [
                        Text(
                          "Price : ${widget.productModel.price.toString()}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 15),
                      ],
                    ),

                    SizedBox(height: 20),

                    Text(
                      '${widget.productModel.description}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),

                    SizedBox(height: 30),

                    // Spicy Level
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Spicy',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Text(
                                    'Mild',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  Expanded(
                                    child: SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        activeTrackColor: Color(0xFFE53E3E),
                                        inactiveTrackColor: Colors.grey[300],
                                        thumbColor: Color(0xFFE53E3E),
                                        overlayColor: Color(
                                          0xFFE53E3E,
                                        ).withOpacity(0.2),
                                        thumbShape: RoundSliderThumbShape(
                                          enabledThumbRadius: 8,
                                        ),
                                      ),
                                      child: Slider(
                                        value: spiciness,
                                        onChanged: (value) {
                                          setState(() {
                                            spiciness = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Hot',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: 40),

                        // Quantity
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Quantity',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {

                                    if(quantity> 1){
                                      setState(() {
                                        quantity--;
                                      });
                                    }

                                  },
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFE53E3E),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                                Text(
                                  quantity.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 15),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      quantity++;
                                    });
                                  },
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFE53E3E),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

                    Spacer(),

                    // Price and Order Button
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            cartController.addTocart(widget.productModel, quantity);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 15,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFE53E3E),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              'Add to cart',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                'ORDER NOW',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}