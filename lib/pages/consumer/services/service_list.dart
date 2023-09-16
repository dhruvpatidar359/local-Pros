import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

import '../../../database/database_service.dart';

class ServiceList extends StatefulWidget {
  const ServiceList({Key? key , required this.serviceId}) : super(key: key);
  final int serviceId;

  @override
  State<ServiceList> createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  late Results result;
  DatabaseService databaseService = DatabaseService();
  int count = 0;
  void getData() async {
    result = await databaseService.fetchSubServiceData(widget.serviceId);

    for (var row in result) {
      count++;
    }
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: count,
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
  const GeoCard({Key? key ,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: ListTile(
        leading: Image.asset('assets/images/ac.png'),
        title: Text(''),
        subtitle: Text('Description of Product 1'),
        trailing: Text('\$10.00'),
      ),
    );
  }
}
