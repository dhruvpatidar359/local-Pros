import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localpros/navigation.dart';
import 'package:localpros/pages/service_list.dart';
import 'package:localpros/pages/service_men_list.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class ServiceMen extends StatefulWidget {
  const ServiceMen({Key? key}) : super(key: key);

  @override
  State<ServiceMen> createState() => _ServiceMenState();
}

class _ServiceMenState extends State<ServiceMen> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue.shade300,
            title: _currentIndex == 0 ?
            Text(
              'Notifications',
              style: GoogleFonts.lora(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ) :
            Text(
              'Profile',
              style: GoogleFonts.lora(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ) ,
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
                selectedColor: Colors.teal,
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
                      )
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Jane Doe',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'janedoe@gmail.com',
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
          body: Container(),
        ),
      ),
    );
  }
}
