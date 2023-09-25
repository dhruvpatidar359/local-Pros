import 'package:email_otp/email_otp.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localpros/database/connection.dart';
import 'package:localpros/database/database_service.dart';
import 'package:localpros/navigation.dart';
import 'package:localpros/pages/signup/verification_code.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../login/login.dart';
import '../servicemen/servicemen.dart';
import 'email_verification.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.blue[900]!,
          Colors.blue[800]!,
          Colors.blue[400]!
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign Up",
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Welcome",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(225, 95, 27, .3),
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]!))),
                                child: TextField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                      hintText: "Email or Phone number",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]!))),
                                child: TextField(
                                  obscureText: true,
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]!))),
                                child: TextField(
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                      hintText: "Name",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.orange.shade50,
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircularProgressIndicator(
                                          color: Colors.orange[900]!,
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: GestureDetector(
                            onTap: () {
                              // if (_emailController.text.contains(".com")) {
                              //   nextScreenReplace(
                              //       context, EmailVerificationScreen());
                              // } else {
                              //   nextScreenReplace(
                              //       context, VerificationScreen());
                              // }

                              final emailVal = EmailValidator.validate(
                                  _emailController.text);

                              if (emailVal == false) {
                                showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.error(
                                    message:
                                        "Please enter correct email address",
                                  ),
                                );
                              } else {
                                // myauth.setConfig(
                                //     appEmail: "fe1234qwer@gmail.com",
                                //     appName: "localpros",
                                //     userEmail: _emailController.text,
                                //     otpLength: 6,
                                //     otpType: OTPType.digitsOnly
                                // );

                                nextScreenReplace(
                                    context,
                                    VerificationScreen(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      name: _nameController.text,
                                      userType: "consumer",
                                    ));

                                //
                                // databaseService.registerUser(
                                //   _emailController.text,
                                //   _passwordController.text,
                                //   "consumer",
                                //   _nameController.text,
                                // );
                              }
                            },
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.blue[900]),
                              child: Center(
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            final emailVal =
                                EmailValidator.validate(_emailController.text);

                            if (emailVal == false) {
                              showTopSnackBar(
                                Overlay.of(context),
                                CustomSnackBar.error(
                                  message: "Please enter correct email address",
                                ),
                              );
                            } else {
                              // myauth.setConfig(
                              //     appEmail: "fe1234qwer@gmail.com",
                              //     appName: "localpros",
                              //     userEmail: _emailController.text,
                              //     otpLength: 6,
                              //     otpType: OTPType.digitsOnly
                              // );

                              nextScreenReplace(
                                  context,
                                  VerificationScreen(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    name: _nameController.text,
                                    userType: "serviceman",
                                  ));

                              //
                              // databaseService.registerUser(
                              //   _emailController.text,
                              //   _passwordController.text,
                              //   "consumer",
                              //   _nameController.text,
                              // );
                            }
                          },
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.blue[900]),
                            child: Center(
                              child: Text(
                                "Sign Up As Servicemen",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          "Other Options",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.blue),
                                child: Center(
                                  child: Text(
                                    "Google",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )),
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  nextScreenReplace(context, LoginPage());
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.black),
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
