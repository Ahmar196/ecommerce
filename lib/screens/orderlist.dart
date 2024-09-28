import 'package:ecommerce/screens/ordertracker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/view_model/order.dart'; // Ensure this is your correct path

class OrderListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderVM = Provider.of<OrderVM>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffdb3022),
        title: Text(
          'My Orders',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.refresh),
            onPressed: () {
              orderVM
                  .clearOrders(); // Clear all orders when the refresh icon is clicked
            },
          ),
        ],
      ),
      body: Consumer<OrderVM>(
        builder: (context, orderVM, child) {
          if (orderVM.orders.isEmpty) {
            return Center(
              child: Text(
                'No Orders',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            );
          }

          return ListView.builder(
            itemCount: orderVM.orders.length,
            itemBuilder: (context, index) {
              final order = orderVM.orders[index];

              // Format the dates
              final String formattedOrderDate =
                  DateFormat('dd MMM yyyy').format(order.orderDate);
              final String formattedShippingDate =
                  DateFormat('dd MMM yyyy').format(order.shippingDate);

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: Icon(Icons.local_shipping,
                          size: 40, color: Color(0xffdb3022)),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order ${order.name}', // Example order name
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Order Date: $formattedOrderDate',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            'Shipping Date: $formattedShippingDate',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                      trailing: Icon(
                          Icons.arrow_forward_ios), // Add "greater than" arrow
                      onTap: () {
                        // Show popup with order details
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Order Details'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Name: ${order.name}'),
                                  SizedBox(height: 8),
                                  Text('Address: ${order.address}'),
                                  SizedBox(height: 8),
                                  Text('Contact: ${order.contact}'),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: Text('Close'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    // Order Tracker button
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OrderTrackerScreen(order: order),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffdb3022), // Background color
                        ),
                        child: Text('Order Tracker',style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
