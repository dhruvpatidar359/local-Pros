import 'package:flutter/material.dart';
import 'package:localpros/database/connection.dart';
import 'package:localpros/pages/consumer/services/services_page.dart';
import 'package:localpros/pages/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseManager().initialize();
  runApp(MaterialApp(
    home: SafeArea(
      child: Scaffold(
        body: ServicePage(),
      ),
    ),
  ));
}
