import 'dart:async';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localpros/database/connection.dart';
import 'package:localpros/database/database_service.dart';
import 'package:localpros/navigation.dart';
import 'package:localpros/pages/servicemen/servicemen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../consumer/services/services_page.dart';

class VerificationScreen extends StatefulWidget {
  final String email;
  final String password;
  final String name;
  final String userType;

  VerificationScreen(
      {Key? key,
      required this.email,
      required this.password,
      required this.name,
      required this.userType})
      : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  int _remainingSeconds = 40; // Initial remaining time in seconds
  bool _resendButtonVisible =
      false; // Controls the visibility of the resend button
  Timer? _timer;

  EmailOTP myauth = EmailOTP();
  DatabaseService databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    myauth.setConfig(
        appEmail: "fe1234qwer@gmail.com",
        appName: "localpros",
        userEmail: widget.email,
        otpLength: 5,
        otpType: OTPType.digitsOnly);

    resendOTPFUN();
    startTimer();
  }

  // Function to start the timer
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          // Timer has expired, enable the resend button
          _resendButtonVisible = true;
          _timer?.cancel(); // Cancel the timer
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the screen is disposed
    super.dispose();
  }

  Future<void> resendOTPFUN() async {
    await myauth.sendOTP();
  }

  // Function to handle resending OTP
  void resendOTP() {
    // Implement your OTP resend logic here
    resendOTPFUN();
    // Reset the timer

    setState(() {
      _remainingSeconds = 40;
      _resendButtonVisible = false;
    });

    // Start the timer again
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Verification Code",
              style: GoogleFonts.poppins(
                fontSize: 28,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "We just have sent you a verification code. Please check it in your inbox",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            OtpTextField(
              numberOfFields: 5,
              borderColor: Color(0xFF512DA8),
              //set to true to show as a box or false to show as a dash
              showFieldAsBox: true,
              //runs when a code is typed in

              onSubmit: (String code) async {
                final isVer = await myauth.verifyOTP(otp: code);

                if (isVer == true) {
                  databaseService.registerUser(
                    widget.email,
                    widget.password,
                    widget.userType,
                    widget.name,
                  );

                  if (widget.userType == "consumer")
                    nextScreenReplace(context, ServicePage());
                  else {
                    nextScreenReplace(context, ServiceMen());
                  }
                } else {
                  showTopSnackBar(
                    Overlay.of(context),
                    CustomSnackBar.error(
                      message: "Wrong OTP",
                    ),
                  );
                }
              },
              //runs when every textfield is filled
            ),
            SizedBox(
              height: 20,
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     // Handle the continue button press
            //     // You can navigate to the next screen or perform other actions here
            //     // For demonstration purposes, it's navigating to ServicePage
            //     Navigator.of(context).pushReplacement(
            //       MaterialPageRoute(
            //         builder: (context) => ServicePage(),
            //       ),
            //     );
            //   },
            //   child: Container(
            //     decoration: ShapeDecoration(
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(5),
            //       ),
            //     ),
            //     child: Text("Continue"),
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _resendButtonVisible ? resendOTP : null,
              child: Container(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text("Resend OTP"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Re-send Code in 00:$_remainingSeconds"),
          ],
        ),
      ),
    );
  }
}
