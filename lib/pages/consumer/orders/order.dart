import 'package:flutter/material.dart';
import 'package:localpros/database/database_service.dart';
import 'package:localpros/pages/consumer/orders/orderCard.dart';
import 'package:localpros/wingets/loading.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  late Map<ResultRow, Results> result;
  late List<ResultRow> resultRow;
  late List<Results> resultR;
  String email = "";
  String name = "";
  bool isready = false;
  DatabaseService databaseService = DatabaseService();

  void getData() async {
    result = await databaseService.fetchOrders(email, "pending|in progress");
    resultRow = result.keys.toList();
    resultR = result.values.toList();

    setState(() {
      isready = true;
    });
    print(resultRow);
    print(resultR);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((prefs) => {
          setState(() {
            email = prefs.getString("email") ?? "";
            name = prefs.getString('name') ?? "";

            getData();
          })
        });
    print(email);
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Orders",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.blue.shade300,
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: isready
            ? ListView.builder(
                itemCount: resultR.length,
                itemBuilder: (context, index) {
                  String title =
                      resultR.elementAt(index).first.values![0].toString();
                  String description =
                      resultR.elementAt(index).first.values![1].toString();
                  String price =
                      resultR.elementAt(index).first.values![2].toString();

                  String status =
                      resultRow.elementAt(index).values![2].toString();
                  print(status);
                  String servicemen =
                      resultRow.elementAt(index).values![4].toString() == ""
                          ? "NIL"
                          : resultRow.elementAt(index).values![4].toString();

                  String date =
                      resultRow.elementAt(index).values![3].toString();
                  return OrderCard(
                    title: title,
                    description: description,
                    price: price,
                    status: status,
                    servicemen: servicemen,
                    date: date,
                  );
                },
              )
            : Loading());
  }
}
