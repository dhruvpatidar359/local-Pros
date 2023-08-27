import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_avatar/random_avatar.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                RandomAvatar('saytoonz', height: 70, width: 70),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("John Doe",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Text("JhonDoe@gmail.com",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                )
              ],
            ),
            profile_item()
          ],
        ),
      ),
    );
  }
}

Widget profile_item() {
  return Container(
    child: Column(
      children: [
        Text("Phone Number",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            )),
        // Note: Same code is applied for the TextFormField as well
      ],
    ),
  );
}
