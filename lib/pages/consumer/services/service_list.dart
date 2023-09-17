import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

import '../../../database/database_service.dart';
import '../../../wingets/loading.dart';

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
  bool isready = false;
  void getData() async {
    result = await databaseService.fetchSubServiceData(widget.serviceId);

    for (var row in result) {
      count++;
    }
    isready = true;
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
      body: isready ? ListView.builder(
        itemCount: count,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GeoCard(
                title: result.elementAt(index).values![1].toString(),
                description: result.elementAt(index).values![2].toString(),
                price: result.elementAt(index).values![3].toString()
            ),
          );
        },
      )
          : Loading(),
    );
  }
}

class GeoCard extends StatelessWidget {
  const GeoCard({Key? key ,required this.title , required this.description , required this.price}) : super(key: key);
  final String title;
  final String description;
  final String price;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: ListTile(
        leading: Image.asset('assets/images/ac.png'),
        title: Text(
            title,
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Text(description),
        trailing: Text(
            '₹'+price,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), side: BorderSide(color: Colors.blue, strokeAlign:12),
        ),
      ),
    );
  }
}
