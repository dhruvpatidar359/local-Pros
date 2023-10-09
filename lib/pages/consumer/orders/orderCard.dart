import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../database/database_service.dart';

class OrderCard extends StatefulWidget {
  OrderCard(
      {Key? key,
      required this.title,
      required this.description,
      required this.price,
      required this.servicemen,
      required this.date,
      required this.status})
      : super(key: key);
  final String title;
  final String description;
  final String price;
  String servicemen;
  final String date;
  String status;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  Color color = Colors.blue; // pending color
  DatabaseService databaseService = DatabaseService();

  Future<void> getServicemen() async {
    if (widget.servicemen != "NIL") {
      String name =
          await databaseService.fetchServicemenName(widget.servicemen);
      setState(() {
        widget.servicemen = name;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getServicemen();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.blue.shade200,
      margin: EdgeInsets.all(14),
      child: Wrap(
        // height: 150,
        // color: Colors.blue.shade100,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/ac.png',
                      height: 40,
                      width: 40,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "Description :",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
                Text(
                  widget.description,
                  overflow: TextOverflow.fade,
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "Servicemen Assigned :",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
                Text(widget.servicemen),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "Price :",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(widget.price),
                Text(
                  "Booking Date :",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
                Text(widget.date.split(" ").first),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(width: 10),
                    _buildChip(widget.status, Colors.blue),
                    SizedBox(
                      width: 4,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildChip(String label, Color color) {
  if (label == 'pending') {
    color = Colors.blue;
  } else if (label == 'in progress') {
    color = Colors.greenAccent;
  } else {
    color = Colors.green;
  }

  return Chip(
    labelPadding: EdgeInsets.all(2.0),
    avatar: CircleAvatar(
      backgroundColor: Colors.white,
      child: Text(label[0].toUpperCase()),
    ),
    label: Text(
      label,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: color,
    elevation: 1.0,
    shadowColor: Colors.grey[60],
    padding: EdgeInsets.all(8.0),
  );
}
