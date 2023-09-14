import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Loading...'),
      backgroundColor: Colors.transparent,
      content: SpinKitFadingFour(
        color: Colors.blue,
        size: 50.0,
      ),
    );
  }
}
