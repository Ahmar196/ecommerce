import 'package:ecommerce/screens/confirm_order.dart';
import 'package:ecommerce/screens/reviewpop.dart';
import 'package:ecommerce/view_model/view_model.dart';
import 'package:ecommerce/widget/container_widget_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider

class OrderDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access CartVM using Provider
    final cartVM = Provider.of<CartVM>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Order'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Handle menu button press
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shipping Address
            Text(
              "Shipping Address",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 15),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 130,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Dear Pro",
                          style: TextStyle(fontSize: 16),
                        ),
                        TextButton(
                          onPressed: () {
                            // Implement address change functionality
                          },
                          child: Text(
                            "Change",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xffdb3022),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "3 Newbridge Court",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Chino Hills, CA 97545, United States",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),

            // Payment Method
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Payment Method",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                ),
                TextButton(
                  onPressed: () {
                    // Handle payment method change
                  },
                  child: Text(
                    "Change",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xffdb3022),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Container(
                  height: 50,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "assets/images/mastercard-26161.png", // Correct asset path
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: 15),
                Text(
                  '**** **** **** 3947',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Delivery Method",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/images/icon3.png", // Correct asset path
                          height: 20,
                          fit: BoxFit.contain,
                        ),
                        Text('2-3 Days')
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 60,
                        width: 130,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 2,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Home Delivery',
                              style: TextStyle(
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text('2-3 Days')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sub-Total', style: TextStyle(fontSize: 16)),
                Text(
                  "\$${cartVM.totalPrice}",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Shipping Fee', style: TextStyle(fontSize: 16)),
                  Text('\$15.00', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Payment',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  // Accessing the totalPrice from cartVM
                  Text(
                    "\$${cartVM.totalPrice + 15}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFDB3022),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
           Flexible(
  child: InkWell(
    onTap: () {
      // Show the review modal sheet when Confirm Order is clicked
      showReviewModalSheet(context);
    },
    child: ContainerWidgetModel(
      containerWidth: MediaQuery.of(context).size.width,
      itext: "Confirm Order",
      bgcolor: Color(0xFFDB3022),
    ),
  ),
),

          ],
        ),
      ),
    );
  }
}
