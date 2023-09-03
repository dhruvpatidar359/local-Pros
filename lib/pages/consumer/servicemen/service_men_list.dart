import 'package:flutter/material.dart';

class ServiceMenList extends StatefulWidget {
  const ServiceMenList({super.key});

  @override
  State<ServiceMenList> createState() => _ServiceMenListState();
}

class _ServiceMenListState extends State<ServiceMenList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomCard(),
          );
        },
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
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
              child: Icon(Icons.person), // Replace with your photo
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Doe', // Replace with person's name
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
    );
  }
}
