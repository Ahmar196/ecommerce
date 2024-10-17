import 'dart:convert'; // For Base64 encoding/decoding
import 'dart:io';

import 'package:ecommerce/screens/confirm_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

// Review Popup Screen
class ReviewPopup extends StatefulWidget {
  @override
  _ReviewPopupState createState() => _ReviewPopupState();
}

class _ReviewPopupState extends State<ReviewPopup> {
  double _rating = 0.0; // Variable to hold rating value
  final TextEditingController _reviewController = TextEditingController(); // Controller for review input
  File? _image; // Variable to hold the selected image
  final ImagePicker _picker = ImagePicker(); // Create an ImagePicker instance
  Image? _loadedImage; // Variable to hold the loaded image from SharedPreferences

  // Method to get the image from the gallery
  Future<void> getImage() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery); // Pick image from gallery
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path); // Set the selected image
      });

      // Convert the image to a Base64 string
      List<int> imageBytes = await _image!.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      // Save the image in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userImage', base64Image); // Save the Base64 image string
    } else {
      print("No image selected");
    }
  }

  // Method to load the image from SharedPreferences
  Future<void> _loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? base64Image = prefs.getString('userImage'); // Retrieve the Base64 image string

    if (base64Image != null) {
      setState(() {
        // Decode the Base64 string back to bytes
        Uint8List imageBytes = base64Decode(base64Image);
        // Display the image using Image.memory
        _loadedImage = Image.memory(imageBytes, width: 80, height: 80, fit: BoxFit.cover);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadImage(); // Load the saved image when the screen is loaded
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the dialog height adjust to content
        children: [
          Text(
            'What is your rating?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 15),
          // Rating bar
          RatingBar.builder(
            initialRating: _rating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                _rating = rating; // Update rating when user selects it
              });
            },
          ),
          SizedBox(height: 20),
          Text(
            'Please share your opinion about the product',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 15),
          // Text field for review input
          TextField(
            controller: _reviewController,
            decoration: InputDecoration(
              hintText: 'Your review',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            maxLines: 3,
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              getImage(); // Call the method to get image
            },
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.camera_alt, color: Colors.red, size: 40),
                ),
                SizedBox(height: 10),
                Text(
                  "Add your photos",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          // Display the selected image if available
          if (_image != null)
            Image.file(
              _image!,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          // Display the loaded image from SharedPreferences if available
          if (_loadedImage != null)
            _loadedImage!,
          SizedBox(height: 20),
          // Submit button
          ElevatedButton(
            onPressed: () async {
              // Handle review submission
              String review = _reviewController.text;
              print('Review: $review, Rating: $_rating');

              // Save rating and review using SharedPreferences
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setDouble('userRating', _rating); // Save rating
              await prefs.setString('userReview', review); // Save review

              // Image is already saved in SharedPreferences when selected
              // Navigate to ConfirmOrder
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ConfirmOrder(),
                ),
              );
            },
            child: Text("Submit"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFDB3022),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Function to open the modal bottom sheet
void showReviewModalSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.all(16.0),
        child: ReviewPopup(),
      );
    },
  );
}
