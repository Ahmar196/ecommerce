import 'package:ecommerce/view_model/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/view_model/view_model.dart'; // Assuming you have a CartVM and OrderVM in your view_model file
import 'package:ecommerce/screens/order_details.dart'; // Assuming OrderDetails is another screen in your project
import 'package:ecommerce/widget/container_widget_model.dart'; // Custom container widget

class PaymentMethodScreen extends StatefulWidget {
  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String selectedPaymentMethod = 'amazon_pay'; // Default selected payment method

  // Controllers for each text field
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cartVM = Provider.of<CartVM>(context); // Assuming CartVM is provided using Provider
    final orderVM = Provider.of<OrderVM>(context); // Get OrderVM

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Method'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Payment method options
              Column(
                children: [
                  buildPaymentOption('Amazon Pay', 'amazon_pay', 'assets/images/amazon-pay.png'),
                  buildPaymentOption('Credit Card', 'credit_card', 'assets/images/visa.png'),
                  buildPaymentOption('Paypal', 'paypal', 'assets/images/paypal.png'),
                  buildPaymentOption('Google Pay', 'google_pay', 'assets/images/icon2.png'),
                ],
              ),
              SizedBox(height: 16.0), // Spacing between sections

              // Form fields for Name, Address, and Contact
              buildTextField(controller: nameController, label: 'Name'),
              SizedBox(height: 16.0), // Spacing between fields
              buildTextField(controller: addressController, label: 'Address'),
              SizedBox(height: 16.0), // Spacing between fields
              buildTextField(
                controller: contactController,
                label: 'Contact',
                keyboardType: TextInputType.phone, // Set the keyboard type for phone numbers
              ),
              SizedBox(height: 16.0), // Spacing between fields

              // Sub-total, Shipping Fee, and Total Payment
              Divider(),
              buildSummaryRow('Sub-Total', "\$${cartVM.totalPrice}"),
              buildSummaryRow('Shipping Fee', '\$15.00'),
              Divider(),
              buildSummaryRow(
                'Total Payment',
                "\$${cartVM.totalPrice + 15}",
                isBold: true,
                color: Color(0xFFDB3022),
              ),

              SizedBox(height: 30.0), // Spacing before the button

              // Confirm Order button
              InkWell(
                onTap: () {
                  // Check if any fields are empty
                  if (nameController.text.isEmpty ||
                      addressController.text.isEmpty ||
                      contactController.text.isEmpty) {
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter Name, Address, and Contact No. fields.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return; // Exit the method early
                  }

                  // Add order details to the OrderVM with an additional status argument
                  orderVM.addOrder(
                    nameController.text,
                    addressController.text,
                    contactController.text,
                   // 'Pending', // Assuming 'Pending' is the status of the order
                  );

                  // Navigate to OrderDetails screen
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
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build each text field
  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
    );
  }

  // Helper method to build a row for Sub-Total, Shipping Fee, and Total Payment
  Widget buildSummaryRow(String label, String value, {bool isBold = false, Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
          ),
        ],
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
