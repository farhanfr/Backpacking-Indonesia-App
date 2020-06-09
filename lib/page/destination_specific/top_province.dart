import 'package:backpacking_indonesia/page/destination_specific/list_city.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopProvince extends StatelessWidget {
  // final List<String> images;
  // final List<String> nameProvince;
  final List dataTopProvince;
  final String title;
  final double imageHeight;
  final double imageWidth;
  TopProvince(
      {this.dataTopProvince,
      this.title,
      this.imageHeight,
      this.imageWidth});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold),
              ),
              // GestureDetector(
              //   onTap: () => print('View $title'),
              //   child: Icon(
              //     Icons.arrow_forward,
              //     color: Colors.black,
              //     size: 30.0,
              //   ),
              // ),
            ],
          ),
        ),
        Container(
          height: imageHeight,
          child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              scrollDirection: Axis.horizontal,
              itemCount: dataTopProvince.length,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      width: imageWidth,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              offset: Offset(0.0, 4.0),
                              blurRadius: 6.0,
                            )
                          ]),
                      child: GestureDetector(
                        onTap: ()=>Get.to(ListCity()),
                          child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network("http://192.168.1.5:8000/img/${dataTopProvince[index]['photo']}",
                          fit: BoxFit.cover,
                          )
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 40.0),
                        child: Text("a",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins")),
                      ),
                    ),
                  ],
                );
              }),
        )
      ],
    );
  }
}
