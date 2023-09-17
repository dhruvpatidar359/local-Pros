import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 250,
        width: 250,
        child: Center(
          child: AlertDialog(
            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10) , side: BorderSide(style: BorderStyle.none)),
            title: Text('Loading...'),
            backgroundColor: Colors.white,
            content: SpinKitFadingFour(
              color: Colors.blue,
              size: 50.0,
            ),
          ),
        ),
      ),
    );
  }
}
