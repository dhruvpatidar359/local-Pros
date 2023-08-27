import 'package:flutter/material.dart';
import 'package:localpros/pages/signup.dart';

void main() {
  runApp(MaterialApp(
    home: SafeArea(
      child: Scaffold(
        body: SignUp(),
      ),
    ),
  ));
}
