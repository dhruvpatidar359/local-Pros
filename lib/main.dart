import 'package:flutter/material.dart';
import 'package:localpros/pages/profile_consumer.dart';
import 'package:localpros/pages/service_men_list.dart';
import 'package:localpros/pages/servicemen.dart';
import 'package:localpros/pages/services_page.dart';
import 'package:localpros/pages/signup.dart';
import 'package:localpros/pages/splashscreen.dart';
import 'package:localpros/pages/orderconformconsumer.dart';

void main() {
  runApp(MaterialApp(
    home: SafeArea(
      child: Scaffold(
        body: orderconformconsumer(),
      ),
    ),
  ));
}
