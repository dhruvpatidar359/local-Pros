import 'dart:math';

import 'package:flutter/material.dart';
import 'package:localpros/database/connection.dart';
import 'package:localpros/database/database_service.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
// import 'package:settings_ui/pages/settings.dart';

class EditProfilePageServiceMen extends StatefulWidget {
  @override
  _EditProfilePageServiceMenState createState() =>
      _EditProfilePageServiceMenState();
}

class _EditProfilePageServiceMenState extends State<EditProfilePageServiceMen> {
  bool showPassword = false;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController availableController = TextEditingController();

  DatabaseService databaseService = DatabaseService();
  late SharedPreferences prefs;
  late Results result;

  void getDetails() async {
    prefs = await SharedPreferences.getInstance();
    result = await databaseService.fetchProfile(
        prefs.getString("email")!, "servicemen");

    setState(() {
      fullNameController.text = result.first.values![3].toString();
      emailController.text = result.first.values![0].toString();
      passwordController.text = result.first.values![6].toString();
      locationController.text = result.first.values![1].toString();
      dateOfBirth.text = result.first.values![2].toString().split(" ")[0];
      contactController.text = result.first.values![5].toString();
      experienceController.text = result.first.values![7].toString();
      availableController.text = result.first.values![8].toString();

      String gender = result.first.values![4].toString();
      if (gender != "null") {
        genderController.text =
            result.first.values![4].toString() == "m" ? "Male" : "Female";
      } else {
        genderController.text = result.first.values![4].toString();
      }
    });

    // print(result.first.values?[0]);
  }

  void setDetails() {
    String gender = "";
    String? date = "";
    if (dateOfBirth.text == 'null') {
      if ((genderController.text == "Male" ||
          genderController.text == "male" ||
          genderController.text == "female" ||
          genderController.text == "Female" ||
          genderController.text == "null")) {
        gender = genderController.text;
        if (gender != "null") {
          if (gender == "Male" || gender == 'male') {
            gender = 'm';
          } else {
            gender = 'f';
          }
        } else {
          gender = "n";
        }
      }
      date = null;
    } else {
      final dob = dateOfBirth.text.split("-");
      if (dob[0].length == 4 &&
          dob[1].length == 2 &&
          dob[2].length == 2 &&
          (genderController.text == "Male" ||
              genderController.text == "male" ||
              genderController.text == "female" ||
              genderController.text == "Female" ||
              genderController.text == "null")) {
        gender = genderController.text;
        if (gender != "null") {
          if (gender == "Male" || gender == 'male') {
            gender = 'm';
          } else {
            gender = 'f';
          }
        } else {
          gender = "n";
        }
      } else {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: "Enter Correct Format YYYY-MM-DD",
          ),
        );
      }
    }
    databaseService.setDetails(
        prefs.getString("email")!,
        "servicemen",
        fullNameController.text,
        passwordController.text,
        dateOfBirth.text,
        locationController.text,
        gender,
        contactController.text,
        experienceController.text,
        availableController.text);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.blue,
            ),
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => SettingsPage()));
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/man.png'))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.blue,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              TextField(
                controller: fullNameController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusColor: Colors.blue,
                  labelText: "Full Name",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                enabled: false,
                controller: emailController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusColor: Colors.blue,
                  labelText: "E-mail",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: contactController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusColor: Colors.blue,
                  labelText: "Contacts",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: experienceController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusColor: Colors.blue,
                  labelText: "Experience",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: availableController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusColor: Colors.blue,
                  labelText: "Availablity",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusColor: Colors.blue,
                  labelText: "Password",
                ),
                obscureText: showPassword,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: genderController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusColor: Colors.blue,
                  labelText: "Gender(Male/Female)",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: dateOfBirth,
                onTap: () async {
                  // DateTime? date = await showDatePicker(
                  //   context: context,
                  //   initialDate: DateTime.now(),
                  //   firstDate: DateTime(1900),
                  //   lastDate: DateTime(2100),
                  // );
                  // if (date == null) return;
                  // setState(() {
                  //   dateOfBirth = date as TextEditingController;
                  // });
                },
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusColor: Colors.blue,
                  labelText: "D.O.B(YYYY-MM-DD)",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: locationController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusColor: Colors.blue,
                  labelText: "Location",
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 50)),
                    ),
                    onPressed: () {},
                    child: Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setDetails();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.blue),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                      elevation: MaterialStatePropertyAll(2),
                    ),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
