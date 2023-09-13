import 'package:flutter/material.dart';
import 'package:localpros/navigation.dart';

import 'edit_consumer_details.dart';

class ProfileConsumer extends StatelessWidget {
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
                  children: const [
                    Text(
                      "Ayush Mishra",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 26),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [Text("@peakyBlinders")],
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
                      Card(
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
                            'Purchase History',
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
                          onTap: () {
                            nextScreen(context, EditProfilePageConsumer());
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
                      Card(
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
