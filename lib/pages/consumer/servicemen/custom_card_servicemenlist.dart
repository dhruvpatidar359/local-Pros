import 'package:flutter/material.dart';
import 'package:localpros/navigation.dart';
import 'package:localpros/pages/consumer/servicemen/servicemen_details.dart';

class CustomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nextScreen(context, ServiceMenDetails());
      },
      child: Card(
        elevation: 4, // Controls the shadow intensity
        shadowColor: Colors.lightBlue[100], // Light blue shadow color
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey, // Placeholder color
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/man.png')
                    )
                  ),
                ), // Replace with your photo
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ayush Mishra', // Replace with person's name
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Service: Electrician', // Replace with person's service
                  ),
                  SizedBox(height: 8),
                  Chip(
                    label: Text('Available'), // Replace with availability status
                    backgroundColor: Colors.green,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}