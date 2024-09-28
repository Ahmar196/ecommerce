import 'package:ecommerce/view_model/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class OrderTrackerScreen extends StatelessWidget {
  final Order order;

  OrderTrackerScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(0xffdb3022),
        elevation: 0,
        title: Text(
          'Track parcel',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://via.placeholder.com/150'), // Replace with user's profile image URL
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTrackingSection(),
          Expanded(child: _buildOrderDetailsSection()), // Updated to show order details
        ],
      ),
      // bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // Section for inputting the tracking number
  Widget _buildTrackingSection() {
    return Container(
      color: Color(0xffdb3022),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Tracking number',
              suffixIcon: Icon(Icons.qr_code, color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () {},
              child: Text(
                'Track parcel',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Section for displaying order details
  Widget _buildOrderDetailsSection() {
    return AnimationConfiguration.staggeredList(
      position: 1,
      duration: const Duration(milliseconds: 500),
      child: FadeInAnimation(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _buildOrderDetail('Order Name:', order.name,),
              _buildOrderDetail('Shipping to:', order.address),
              _buildOrderDetail('Contact:', order.contact),
              _buildOrderDetail('Order Status:', order.status), // Assuming status is part of the order
              SizedBox(height: 20),
              _buildEstimatedDelivery(),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build individual order details
  Widget _buildOrderDetail(String title, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              detail,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Estimated delivery section
  Widget _buildEstimatedDelivery() {
    DateTime estimatedDeliveryDate = DateTime.now().add(Duration(days: 2)); // Set to 2 days from now
    String formattedShippingDate =
        "${estimatedDeliveryDate.day}/${estimatedDeliveryDate.month}/${estimatedDeliveryDate.year}";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Estimated Delivery:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(
          'Your parcel is expected to arrive by $formattedShippingDate',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  // Bottom Navigation Bar (if needed in the future)
  // Widget _buildBottomNavBar() {
  //   return BottomNavigationBar(
  //     items: [
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.list),
  //         label: 'My parcels',
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.send),
  //         label: 'Send parcel',
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.location_city),
  //         label: 'Parcel center',
  //       ),
  //     ],
  //     selectedItemColor: Colors.black,
  //     unselectedItemColor: Colors.grey,
  //     showUnselectedLabels: true,
  //   );
  // }
}
