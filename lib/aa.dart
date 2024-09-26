import 'dart:convert';

import 'package:ecommerce/screens/productscreen.dart';
import 'package:ecommerce/view_model/ProductsModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Aa extends StatefulWidget {
  const Aa({super.key});

  @override
  State<Aa> createState() => _AaState();
}

class _AaState extends State<Aa> {
  List<ProductsModel> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts(); // Fetch data from JSON
  }

Future<void> fetchProducts() async {
  String response = await rootBundle.loadString('products.json');
  List<dynamic> data = jsonDecode(response);
  setState(() {
    products = data.map((item) => ProductsModel.fromJson(item)).toList();
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                // Other widgets like search, notification, etc.

                // Check if products are available
                products.isNotEmpty
                    ? Column(
                        children: [
                          // Horizontal Product List
                          SizedBox(
                            height: 180,
                            child: ListView.builder(
                              itemCount: products.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: MediaQuery.of(context).size.width * 0.85,
                                  margin: EdgeInsets.only(right: 15),
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => ProductScreen(imageIndex: index),
                                                ),
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Image.asset(
                                                products[index].imageList.first, // Using the field from ProductsModel
                                                height: 200,
                                                width: MediaQuery.of(context).size.width * 0.4,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          // Other widgets like favorite icon, etc.
                                        ],
                                      ),
                                      // Product Details
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              products[index].title,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            // Other details like description, price, reviews, etc.
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          // Newest Products Section
                          GridView.builder(
                            itemCount: products.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemBuilder: (context, index) {
                              return Container(
                                child: Column(
                                  children: [
                                    // Product Image
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProductScreen(imageIndex: index),
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          products[index].imageList.first, // Image from ProductsModel
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    // Product Title and Price
                                    Text(products[index].title),
                                    Text('${products[index].price}'),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    : CircularProgressIndicator(), // Show loading spinner while fetching products
              ],
            ),
          ),
        ),
      ),
    );
  }
}
