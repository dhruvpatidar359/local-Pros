import 'package:flutter/material.dart';
import 'package:localpros/navigation.dart';
import 'package:localpros/pages/consumer/servicemen/servicemen_details.dart';
import 'package:mysql1/mysql1.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, required this.result, required this.index})
      : super(key: key);
  final Results result;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nextScreen(
            context,
            ServiceMenDetails(
              index: index,
              result: result,
            ));
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
                          image: AssetImage('assets/images/man.png'))),
                ), // Replace with your photo
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result
                        .elementAt(index)
                        .values![0]
                        .toString(), // Replace with person's name
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Service: Electrician', // Replace with person's service
                  ),
                  Row(children: [
                    Text('Availablity'),
                    SizedBox(width: 4),
                    Chip(
                      label: Text(result
                          .elementAt(index)
                          .values![8]
                          .toString()), // Replace with availability status
                      backgroundColor: Colors.green,
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ])
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
