import 'dart:io';

import 'package:ecommerce/model/model.dart';
import 'package:ecommerce/screens/cart_screen.dart';
import 'package:ecommerce/screens/product_details_popup%20.dart';

import 'package:ecommerce/view_model/view_model.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductScreen extends StatelessWidget {
  final int imageIndex; // Added imageIndex parameter

  ProductScreen({required this.imageIndex}); // Constructor to accept imageIndex

  final List<String> imageList = [
    "assets/images/image1.jpg",
    "assets/images/image2.jpg",
    "assets/images/image3.jpg",
    "assets/images/image4.jpg",
  ];

  final List<Product> products = [
    Product(
      name: 'Warm Zipper',
      description:
          'Cool, windy weather is on its way. Send him out the door in a jacket he wants to wear. Warm Zipper Hooded Jacket.',
      image: 'assets/images/image1.jpg',
      price: 100,
    ),
    Product(
      name: "Knitted Wool",
      description: 'Cool, windy weather is on its way.',
      image: 'assets/images/image2.jpg',
      price: 200,
    ),
    Product(
      name: "Zipper Win",
      description:
          'Cool, windy weather is on its way. Warm Zipper Hooded Jacket.',
      image: 'assets/images/image3.jpg',
      price: 300,
    ),
    Product(
      name: "Child Win",
      description:
          'Send him out the door in a jacket he wants to wear. Warm Zipper Hooded Jacket.',
      image: 'assets/images/image4.jpg',
      price: 400,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Get the product based on imageIndex
    final product = products[imageIndex]; // Get the corresponding product

    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
        actions: [
          Consumer<CartVM>(builder: (context, cartVM, child) {
            return Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartScreen()),
                    );
                  },
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      '${cartVM.totalCartItems}', // Display cart item count
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 450,
                  width: MediaQuery.of(context).size.width,
                  child: FanCarouselImageSlider.sliderType1(
                    imagesLink: imageList,
                    isAssets: true, // Set to true for asset images
                    autoPlay: false,
                    sliderHeight: 400,
                    showIndicator: true,
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product
                              .name, // Display product name based on imageIndex
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w900,
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Hooded Jacket', // You might want to adjust this if needed
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '\$${product.price}', // Display product price based on imageIndex
                      style: TextStyle(
                        color: Color(0xffdb3022),
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // Display saved rating, review, and image
                FutureBuilder<Map<String, dynamic>>(
                  future:
                      _loadReviewAndRating(), // Load saved review, rating, and image path
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasData) {
                      final rating = snapshot.data!['rating'] ?? 0.0;
                      final review =
                          snapshot.data!['review'] ?? 'No review available';
                      final imagePath = snapshot.data!['imagePath'] ?? '';

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // If an image exists, display it
                          if (imagePath.isNotEmpty)
                            Image.file(
                              File(imagePath),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          SizedBox(height: 10),
                          RatingBarIndicator(
                            rating: rating, // Display saved rating
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber, // Yellow color for stars
                            ),
                            itemCount: 5,
                            itemSize: 25.0,
                            direction: Axis.horizontal,
                          ),
                          SizedBox(height: 10),
                          Text(
                            review, // Display saved review
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      );
                    } else {
                      return Text('No reviews yet');
                    }
                  },
                ),

                SizedBox(height: 20),
                Text(
                  product
                      .description, // Display product description based on imageIndex
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Provider.of<CartVM>(context, listen: false)
                            .addToCart(product); // Add product to cart
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Color(0x1F989797),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.shopping_cart,
                            color: Color(0xFFDB3022),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showProductDetails(
                            context, product); // Show product details popup
                      },
                      child: ProductDetailsPopUp(
                        product: product, // Pass the product for pop-up
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method to show product details in a popup
  void _showProductDetails(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) =>
          ProductDetailsPopUp(product: product), // Pass selected product
    );
  }

  // Function to load rating, review, and image path from SharedPreferences
Future<Map<String, dynamic>> _loadReviewAndRating() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  double rating = prefs.getDouble('userRating') ?? 0.0;
  String review = prefs.getString('userReview') ?? '';
  String imagePath = prefs.getString('userImagePath') ?? ''; // Load image path
  return {'rating': rating, 'review': review, 'imagePath': imagePath};
}
}
