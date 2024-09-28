// ignore_for_file: must_be_immutable

import 'package:ecommerce/model/model.dart';
import 'package:ecommerce/screens/PaymentMethodScreen.dart';

import 'package:ecommerce/view_model/view_model.dart';
import 'package:ecommerce/widget/container_widget_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // For state management with Provider

class ProductDetailsPopUp extends StatelessWidget {
  final TextStyle iStyle = TextStyle(
    color: Colors.black87,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  final Product product; // Assuming you pass a product to this widget

  ProductDetailsPopUp({required this.product});

  List<Color> clrs = [
    Colors.red,
    Colors.green,
    Colors.indigo,
    Colors.amber,
  ];

  @override
  Widget build(BuildContext context) {
    // Access the CartVM using Provider
    final cartVM = Provider.of<CartVM>(context);

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) => Container(
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Size:", style: iStyle),
                              SizedBox(height: 20),
                              Text("Color:", style: iStyle),
                              SizedBox(height: 20),
                              Text("Total:", style: iStyle),
                              SizedBox(height: 20),
                            ],
                          ),
                          SizedBox(width: 30),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  Text("S", style: iStyle),
                                  SizedBox(width: 20),
                                  Text("M", style: iStyle),
                                  SizedBox(width: 20),
                                  Text("L", style: iStyle),
                                  SizedBox(width: 20),
                                  Text("XL", style: iStyle),
                                  SizedBox(width: 30),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  for (var i = 0; i < 4; i++)
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                        color: clrs[i],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(height: 20),
                              // Using Consumer to rebuild when quantity changes
                              Consumer<CartVM>(
                                builder: (context, cartVM, child) {
                                  return Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(CupertinoIcons.minus,
                                            color: Colors.greenAccent),
                                        onPressed: () {
                                          if (product.quantity >=
                                              product.quantity) {
                                            cartVM.decrementQuantity(product);
                                          }
                                        },
                                      ),
                                      Text(
                                        "${product.quantity}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      IconButton(
                                        icon: Icon(CupertinoIcons.plus),
                                        onPressed: () {
                                          cartVM.incrementQuantity(product);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(CupertinoIcons.trash,
                                            color: Colors.red),
                                        onPressed: () {
                                          cartVM.removeFromCart(product);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Payment", style: iStyle),
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
                  Flexible(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentMethodScreen()),
                        );
                      },
                      child: ContainerWidgetModel(
                        containerWidth: MediaQuery.of(context).size.width,
                        itext: "Checkout",
                        bgcolor: Color(0xFFDB3022),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: ContainerWidgetModel(
        containerWidth: MediaQuery.of(context).size.width / 1.5,
        itext: "Buy Now",
        bgcolor: Color(0xFFDB3022),
      ),
    );
  }
}
