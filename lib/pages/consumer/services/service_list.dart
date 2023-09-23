import 'package:flutter/material.dart';
import 'package:localpros/navigation.dart';
import 'package:localpros/pages/consumer/services/search_result.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../database/database_service.dart';
import '../../../wingets/loading.dart';

class ServiceList extends StatefulWidget {
  const ServiceList({Key? key, required this.serviceId}) : super(key: key);
  final int serviceId;

  @override
  State<ServiceList> createState() => _ServiceListState();
}

TextEditingController searchEditingController = TextEditingController();

class _ServiceListState extends State<ServiceList> {
  late Results result;
  DatabaseService databaseService = DatabaseService();
  int count = 0;
  bool isready = false;
  bool searchBoolean = false;
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
      appBar: AppBar(
        title: !searchBoolean
            ? Text(
                'Select Service',
                style: TextStyle(
                  fontSize: 18,
                ),
              )
            : searchTextField(context),
        actions: !searchBoolean
            ? [
                IconButton(
                  onPressed: () {
                    setState(() {
                      searchBoolean = true;
                    });
                  },
                  icon: Icon(Icons.search),
                ),
              ]
            : [
                IconButton(
                  onPressed: () {
                    setState(() {
                      searchBoolean = false;
                    });
                  },
                  icon: Icon(Icons.clear),
                ),
              ],
        centerTitle: true,
      ),
      body: isready
          ? ListView.builder(
              itemCount: count,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: subserviceCard(
                      title: result.elementAt(index).values![1].toString(),
                      description:
                          result.elementAt(index).values![2].toString(),
                      price: result.elementAt(index).values![3].toString(),
                  subserviceId:result.elementAt(index).values![0].toString() ,
                    serviceId: widget.serviceId.toString(),

                  ),
                );
              },
            )
          : Loading(),
    );
  }
}

Widget searchTextField(BuildContext context) {
  return TextField(
    onSubmitted: (value) async {
      print(value);
      DatabaseService databaseService = DatabaseService();
      Results results = await databaseService.SearchService(value);
      print(results);
      if (!results.isEmpty) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchResult(results: results),
            ));
      } else {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: "Service Not Found",
          ),
        );
      }
    },
    controller: searchEditingController,
    autofocus: true, //Display the keyboard when TextField is displayed
    cursorColor: Colors.white,
    style: TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
    textInputAction:
        TextInputAction.search, //Specify the action button on the keyboard
    decoration: InputDecoration(
      //Style of TextField
      enabledBorder: UnderlineInputBorder(
          //Default TextField border
          borderSide: BorderSide(color: Colors.white)),
      focusedBorder: UnderlineInputBorder(
          //Borders when a TextField is in focus
          borderSide: BorderSide(color: Colors.white)),
      hintText: 'Search', //Text that is displayed when nothing is entered.
      hintStyle: TextStyle(
        //Style of hintText
        color: Colors.white60,
        fontSize: 20,
      ),
    ),
  );
}

class subserviceCard extends StatelessWidget {
  const subserviceCard(
      {Key? key,
      required this.title,
      required this.description,
      required this.price,
      required this.serviceId,
        required this.subserviceId

      })
      : super(key: key);
  final String title;
  final String description;
  final String price;
  final String serviceId;
  final String subserviceId;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            focusColor: Colors.red,
            hoverColor: Colors.red,
            splashColor: Colors.red,
            leading: Image.asset('assets/images/ac.png'),
            title: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(description),
            trailing: Column(
              children: [
                Text(
                  '₹' + price,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  height: 22,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () async {
                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                      String email = prefs.getString('email') ?? "";
                      print("email $email  serviceId $serviceId sub $subserviceId");
                       bool isadded = await  DatabaseService().addToCart(email, serviceId, subserviceId);
                      if(isadded == true) {
                        showTopSnackBar(

                          Overlay.of(context),
                          CustomSnackBar.success(

                            message: "Added To Cart",
                          ),

                        );
                      }
                    },
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                      backgroundColor: MaterialStatePropertyAll(Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(10), side: BorderSide(color: Colors.blue, strokeAlign:15),
            // ),
          ),
        ],
      ),
    );
  }
}
