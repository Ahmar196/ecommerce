import 'package:ecommerce/screens/order_details.dart';
import 'package:ecommerce/view_model/view_model.dart';
import 'package:ecommerce/widget/container_widget_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentMethodScreen extends StatefulWidget {
  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String selectedPaymentMethod =
      'amazon_pay'; // Default selected payment method

  @override
  Widget build(BuildContext context) {
     final cartVM = Provider.of<CartVM>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Payment Method')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
                context); // Navigate back when the back button is pressed
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment method options
            Column(
              children: [
                buildPaymentOption(
                    'Amazon Pay', 'amazon_pay', 'assets/images/amazon-pay.png'),
                buildPaymentOption(
                    'Credit Card', 'credit_card', 'assets/images/visa.png'),
                buildPaymentOption(
                    'Paypal', 'paypal', 'assets/images/paypal.png'),
                buildPaymentOption(
                    'Google Pay', 'google_pay', 'assets/images/icon2.png'),
              ],
            ),
            SizedBox(
              height: 75,
            ),
            // Sub-total, Shipping Fee, and Total Payment
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Sub-Total', style: TextStyle(fontSize: 16)),
                  Text(
                    "\$${cartVM.totalPrice}",
                    style: TextStyle(
                      fontSize: 18,
                      //fontWeight: FontWeight.w900,
                     // color: Color(0xFFDB3022),
                    ),
                  )
                ],
              ),
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
                  Text(
                    "\$${cartVM.totalPrice+15}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFDB3022),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Flexible(
              child: InkWell(
                onTap: () {
                  // Navigate to ConfirmOrder screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderDetails()),
                  );
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

  // Helper method to build each payment option
  Widget buildPaymentOption(String label, String method, String assetPath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = method;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedPaymentMethod == method ? Colors.red : Colors.grey,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedPaymentMethod == method
                        ? Colors.red
                        : Colors.transparent,
                    border: Border.all(color: Colors.red, width: 1.5),
                  ),
                ),
                SizedBox(width: 10),
                Text(label),
              ],
            ),
            Image.asset(
              assetPath,
              width: 60,
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
