import 'package:ecommerce/view_model/FavoritesVM.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesVM>().favoriteItems;

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Items (${favorites.length})'),
      ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final productIndex = favorites[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0), // Add vertical padding
            child: ListTile(
              leading: Image.asset('assets/images/image${productIndex + 1}.jpg'),
              title: Text('Product ${productIndex + 1}'),
              trailing: IconButton(
                icon: Icon(Icons.favorite, color: Colors.red),
                onPressed: () {
                  context.read<FavoritesVM>().toggleFavorite(productIndex);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
