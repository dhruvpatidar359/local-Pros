import 'package:flutter/material.dart';
import 'package:localpros/database/database_service.dart';
import 'package:localpros/wingets/loading.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  late Results result;
  String sname = "";
  String description = "";
  String price = "";
  String email = "";
  String name = "";
  bool isready = false;
  DatabaseService databaseService = DatabaseService();

  void getData() async {

    result = await databaseService.fetchCart(email);
    sname = result.elementAt(0).values![0].toString();
    description = result.elementAt(0).values![1].toString();
    price = result.elementAt(0).values![2].toString();
    isready = true;
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((prefs) => {
      setState(() {
        email = prefs.getString("email") ?? "";
        name = prefs.getString("name") ?? "";
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
        itemCount: 1,
        itemBuilder: (context, index) {
          return subserviceCard(title: sname, description: description, price: price);
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
                'Total:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Custom text color
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // click kr na pa order section pa jay ga
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
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

      })
      : super(key: key);
  final String title;
  final String description;
  final String price;

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
