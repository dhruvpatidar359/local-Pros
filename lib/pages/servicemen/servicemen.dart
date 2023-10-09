import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localpros/navigation.dart';
import 'package:localpros/pages/consumer/profile/profile.dart';
import 'package:localpros/pages/servicemen/notificatons.dart';
import 'package:localpros/pages/servicemen/profile_servicemen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceMen extends StatefulWidget {
  const ServiceMen({Key? key}) : super(key: key);

  @override
  State<ServiceMen> createState() => _ServiceMenState();
}

class _ServiceMenState extends State<ServiceMen> {
  var _currentIndex = 0;
  String name = "";
  String email = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((prefs) => {
          setState(() {
            name = prefs.getString("name") ?? "";
            email = prefs.getString("email") ?? "";
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade300,
          title: _currentIndex == 0
              ? Text(
                  'Notifications',
                  style: GoogleFonts.lora(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : Text(
                  'Profile',
                  style: GoogleFonts.lora(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          centerTitle: true,
        ),
        bottomNavigationBar: SalomonBottomBar(
          backgroundColor: Colors.grey.shade100,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          currentIndex: _currentIndex,
          onTap: (i) => setState(() {
            _currentIndex = i;
            // if(_currentIndex == 1){
            //   nextScreen(context, ServiceMenList());
            // }
          }),
          items: [
            /// Service Page
            SalomonBottomBarItem(
              icon: Icon(Icons.notifications),
              title: Text("Notifications"),
              selectedColor: Colors.blue,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
              selectedColor: Colors.blue,
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: Colors.blue.shade400,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 50),
            children: <Widget>[
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/man.png'),
                )),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                email,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onTap: () {},
                  selectedColor: Colors.white,
                  selected: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  leading: Icon(Icons.share),
                  title: Text(
                    'Share with friends',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onTap: () {},
                  selectedColor: Colors.white,
                  selected: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  leading: Icon(Icons.location_on),
                  title: Text(
                    'Address',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onTap: () {},
                  selectedColor: Colors.white,
                  selected: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  leading: Icon(Icons.notification_important),
                  title: Text(
                    'Notifications',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: _currentIndex == 0
              ? Notifications()
              : Container(
                  child: ProfileServicemen(),
                ),
        ),
      ),
    );
  }
}
