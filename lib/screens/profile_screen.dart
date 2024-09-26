import 'package:ecommerce/screens/navigation_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Profile')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
         Navigator.push(context, MaterialPageRoute(builder: (context) =>NavigationScreen()));
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Profile Screen")),
        ],
      ),
    );
  }
}
