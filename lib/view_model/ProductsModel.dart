class ProductsModel {
  final List<String> imageList; // List of images for each product
  final String title;
  final String description;
  final double price;
  final int reviews;

  ProductsModel({
    required this.imageList,
    required this.title,
    required this.description,
    required this.price,
    required this.reviews,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      imageList: List<String>.from(json['imageList']), // Ensure this matches your JSON structure
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      reviews: json['reviews'],
    );
  }
}
