import 'package:flutter/material.dart';
import 'package:localpros/database/connection.dart';
import 'package:localpros/pages/consumer/services/services_page.dart';

import 'package:localpros/pages/servicemen/servicemen.dart';

import 'package:localpros/pages/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseManager().initialize();

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
  String getPerson = prefs.getString('person') ?? '';

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SafeArea(
      child: Scaffold(
          body: isLoggedIn == true
              ? getPerson == 'consumer'
                  ? ServicePage()
                  : ServiceMen()
              : IntroSliderDemo()),
    ),
  ));
}
