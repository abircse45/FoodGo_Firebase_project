import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:foodgo/controller/banner_controller.dart';
import 'package:foodgo/controller/product_controller.dart';
import 'package:foodgo/models/product_model.dart';
import 'package:foodgo/view/addproduct_screen.dart';
import 'package:foodgo/view/createbanner_screen.dart';
import 'package:foodgo/view/order_screen.dart';
import 'package:foodgo/view/product_details.dart';
import 'package:get/get.dart';
import 'cart_screen.dart';


class FoodgoHomePage extends StatefulWidget {
  @override
  _FoodgoHomePageState createState() => _FoodgoHomePageState();
}

class _FoodgoHomePageState extends State<FoodgoHomePage> {
  int _currentIndex = 0;
  PageController _pageController = PageController();

  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    AddproductScreen(),
    OrderScreen(),
    CreatebannerScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 60.0,
        items: <CurvedNavigationBarItem>[
          CurvedNavigationBarItem(
            child: Icon(Icons.home, size: 24, color: Colors.white),
            label: '',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.person, size: 24, color: Colors.white),
            label: '',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.add, size: 24, color: Colors.white),
            label: '',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.favorite, size: 24, color: Colors.white),
            label: '',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.image, size: 24, color: Colors.white),
            label: '',
          ),
        ],
        color: Color(0xFFE53E3E),
        buttonBackgroundColor: Color(0xFFE53E3E),
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}

class HomePage extends GetView<ProductController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProductController());

    BannerController bannerController = Get.put(BannerController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.isloading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Foodgo',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Order your favourite food!',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
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
                      SizedBox(width: 20,),
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.pink[100],
                        child: Icon(Icons.person, color: Colors.pink[300]),
                      ),
                    ],
                  ),
                ),

                // Search Bar
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.search, color: Colors.grey[600]),
                              SizedBox(width: 10),
                              Text(
                                'Search',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xFFE53E3E),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(Icons.tune, color: Colors.white, size: 24),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 25),

                Obx(() {
                  return CarouselSlider(
                      options: CarouselOptions(
                        height: 200,
                        aspectRatio: 16/9,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index,_){
                          bannerController.currentIndex.value = index;
                        }
                      ),
                    items: bannerController.bannerList.map((data) {

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 200,
                          child: ClipRRect(

                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              "${data.imageUrl}",
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),


                Obx((){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(bannerController.bannerList.length, (index){
                      return Container(
                        width: 10,
                        height: 10,
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:  bannerController.currentIndex.value == index   ? Colors.red : Colors.grey
                        ),
                      );
                    }),
                  );
                }),

                SizedBox(height: 25),

                // Food Items Grid
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: controller.product.isEmpty
                        ? Center(
                            child: Text(
                              "No Product Found",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                  childAspectRatio: 0.75,
                                ),
                            itemCount: controller.product.length,
                            itemBuilder: (context, index) {
                              return FoodCard(
                                productModel: controller.product[index],
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}

class FoodCard extends StatelessWidget {
  final ProductModel productModel;

  const FoodCard({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailPage(productModel: productModel),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food Image
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  color: Colors.grey[100],
                ),
                child: Center(
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(),

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),

                      child: Image.network(
                        "${productModel.images}",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Food Details
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productModel.name.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    Text(
                      productModel.description.toString(),
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Icon(Icons.star, size: 16, color: Colors.orange),
                        SizedBox(width: 4),
                        Text(
                          "${productModel.price}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.favorite_border,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
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



class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Search Page',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Search Page',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class FoodItem {
  final String name;
  final String subtitle;
  final double rating;
  final String image;
  final double price;

  FoodItem({
    required this.name,
    required this.subtitle,
    required this.rating,
    required this.image,
    required this.price,
  });
}
