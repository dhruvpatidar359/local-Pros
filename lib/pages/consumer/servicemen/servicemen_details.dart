import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:localpros/database/database_service.dart';
import 'package:localpros/wingets/loading.dart';
import '../../constant/color/color.dart';
import '../../constant/style/style.dart';
import 'package:mysql1/mysql1.dart';

late String name;

class ServiceMenDetails extends StatefulWidget {
  ServiceMenDetails({Key? key, required this.result, required this.index})
      : super(key: key);
  final Results result;
  final int index;

  @override
  State<ServiceMenDetails> createState() => _ServiceMenDetailsState();
}

class _ServiceMenDetailsState extends State<ServiceMenDetails> {
  List<String> tags = [];
  DatabaseService databaseService = DatabaseService();
  bool isready = false;

  Future<void> fetchTags() async {
    final t = await databaseService.fetchTags(
        '${widget.result.elementAt(widget.index).values![1].toString()}');
    isready = true;
    setState(() {
      tags = t;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTags();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: isready ? Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: Container(
                  alignment: Alignment.topCenter,
                  height: size.height / 2,
                  width: size.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          alignment: Alignment.bottomRight,
                          fit: BoxFit.fitWidth,
                          image: AssetImage('assets/images/man.png'))),
                ),
              ),
              Positioned(
                  top: 60,
                  right: 20,
                  child: GestureDetector(
                    onTap: () {
                      // add to favorites
                    },
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(11)),
                      child: Icon(
                        Icons.favorite,
                        color: Colors.pink,
                        size: 30,
                      ),
                    ),
                  )),
              Positioned(
                  bottom: 0,
                  child: Container(
                    height: size.height / 2.1,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: AppColor.secondary,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(34),
                          topLeft: Radius.circular(34)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                height: 5,
                                width: 32 * 1.5,
                                decoration: BoxDecoration(
                                  gradient: AppColor.gradient,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                            NameAndRatingBar(
                              name: widget.result
                                  .elementAt(widget.index)
                                  .values![0]
                                  .toString(),
                              index: widget.index,
                              result: widget.result,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                                'Address : ${widget.result.elementAt(widget.index).values![3].toString()}',
                                style: AppStyle.text.copyWith(
                                    color: Colors.white.withOpacity(.8))),
                            const Spacing(),
                            Text(
                                'Mobile Number : ${widget.result.elementAt(widget.index).values![5].toString()}',
                                style: AppStyle.text.copyWith(
                                    color: Colors.white.withOpacity(.8))),
                            const Spacing(),
                            Row(
                              children: [
                                Text("Gender : ",
                                    style: AppStyle.text.copyWith(
                                        color: Colors.white.withOpacity(.8))),
                                Text(
                                    widget.result
                                                .elementAt(widget.index)
                                                .values![4]
                                                .toString() ==
                                            "m"
                                        ? 'Male'
                                        : widget.result
                                                    .elementAt(widget.index)
                                                    .values![4]
                                                    .toString() ==
                                                'f'
                                            ? "Female"
                                            : "None",
                                    style: AppStyle.text.copyWith(
                                        color: Colors.white.withOpacity(.8))),
                              ],
                            ),
                            const Spacing(),
                            Text(
                                'Experience : ${widget.result.elementAt(widget.index).values![6].toString()}',
                                style: AppStyle.text.copyWith(
                                    color: Colors.white.withOpacity(.8))),
                            const Spacing(),
                            Text('Work Details : ',
                                style: AppStyle.text.copyWith(
                                    color: Colors.white.withOpacity(.8))),
                            Wrap(
                              spacing: 6.0,
                              runSpacing: 6.0,
                              children: <Widget>[
                                for (String i in tags)
                                  _buildChip(i, Colors.white)
                              ],
                            ),
                            const Spacing(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Center(
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16))),
                                            minimumSize:
                                                MaterialStateProperty.all(Size(
                                                    size.width / 2.5, 37))),
                                        onPressed: () async {
                                          final number =
                                              '${widget.result.elementAt(widget.index).values![5].toString()}'; //set the number here
                                          bool? res =
                                              await FlutterPhoneDirectCaller
                                                  .callNumber(number);
                                        },
                                        child: Text('Call Now',
                                            style: AppStyle.h3
                                                .copyWith(color: Colors.black)))),
                                Center(
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16))),
                                            minimumSize: MaterialStateProperty.all(
                                                Size(size.width / 2.5, 37))),
                                        onPressed: () {},
                                        child: Text('History',
                                            style: AppStyle.h3.copyWith(
                                                color: Colors.black)))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        )
            : Loading(),
      ),
    );
  }
}

class TabTitle extends StatelessWidget {
  final String label;
  final bool selected;
  const TabTitle({
    Key? key,
    required this.label,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            label,
            style: AppStyle.text.copyWith(color: Colors.white),
          ),
          const SizedBox(
            height: 4,
          ),
          if (selected)
            Container(
              width: 21,
              height: 2,
              decoration: const BoxDecoration(color: AppColor.primary),
            )
        ])
      ],
    );
  }
}

class Spacing extends StatelessWidget {
  const Spacing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 16,
    );
  }
}

class RectButtonSelected extends StatelessWidget {
  final String label;
  const RectButtonSelected({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 14),
      height: 32,
      width: 32,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9), gradient: AppColor.gradient),
      child: Center(
          child: Text(
        label,
        style: AppStyle.text,
      )),
    );
  }
}

class RectButton extends StatelessWidget {
  final String label;
  const RectButton({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 14),
      height: 32,
      width: 32,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          border: Border.all(color: AppColor.primary)),
      child: Center(
          child: Text(
        label,
        style: AppStyle.text.copyWith(color: Colors.white),
      )),
    );
  }
}

class NameAndRatingBar extends StatelessWidget {
  var index;

  var result;

  NameAndRatingBar({
    Key? key,
    required this.name,
    required this.index,
    required this.result,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name,
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                // height: 38,
                // letterSpacing: 20,
                color: Colors.white)),
        RatingBar.builder(
          initialRating: result.elementAt(index).values![7].toDouble() / 100,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          ignoreGestures: true,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            // print(rating);
          },
        )
      ],
    );
  }
}

Widget _buildChip(String label, Color color) {
  return Chip(
    labelPadding: EdgeInsets.all(2.0),
    avatar: CircleAvatar(
      backgroundColor: Colors.black,
      child: Text(label[0].toUpperCase()),
    ),
    label: Text(
      label,
      style: TextStyle(
        color: Colors.black,
      ),
    ),
    backgroundColor: color,
    elevation: 6.0,
    shadowColor: Colors.grey[60],
    padding: EdgeInsets.all(8.0),
  );
}
