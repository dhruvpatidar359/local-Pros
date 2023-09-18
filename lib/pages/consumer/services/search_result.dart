import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({Key? key, required this.results}) : super(key: key);
  final Results results;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
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
                    results.elementAt(0).values![1].toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(results.elementAt(0).values![2].toString()),
                  trailing: Column(
                    children: [
                      Text(
                        '₹' + results.elementAt(0).values![3].toString(),
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
                          onPressed: () {},
                          child: Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.blue),
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
          ),
        ),
      ),
    );
  }
}
