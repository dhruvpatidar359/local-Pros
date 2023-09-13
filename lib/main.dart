import 'package:flutter/material.dart';
import 'package:localpros/database/connection.dart';
import 'package:localpros/pages/consumer/services/services_page.dart';
import 'package:localpros/pages/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseManager().initialize();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('email', '');

  runApp(MaterialApp(
    home: SafeArea(
      child: Scaffold(
        body: ServicePage(),
      ),
    ),
  ));
}
