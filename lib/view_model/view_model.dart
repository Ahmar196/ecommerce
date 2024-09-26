import 'package:ecommerce/model/model.dart';
import 'package:flutter/material.dart';

class CartVM extends ChangeNotifier {
  final List<Product> _cartItems = [];
  final List<Product> _wishlistItems = [];

  List<Product> get cartItems => _cartItems;
  List<Product> get wishlistItems => _wishlistItems;

  int get totalCartItems => _cartItems.length;
  int get totalWishlistItems => _wishlistItems.length;

  double get totalPrice => _cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

  void addToCart(Product product) {
    final existingProduct = _cartItems.firstWhere(
      (item) => item.name == product.name,
      orElse: () => Product(name: '', description: '', image: '', price: 0.0),
    );

    if (existingProduct.name.isNotEmpty) {
      existingProduct.quantity++;
    } else {
      _cartItems.add(product);
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  void incrementQuantity(Product product) {
    product.quantity++;
    notifyListeners();
  }

  void decrementQuantity(Product product) {
    if (product.quantity > 1) {
      product.quantity--;
      notifyListeners();
    } else {
      removeFromCart(product);
    }
  }

  int getProductQuantity(Product product) {
    // Find the product in the cart
    final existingProduct = _cartItems.firstWhere(
      (item) => item.name == product.name,
      orElse: () => Product(name: '', description: '', image: '', price: 0.0, quantity: 0),
    );

    // Return the quantity if found, otherwise return 0
    return existingProduct?.quantity ?? 0;
  }

  void addToWishlist(Product product) {
    if (!_wishlistItems.any((item) => item.name == product.name)) {
      _wishlistItems.add(product);
      notifyListeners();
    }
  }

  void removeFromWishlist(Product product) {
    _wishlistItems.removeWhere((item) => item.name == product.name);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  void clearWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }
}
