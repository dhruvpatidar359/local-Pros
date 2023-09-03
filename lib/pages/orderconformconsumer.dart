import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class orderconformconsumer extends StatefulWidget {
  const orderconformconsumer({super.key});

  @override
  State<orderconformconsumer> createState() => _orderconformconsumerState();
}

class _orderconformconsumerState extends State<orderconformconsumer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 350,
              width: 350,
              child: Lottie.asset(
                'assets/orderconformtick.json',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:50.0),
              child: Text(
                'Your order has been confirmed!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
