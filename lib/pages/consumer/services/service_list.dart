import 'package:flutter/material.dart';

class ServiceList extends StatefulWidget {
  const ServiceList({Key? key}) : super(key: key);

  @override
  State<ServiceList> createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GeoCard(),
          );
        },
      ),
    );
  }
}

class GeoCard extends StatelessWidget {
  const GeoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.blue.shade50,
      shadowColor: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Deep clean AC split',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Ratings :',
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Price: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Description:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '* Get 2X deeper dust removal with \nfoamjet technology',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                Text(
                  '* Get 2X deeper dust removal with \nfoamjet technology',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 5,
            ),
            // Container(
            //   height: 100,
            //   width: 100,
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage("assets/images/ac_2.webp"),
            //     ),
            //     borderRadius: BorderRadius.circular(15),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
