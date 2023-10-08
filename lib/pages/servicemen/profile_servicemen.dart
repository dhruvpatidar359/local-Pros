import 'package:flutter/material.dart';
import 'package:localpros/database/database_service.dart';
import 'package:localpros/navigation.dart';
import 'package:localpros/pages/consumer/orders/orderCompleted.dart';
import 'package:localpros/pages/servicemen/edit_servicemen_details.dart';
import 'package:localpros/pages/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'orderCompleted_servicemen.dart';


class ProfileServicemen extends StatefulWidget {
  @override
  State<ProfileServicemen> createState() => _ProfileServicemenState();
}

class _ProfileServicemenState extends State<ProfileServicemen> {
  DatabaseService databaseService = DatabaseService();

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
          body: Container(
            color: Colors.white54,
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                // const ListTile(
                //   leading: Icon(Icons.arrow_back),
                //   trailing: Icon(Icons.menu),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      maxRadius: 70,
                      backgroundImage: AssetImage("assets/images/man.png"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style:
                      TextStyle(fontWeight: FontWeight.w900, fontSize: 26),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(email)],
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  child: Expanded(
                      child: ListView(
                        padding: EdgeInsets.only(top: 10),
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              nextScreen(context, OrderCompeletedServicemen());
                            },
                            child: Card(
                              color: Colors.white70,
                              margin: const EdgeInsets.only(
                                  left: 35, right: 35, bottom: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: const ListTile(
                                leading: Icon(
                                  Icons.history,
                                  color: Colors.black54,
                                ),
                                title: Text(
                                  'Order Completed',
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Card(
                            color: Colors.white70,
                            margin: const EdgeInsets.only(
                                left: 35, right: 35, bottom: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: const ListTile(
                              leading:
                              Icon(Icons.help_outline, color: Colors.black54),
                              title: Text(
                                'Help & Support',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Card(
                            color: Colors.white70,
                            margin: const EdgeInsets.only(
                                left: 35, right: 35, bottom: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: GestureDetector(
                              onTap: () async {
                                final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                                String getPerson = prefs.getString('person') ?? '';
                                  nextScreen(context, EditProfilePageServiceMen());
                              },
                              child: const ListTile(
                                leading: Icon(
                                  Icons.edit_note,
                                  color: Colors.black54,
                                ),
                                title: Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                trailing: Icon(Icons.arrow_forward_ios_outlined),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Card(
                              color: Colors.white70,
                              margin: const EdgeInsets.only(
                                  left: 35, right: 35, bottom: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: const ListTile(
                                leading: Icon(
                                  Icons.add_reaction_sharp,
                                  color: Colors.black54,
                                ),
                                title: Text(
                                  'Invite a Friend',
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Logout Confirmation'),
                                    content: Text('You are about to logout.'),
                                    actions: <Widget>[
                                      // Cancel button
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      // Logout button
                                      TextButton(
                                        onPressed: () {
                                          // Add your logout logic here
                                          databaseService.logout();
                                          Navigator.of(context).pop();
                                          nextScreenReplace(context,
                                              LoginPage()); // Close the dialog
                                        },
                                        child: Text('Logout'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Card(
                              color: Colors.white70,
                              margin: const EdgeInsets.only(
                                  left: 35, right: 35, bottom: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: const ListTile(
                                leading: Icon(
                                  Icons.logout,
                                  color: Colors.black54,
                                ),
                                title: Text(
                                  'Logout',
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                trailing: Icon(Icons.arrow_forward_ios_outlined),
                              ),
                            ),
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
        ));
  }
}
