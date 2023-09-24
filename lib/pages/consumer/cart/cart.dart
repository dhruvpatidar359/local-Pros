import 'package:flutter/material.dart';
import 'package:localpros/database/database_service.dart';
import 'package:localpros/pages/orderconformconsumer.dart';
import 'package:localpros/pages/servicemen/notification_information.dart';
import 'package:localpros/pages/servicemen/notificatons.dart';
import 'package:localpros/wingets/loading.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  late List<Results> result;
  String email = "";
  String name = "";
  bool isready = false;
  DatabaseService databaseService = DatabaseService();
  double totalamount = 0.0;
  void updateTotalPrice(){
    totalamount = 0.0;
    for(var item in result)
    {
      double Price = double.parse(item.first.values![2].toString());
      totalamount += Price;
    }
  }
  void getData() async {

    result = await databaseService.fetchCart(email);
    setState(() {
      isready = true;
    });
    print(result);
    print(result.length);
    updateTotalPrice();
    print("totalamount: $totalamount");

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
    return isready ? Scaffold(
      body: ListView.builder(

        itemCount: result.length,
        itemBuilder: (context, index) {
          String title = result.elementAt(index).first.values![0].toString();
          String description  = result.elementAt(index).first.values![1].toString();
          String price  = result.elementAt(index).first.values![2].toString();
          return subserviceCard(title: title, description: description, price: price, onRemove: () async {

            bool isDeleted  = await databaseService.deleteCart(email, result.elementAt(index).first.values![3].toString(),result.elementAt(index).first.values![4].toString());
            if(isDeleted == true) {
              showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.error(
                  message: "Item Removed",
                ),
              );
            }


            setState(() {
              result.removeAt(index);
              updateTotalPrice();
            });


          },);

        },
      ),
      drawer: Drawer(
        backgroundColor: Colors.blue.shade400,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 50),
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/man.png'),
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              email,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                shape:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                onTap: () {},
                selectedColor: Colors.white,
                selected: true,
                contentPadding:
                EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                leading: Icon(Icons.share),
                title: Text(
                  'Share with friends',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                shape:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                onTap: () {},
                selectedColor: Colors.white,
                selected: true,
                contentPadding:
                EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                leading: Icon(Icons.location_on),
                title: Text(
                  'Address',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                shape:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                onTap: () {},
                selectedColor: Colors.white,
                selected: true,
                contentPadding:
                EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                leading: Icon(Icons.notification_important),
                title: Text(
                  'Notifications',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlue,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Text(
                'Total: ₹${totalamount.toStringAsFixed(2)}',// Displaying total price here
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Custom text color
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const orderconformconsumer()),);
                },
                style:ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  primary: Colors.green,
                  elevation: 2,
                ),
                child: Text(
                  'Checkout',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    )
    : Loading();
  }
}

class subserviceCard extends StatelessWidget {
  const subserviceCard(
      {Key? key,
        required this.title,
        required this.description,
        required this.price,
        required this.onRemove,
      })
      : super(key: key);
  final String title;
  final String description;
  final String price;
  final VoidCallback onRemove;
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        margin: EdgeInsets.all(14),
        child:Container(
          height: 100,
          color: Colors.blue.shade100,
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
            trailing: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '₹' + price,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ButtonStyle(shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))),
                    onPressed: onRemove,
                    child: Text(
                      'Remove',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }
}
