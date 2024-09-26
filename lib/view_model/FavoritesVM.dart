import 'package:flutter/material.dart';

class FavoritesVM extends ChangeNotifier {
  List<int> _favoriteIndexes = [];

  // A method to toggle favorite status
  void toggleFavorite(int index) {
    if (_favoriteIndexes.contains(index)) {
      _favoriteIndexes.remove(index);
    } else {
      _favoriteIndexes.add(index);
    }
    notifyListeners();
  }

  // A method to check if a specific index is a favorite
  bool isFavorite(int index) {
    return _favoriteIndexes.contains(index);
  }

  // Getter for the count of favorites
  int get favoritesCount => _favoriteIndexes.length;

  // Getter for the list of favorite items
  List<int> get favoriteItems => _favoriteIndexes; // Add this line
}
