import 'dart:convert';
import 'package:ecommerce/view_model/ProductsModel.dart';
import 'package:flutter/services.dart' show rootBundle;
//import 'products_model.dart';

class ProductService {
  Future<ProductsModel> loadProducts() async {
    String jsonString = await rootBundle.loadString('assets/products.json');
    final jsonResponse = jsonDecode(jsonString);
    return ProductsModel.fromJson(jsonResponse);
  }
}
