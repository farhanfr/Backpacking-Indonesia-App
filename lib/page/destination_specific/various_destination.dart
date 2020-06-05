import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VariousDestination extends StatelessWidget {
  final List<String> images;
  final List<String> nameDestination;
  final String title;
  final double imageHeight;
  final double imageWidth;
  VariousDestination({this.images, this.title, this.imageHeight, this.imageWidth, this.nameDestination});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20.0, bottom: 15.0),
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
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            // scrollDirection: Ax,
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: imageHeight,
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(0.0, 4.0),
                        blurRadius: 6.0,
                      )
                    ]),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image(
                          image: AssetImage(images[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 20.0),
                        child: Text(nameDestination[index],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins")),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ],
    );
  }
}
