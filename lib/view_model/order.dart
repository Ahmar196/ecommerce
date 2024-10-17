import 'dart:convert'; // For JSON encoding/decoding
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Review {
  final double rating;
  final String comment;

  Review({required this.rating, required this.comment});

  // Convert a Review object to a Map for saving to SharedPreferences
  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'comment': comment,
    };
  }

  // Create a Review object from a Map (from SharedPreferences)
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: json['rating'],
      comment: json['comment'],
    );
  }
}

class Order {
  final String name;
  final String address;
  final String contact;
  final DateTime orderDate;
  final DateTime shippingDate;
  final String status; // Added status field to track order state
  final DateTime? estimatedDeliveryDate;
  final List<Review> reviews; // List of reviews

  Order({
    required this.name,
    required this.address,
    required this.contact,
    required this.orderDate,
    required this.shippingDate,
    required this.status,
    this.estimatedDeliveryDate,
    this.reviews = const [], // Initialize reviews
  });

  // Convert an Order object to a Map for saving to SharedPreferences
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'contact': contact,
      'orderDate': orderDate.toIso8601String(),
      'shippingDate': shippingDate.toIso8601String(),
      'status': status,
      'reviews': reviews.map((review) => review.toJson()).toList(), // Include reviews
    };
  }

  // Create an Order object from a Map (from SharedPreferences)
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      name: json['name'],
      address: json['address'],
      contact: json['contact'],
      orderDate: DateTime.parse(json['orderDate']),
      shippingDate: DateTime.parse(json['shippingDate']),
      status: json['status'],
      reviews: (json['reviews'] as List<dynamic>?) // Check for null here
          ?.map((review) => Review.fromJson(review))
          .toList() ?? [], // Provide an empty list if null
    );
  }
}

class OrderVM with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => _orders;

  // Key to store orders in SharedPreferences
  final String _ordersKey = 'orders_key';

  OrderVM() {
    _loadOrdersFromPreferences(); // Load orders when the ViewModel is initialized
  }

  // Method to add a new order with a default status and persist it
  void addOrder(String name, String address, String contact) {
    DateTime currentDate = DateTime.now();
    DateTime shippingDate = currentDate.add(Duration(days: 7));

    Order newOrder = Order(
      name: name,
      address: address,
      contact: contact,
      orderDate: currentDate,
      shippingDate: shippingDate,
      status: 'Order Placed', // Default initial status
      reviews: [], // Initialize with no reviews
    );

    _orders.add(newOrder);
    _saveOrdersToPreferences(); // Save the updated orders list
    notifyListeners(); // Notify listeners to update the UI
  }

  // Method to add a review to an existing order
  void addReviewToOrder(int orderIndex, double rating, String comment) {
    if (orderIndex >= 0 && orderIndex < _orders.length) {
      Review newReview = Review(rating: rating, comment: comment);
      _orders[orderIndex].reviews.add(newReview); // Add review to the specific order
      _saveOrdersToPreferences(); // Save the updated orders list
      notifyListeners(); // Notify listeners to update the UI
    }
  }

  // Method to update an existing order's status
  void updateOrderStatus(int index, String newStatus) {
    if (index >= 0 && index < _orders.length) {
      _orders[index] = Order(
        name: _orders[index].name,
        address: _orders[index].address,
        contact: _orders[index].contact,
        orderDate: _orders[index].orderDate,
        shippingDate: _orders[index].shippingDate,
        status: newStatus, // Update the status
        reviews: _orders[index].reviews, // Retain reviews
      );
      _saveOrdersToPreferences(); // Save the updated list
      notifyListeners(); // Notify listeners to update the UI
    }
  }

  // Method to clear all orders and persist the empty list
  void clearOrders() {
    _orders.clear();
    _saveOrdersToPreferences(); // Save the cleared list
    notifyListeners(); // Notify listeners to update the UI
  }

  // Method to refresh orders from SharedPreferences (in case they were cleared)
  void refreshOrders() {
    _loadOrdersFromPreferences();
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  // Method to persist the orders list to SharedPreferences
  Future<void> _saveOrdersToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonOrders = _orders.map((order) => jsonEncode(order.toJson())).toList();
    prefs.setStringList(_ordersKey, jsonOrders);
  }

  // Method to load the orders list from SharedPreferences
  Future<void> _loadOrdersFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonOrders = prefs.getStringList(_ordersKey);

    if (jsonOrders != null) {
      _orders = jsonOrders.map((jsonOrder) => Order.fromJson(jsonDecode(jsonOrder))).toList();
      notifyListeners(); // Notify listeners to update the UI
    }
  }
}
