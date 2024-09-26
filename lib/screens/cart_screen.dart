import 'package:ecommerce/screens/PaymentMethodScreen.dart';
import 'package:ecommerce/view_model/view_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool selectAll = false; // Track 'Select All' status

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Consumer<CartVM>(
        builder: (context, cartVM, child) {
          if (cartVM.cartItems.isEmpty) {
            return Center(child: Text("Your cart is empty."));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  ListView.builder(
                    itemCount: cartVM.cartItems.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final product = cartVM.cartItems[index];
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Checkbox for each product
                            Checkbox(
                              value: product.isSelected,
                              onChanged: (val) {
                                setState(() {
                                  product.isSelected = val!;
                                  // Update selectAll state
                                  selectAll = cartVM.cartItems.every((item) => item.isSelected);
                                });
                              },
                            ),
                            // Product Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                product.image,
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 10),
                            // Product Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min, // Prevent overflow
                                children: [
                                  Text(
                                    product.name,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    product.description,
                                    style: TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "\$${product.price}",
                                    style: TextStyle(
                                      color: Color(0xffdb3022),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Quantity Controls and Delete Icon
                            Column(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(CupertinoIcons.minus, color: Colors.green),
                                      onPressed: () {
                                        if (product.quantity >= 1) {
                                          cartVM.decrementQuantity(product);
                                        }
                                      },
                                    ),
                                    Text(
                                      "${product.quantity}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(CupertinoIcons.plus, color: Colors.red),
                                      onPressed: () {
                                        cartVM.incrementQuantity(product);
                                      },
                                    ),
                                  ],
                                ),
                                // Delete Icon
                                IconButton(
                                  icon: Icon(CupertinoIcons.trash, color: Colors.red),
                                  onPressed: () {
                                    cartVM.removeFromCart(product); // Remove item from cart
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  // Select All Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Select All",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Checkbox(
                        splashRadius: 20,
                        activeColor: const Color(0xFFDB3022),
                        value: selectAll,
                        onChanged: (val) {
                          setState(() {
                            selectAll = val!;
                            // Select or deselect all items
                            for (var item in cartVM.cartItems) {
                              item.isSelected = selectAll; // Ensure Product has an isSelected property
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  Divider(height: 20, thickness: 1, color: Colors.black),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Payment",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "\$${cartVM.totalPrice}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFDB3022),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Checkout Button
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentMethodScreen()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFFDB3022),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          "Checkout",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
