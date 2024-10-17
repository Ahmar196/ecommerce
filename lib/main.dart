import 'package:ecommerce/screens/navigation_screen.dart';
import 'package:ecommerce/screens/order_details.dart';

import 'package:ecommerce/view_model/FavoritesVM.dart';
import 'package:ecommerce/view_model/order.dart';
import 'package:ecommerce/view_model/view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import the provider package

void main() {
  runApp(
    MultiProvider(
      // Ensure MultiProvider is defined
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                CartVM()), // Ensure ChangeNotifierProvider is defined
        ChangeNotifierProvider(create: (_) => FavoritesVM()),
        ChangeNotifierProvider(create: (_) => OrderVM()),
        ChangeNotifierProvider(create: (context) => OrderVM()),
      ],
      child: MyApp(),
    ),
  );
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:NavigationScreen());
  }
}
