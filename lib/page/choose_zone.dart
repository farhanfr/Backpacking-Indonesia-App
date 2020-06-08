import 'package:backpacking_indonesia/page/main_parent.dart';
import 'package:backpacking_indonesia/storing/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

final List<String> imgList = [
  'assets/images/west.png',
  'assets/images/middle.png',
  'assets/images/east.jpg'
];

final List<String> titleZone = [
  'West of Indonesia',
  'Middle of Indonesia',
  'East of Indonesia'
];

final List<int> chooseZoneIndicator = [1, 2, 3];

final List<String> imgZone = [
  'assets/images/westtracer.png',
  'assets/images/middletracer.png',
  'assets/images/easttracer.png'
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(0.0),
            child: ClipRRect(
                // borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
              children: <Widget>[
                Image.asset('${imgList[imgList.indexOf(item)]}',
                    fit: BoxFit.cover, width: 1000.0, height: 1000.0),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  top: 30.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
                    child: Text(
                      '${titleZone[imgList.indexOf(item)]}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 45.0,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Image.asset("${imgZone[imgList.indexOf(item)]}"),
                  ),
                )),
                Positioned.fill(
                    bottom: 100.0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: RaisedButton(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            "Go To ${titleZone[imgList.indexOf(item)]}",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: BorderSide(color: Colors.white)),
                          onPressed: () {
                            SharedPref().removeValues("IndexChooseZone");
                            SharedPref().addIntToSF("IndexChooseZone",
                                chooseZoneIndicator[imgList.indexOf(item)]);
                            // print("SHARED PREF TERSEDIA : 1");
                            Get.to(MainParent());
                          }),
                    ))
              ],
            )),
          ),
        ))
    .toList();

class ChooseZone extends StatefulWidget {
  @override
  _ChooseZoneState createState() => _ChooseZoneState();
}

class _ChooseZoneState extends State<ChooseZone> {
  @override
  void initState() {
    super.initState();
    // SharedPref().removeValues("IndexChooseZone");
    SharedPref().checkValues("IndexChooseZone");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return CarouselSlider(
              options: CarouselOptions(
                height: height,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                // autoPlay: false,
              ),
              items: imageSliders);
        },
      ),
    );
  }
}
