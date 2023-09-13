import 'package:flutter/material.dart';
import 'package:localpros/navigation.dart';
import 'package:localpros/pages/consumer/services/service_list.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../profile/profile_consumer.dart';
import '../servicemen/service_men_list.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({Key? key}) : super(key: key);

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue.shade300,
            title: _currentIndex == 0
                ? Text(
                    'Services',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : _currentIndex == 1
                    ? Text(
                        'Servicemen List',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : _currentIndex == 2
                        ? Text(
                            'Cart',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            'Profile',
                            style: TextStyle(
                              color: Colors.black,
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
                icon: Icon(Icons.miscellaneous_services),
                title: Text("Services"),
                selectedColor: Colors.blue,
              ),

              /// Likes
              SalomonBottomBarItem(
                icon: Icon(Icons.engineering),
                title: Text("Servicemen"),
                selectedColor: Colors.pink,
              ),

              /// Search
              SalomonBottomBarItem(
                icon: Icon(Icons.shopping_cart),
                title: Text("Cart"),
                selectedColor: Colors.orange,
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
                  )),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Ayush Mishra',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'ayush@gmail.com',
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
          body: _currentIndex == 0
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          nextScreen(context, ServiceList());
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/ac.png'),
                                ),
                              ),
                            ),
                            Text(
                              'AC Repair',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/cooler.png'),
                              ),
                            ),
                          ),
                          Text(
                            'Cooler Repair',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/wash.png'),
                              ),
                            ),
                          ),
                          Text(
                            'Appliances',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/socket.png'),
                              ),
                            ),
                          ),
                          Text(
                            'Switch Repair',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/plug.png'),
                              ),
                            ),
                          ),
                          Text(
                            'Electronics',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/wiring.png'),
                              ),
                            ),
                          ),
                          Text(
                            'Wiring Repair',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/pliers.png'),
                              ),
                            ),
                          ),
                          Text(
                            'Connections',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/ac.png'),
                              ),
                            ),
                          ),
                          Text(
                            'AC Repair',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/ac.png'),
                              ),
                            ),
                          ),
                          Text(
                            'AC Repair',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/ac.png'),
                              ),
                            ),
                          ),
                          Text(
                            'AC Repair',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : _currentIndex == 1
                  ? ServiceMenList()
                  : _currentIndex == 2
                      ? Container()
                      : ProfileConsumer(),
        ),
      ),
    );
  }
}