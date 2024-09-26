import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/screens/navigation_screen.dart';
import 'package:ecommerce/widget/container_widget_model.dart';
import 'package:flutter/material.dart';

class ConfirmOrder extends StatelessWidget {
  const ConfirmOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Green Checkmark Icon
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 200,
                ),
                SizedBox(height: 20),
                
                // Success Message
                Text(
                  'Success!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                
                // Description Text
                Text(
                  'Your order will be delivered soon.\nThank You! for choosing our app.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
               
                SizedBox(
                    height: 20,),
                     Flexible(
                       child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>NavigationScreen()));
                        },
                        child: ContainerWidgetModel(
                          containerWidth: MediaQuery.of(context).size.width,
                          itext: "Continue Shopping",
                          bgcolor: Color(0xFFDB3022),
                        ),
                                           ),
                     ),
               
                
              ],
            ),
          ),
        ),
      
    );
  }
}