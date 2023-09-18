import 'package:flutter/material.dart';
import 'package:localpros/navigation.dart';
import 'package:localpros/pages/servicemen/notification_information.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GeoCard(),
        );
      },
    );
  }
}

class GeoCard extends StatelessWidget {
  const GeoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            onTap: () {
              nextScreen(context, NotificationInformation());
            },
            focusColor: Colors.red,
            hoverColor: Colors.red,
            splashColor: Colors.red,
            leading: Image.asset('assets/images/ac_2.webp'),
            title: Text(
              'Deep AC Clean',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            subtitle: Text('Price:'),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Time Slot:',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 3,),
                Container(
                  // height: 25,
                  // width: 100,
                  child: Text('6pm - 7pm'),
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), side: BorderSide(color: Colors.blue, strokeAlign:12),
            ),
          ),

        ],
      ),
    );
  }
}