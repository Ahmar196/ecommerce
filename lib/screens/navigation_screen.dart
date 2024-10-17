import 'package:ecommerce/screens/cart_screen.dart';
import 'package:ecommerce/screens/dashboard.dart';
import 'package:ecommerce/screens/favorites.dart';
import 'package:ecommerce/screens/orderlist.dart';
import 'package:ecommerce/screens/profile_screen.dart';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/view_model/FavoritesVM.dart';
import 'package:ecommerce/view_model/view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int pageIndex = 0;

  List<Widget> pages = [
    HomeScreen(),
    CartScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: pages,
      ),
      floatingActionButton: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // border: Border.all(color: Color(0xffdb3022), width: 3), // Circular border
          ),
          child: FloatingActionButton(
            onPressed: () {
              // Navigate to Order List Screen when the FAB is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Dashboard()), // Replace with your Order List Screen
              );
            },
            child: Icon(
              Icons.qr_code,
              size: 20,
            ),
            backgroundColor: Color(0xffdb3022), // Background color for the FAB
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Consumer<FavoritesVM>(
        builder: (context, favoritesVM, child) {
          return BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Home Icon
                IconButton(
                  icon: Icon(
                    CupertinoIcons.home,
                    color: pageIndex == 0 ? Color(0xFFDB3022) : Colors.black, // Change color based on selection
                  ),
                  onPressed: () {
                    setState(() {
                      pageIndex = 0;
                    });
                  },
                ),
                // Cart Icon with Count
                Stack(
                  children: [
                    IconButton(
                      icon: Icon(
                        CupertinoIcons.cart,
                        color: pageIndex == 1 ? Color(0xFFDB3022) : Colors.black, // Change color based on selection
                      ),
                      onPressed: () {
                        setState(() {
                          pageIndex = 1;
                        });
                      },
                    ),
                    Consumer<CartVM>(
                      builder: (context, cartVM, child) {
                        return Positioned(
                          right: 8,
                          top: 8,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.red,
                            child: Text(
                              '${cartVM.totalCartItems}', // Display cart item count
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                // Favorites Icon with Count
                Stack(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: pageIndex == 2 ? Color(0xFFDB3022) : Colors.black, // Change color based on selection
                      ),
                      onPressed: () {
                        setState(() {
                          pageIndex = 2;
                        });
                      },
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Text(
                          '${favoritesVM.favoritesCount}', // Display favorite count
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                // Profile Icon
                IconButton(
                  icon: Icon(
                    CupertinoIcons.profile_circled,
                    color: pageIndex == 3 ? Color(0xFFDB3022) : Colors.black, // Change color based on selection
                  ),
                  onPressed: () {
                    setState(() {
                      pageIndex = 3; // Update the index to navigate to the ProfileScreen
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
