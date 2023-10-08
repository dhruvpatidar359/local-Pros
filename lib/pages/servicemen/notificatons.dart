import 'package:flutter/material.dart';
import 'package:localpros/navigation.dart';
import 'package:localpros/wingets/loading.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../database/database_service.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  String email = "";
  List<List<String>> notify = [];
  int count = 0 ;
  DatabaseService databaseService = DatabaseService();
  bool isloading = false;
  late SharedPreferences prefs;
  String orderId = "";

  getNotifications() async {
    prefs = await SharedPreferences.getInstance();
    email = prefs.getString("email")!;
    print(email);
    notify = await databaseService.fetchNotification(email).whenComplete(() {
      setState(() {
        isloading = false;
      });
    });
    for(var x in notify){
      count = count + 1;
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((prefs) => {
      setState(() {
        email = prefs.getString("email") ?? "";
      })
    });
    isloading = true;
    getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return isloading ? Loading()
        : ListView.builder(
      itemCount: count,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GeoCard(
            title: notify[index].elementAt(3),
            address: notify[index].elementAt(5) ,
            price: notify[index].elementAt(4),
            email: email,
            orderId: notify[index].elementAt(0),
          ),
        );
      },
    );
  }
}

class GeoCard extends StatefulWidget {
  const GeoCard({Key? key , required this.title , required this.address , required this.price , required this.orderId, required this.email}) : super(key: key);
  final String title;
  final String address;
  final String price;
  final String email;
  final String orderId;

  @override
  State<GeoCard> createState() => _GeoCardState();
}

class _GeoCardState extends State<GeoCard> {
  @override
  Widget build(BuildContext context) {
    DatabaseService databaseService = DatabaseService();
    return Container(
      height: 200,
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [  Color(0xFF4285F4),  // Lighter shade of blue
              Color(0xFF1C7ED6),  // Medium shade of blue
              Color(0xFF0A5FAB),  // Darker shade of blue
              Color(0xFF003366),],
          ),
          borderRadius: BorderRadius.circular(16)), // Adds a gradient background and rounded corners to the container
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                  Text('${widget.title}',
                      style: TextStyle(color: Colors.white, fontFamily: "monospace" , fontWeight: FontWeight.bold),
                  ), // Adds a title to the card
                  const Spacer(),
                  Stack(
                    children:
                    // List.generate(
                    //   2,
                    //       (index) => Container(
                    //     margin: EdgeInsets.only(left: (15 * index).toDouble()),
                    //     height: 30,
                    //     width: 30,
                    //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white54),
                    //   ),
                    // ),
                    List.generate(
                        1,
                            (index) => Container(
                          margin: EdgeInsets.only(left: (15 * index).toDouble()),
                          height: 30,
                          width: 60,
                          child: Text('₹ ${widget.price}',
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white
                            ),),
                        ),
                      ),
                  ) // Adds a stack of two circular containers to the right of the title
                ],
              ),
              SizedBox(height: 16,),
              Text('Location: ${widget.address}', style: TextStyle(color: Colors.white, fontFamily: "monospace"),
              ) ,// Adds a subtitle to the card
            ],
          ),
          Row(
            children: <Widget>[
              // Add a spacer to push the buttons to the right side of the card
              //const Spacer(),
              // Add a text button labeled "SHARE" with transparent foreground color and an accent color for the text
              Card(
                elevation: 15,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: IconButton(
                      onPressed: () {
                        print("HIIIIIIIIIIIIIIIIII");
                        databaseService.acceptJob(widget.email, widget.orderId);
                        showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.success(
                            message: "Job Accepted",
                          ),
                        );
                        setState(() {

                        });
                      },
                      icon: Icon(
                        Icons.check,
                        size: 30,
                        color: Colors.green,
                      )
                  ),
                ),
              ),
              SizedBox(width: 20,),
              // Add a text button labeled "EXPLORE" with transparent foreground color and an accent color for the text
              Card(
                elevation: 15,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                  ),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.close,
                        size: 30,
                        color: Colors.red,
                      )
                  ),
                ),
              ),
            ],
          ), // Adds a price to the bottom of the card
        ],
      ),
    );
  }
}
