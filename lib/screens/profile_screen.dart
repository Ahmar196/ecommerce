

import 'package:ecommerce/screens/navigation_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        title: Text('Profile screen'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
              
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NavigationScreen()), 
              );
            },
      ),
     )
    );
  }
}