import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../constant/color/color.dart';
import '../../constant/style/style.dart';
import 'package:mysql1/mysql1.dart';

late String name;

class ServiceMenDetails extends StatelessWidget {
  ServiceMenDetails({Key? key, required this.result, required this.index})
      : super(key: key);
  final Results result;
  final int index;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
                          ProductNameAndPrice(
                              name: result
                                  .elementAt(index)
                                  .values![0]
                                  .toString()),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                              'Address : ${result.elementAt(index).values![4].toString()}',
                              style: AppStyle.text.copyWith(
                                  color: Colors.white.withOpacity(.8))),
                          const Spacing(),
                          Text(
                              'Mobile Number : ${result.elementAt(index).values![6].toString()}',
                              style: AppStyle.text.copyWith(
                                  color: Colors.white.withOpacity(.8))),
                          const Spacing(),
                          Text('Experience : ',
                              style: AppStyle.text.copyWith(
                                  color: Colors.white.withOpacity(.8))),
                          const Spacing(),
                          Text('Work Details : ',
                              style: AppStyle.text.copyWith(
                                  color: Colors.white.withOpacity(.8))),
                          const Spacing(),
                          Text(
                            'This is weekdays design-your go-to for all the latest trends, no matter who you are.',
                            style:
                                AppStyle.bodyText.copyWith(color: Colors.white),
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
                                                  AppColor.primary),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16))),
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  Size(size.width / 2.5, 37))),
                                      onPressed: () {},
                                      child: Text('Call Now',
                                          style: AppStyle.h3
                                              .copyWith(color: Colors.white)))),
                              Center(
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  AppColor.primary),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16))),
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  Size(size.width / 2.5, 37))),
                                      onPressed: () {},
                                      child: Text('History',
                                          style: AppStyle.h3
                                              .copyWith(color: Colors.white)))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          ],
        ),
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

class ProductNameAndPrice extends StatelessWidget {
  const ProductNameAndPrice({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: AppStyle.h1Light,
        ),
        Text(
          '5 ⭐',
          style: AppStyle.h1Light
              .copyWith(color: AppColor.primary, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
