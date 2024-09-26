import 'package:flutter/material.dart';

class ContainerWidgetModel extends StatelessWidget {
  final Color? bgcolor;
  final double containerWidth; // Changed to lowercase
  final String itext;

  // Constructor to initialize the fields
  const ContainerWidgetModel({
    Key? key,
    this.bgcolor, // Optional color
    required this.containerWidth, // Required width
    required this.itext, // Required text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: containerWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: bgcolor ?? Colors.blue, // Provide a default color if bgcolor is null
      ),
      child: Center(
        child: Text(
          itext,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
