// model/product.dart

class Product {
  String name;
  String description;
  String image;
  double price;
  int quantity;
  bool isSelected; // Property for selection state

  Product({
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    this.quantity = 1, // Default quantity is 1
    this.isSelected = false, // Default value for isSelected
  });
}
