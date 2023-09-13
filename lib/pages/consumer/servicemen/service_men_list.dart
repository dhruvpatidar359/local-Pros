import 'package:flutter/material.dart';

import 'custom_card_servicemenlist.dart';

class ServiceMenList extends StatefulWidget {
  const ServiceMenList({super.key});

  @override
  State<ServiceMenList> createState() => _ServiceMenListState();
}

class _ServiceMenListState extends State<ServiceMenList> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomCard(),
          );
        },
      ),
    );
  }
}
