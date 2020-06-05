import 'package:backpacking_indonesia/page/data/dump_data.dart';
import 'package:backpacking_indonesia/page/destination_specific/list_destination.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopCity extends StatelessWidget {
 final List<String> images;
  final List<String> nameCity;
  final String title;
  final double imageHeight;
  final double imageWidth;
  TopCity(
      {this.images,
      this.nameCity,
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
              itemCount: 5,
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
                        onTap: () => Get.to(ListDestination()),
                          child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image(
                            image: AssetImage(images[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 40.0),
                        child: Text(nameCity[index],
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