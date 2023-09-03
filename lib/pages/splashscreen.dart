import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:localpros/navigation.dart';
import 'package:localpros/pages/signup/signup.dart';

import 'package:lottie/lottie.dart';

class IntroSliderDemo extends StatefulWidget {
  const IntroSliderDemo({Key? key}) : super(key: key);

  @override
  _IntroSliderDemoState createState() => _IntroSliderDemoState();
}

class _IntroSliderDemoState extends State<IntroSliderDemo> {
  List<ContentConfig> slides = [];

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      renderSkipBtn: const Icon(
        Icons.skip_next,
        color: Colors.black,
      ),
      renderNextBtn: const Icon(
        Icons.next_plan,
        color: Colors.black,
      ),
      listContentConfig: slides,
      renderDoneBtn: const Icon(
        Icons.done,
        color: Colors.black,
      ),
      onDonePress: () {
        nextScreenReplace(context, SignUp());
      },
    );
  }

  @override
  void initState() {
    super.initState();
    slides.add(
      ContentConfig(
        centerWidget: Lottie.asset('assets/local.json'),
        widgetTitle: Text(
          "Local Pros At Your Home",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: const Color(0xff000000),
          ),
        ),
        widgetDescription: Column(
          children: [
            Text(
              "Get Local People Near You To Get Your Work Done.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: const Color(0xff000000),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Add your desired action here
                  nextScreenReplace(context, SignUp());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color(0xFF5790DF), // Set the background color to #5790DF
                  // Set the text color to white
                  shadowColor: Colors.black, // Set the shadow color
                  elevation: 8, // Set the shadow elevation
                ),
                child: Text(
                  'Sign up today',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xffE6EEFA),
      ),
    );
    slides.add(
      ContentConfig(
        centerWidget: Lottie.asset('assets/details.json'),
        widgetTitle: Text(
          "Get Details Of ServiceMen Near You",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: const Color(0xff000000),
          ),
        ),
        widgetDescription: Column(
          children: [
            Text(
              "Get In There Contact In just One Sign In , Get All Details Regarding Them",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: const Color(0xff000000),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Start your journey today!',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xffE6EEFA),
      ),
    );
    slides.add(
      ContentConfig(
        centerWidget: Lottie.asset('assets/low_price.json'),
        widgetTitle: Text(
          "Get Services At Reasonable Price ",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: const Color(0xff000000),
          ),
        ),
        widgetDescription: Column(
          children: [
            Text(
              "Get Services In Most Affordable Way , And Tell Others",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: const Color(0xff000000),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                ' Share your friends!',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
        backgroundColor: const Color(0xffE6EEFA),
      ),
    );
  }
}
