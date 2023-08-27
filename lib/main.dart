import 'package:flutter/material.dart';
import 'package:localpros/pages/profile.dart';
import 'package:localpros/pages/splashscreen.dart';
import 'package:localpros/pages/verification_code.dart';

void main() {
  runApp(MaterialApp(
    home: SafeArea(
      child: Scaffold(
        body: Profile(),
      ),
    ),
  ));
}
