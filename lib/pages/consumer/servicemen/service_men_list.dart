import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

import '../../../database/database_service.dart';
import '../../../wingets/loading.dart';
import 'custom_card_servicemenlist.dart';

class ServiceMenList extends StatefulWidget {
  const ServiceMenList({super.key});

  @override
  State<ServiceMenList> createState() => _ServiceMenListState();
}

class _ServiceMenListState extends State<ServiceMenList> {
  late Results result;
  DatabaseService databaseService = DatabaseService();
  bool isready = false;
  int count = 0;
  void getDetails() async {
    result = await databaseService.fetchServicemenData();

    for (var row in result) {
      count++;
    }
    isready = true;
    print(count);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isready ? ListView.builder(
          itemCount: count,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomCard(
                result: result,
                index: index,
              ),
            );
          },
        )
            : Loading(),
      ),
    );
  }
}
