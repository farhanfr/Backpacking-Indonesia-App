import 'package:backpacking_indonesia/data/dump_data.dart';
import 'package:backpacking_indonesia/page/various_subdestination.dart';
import 'package:backpacking_indonesia/page/widget/circullar_clipper.dart';
import 'package:flutter/material.dart';

class DetailDestination extends StatefulWidget {
  final List<String> newDestination;
  final List<String> nameDestination;
  final int index;

  DetailDestination(
      {Key key, this.newDestination, this.nameDestination, this.index})
      : super(key: key);

  @override
  _DetailDestinationState createState() => _DetailDestinationState();
}

class _DetailDestinationState extends State<DetailDestination> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      // ),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                child: Hero(
                  tag: widget.newDestination[widget.index],
                  child: ClipShadowPath(
                    clipper: CircularClipper(),
                    shadow: Shadow(blurRadius: 20.0),
                    child: Image(
                      height: 400.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      image: AssetImage(widget.newDestination[widget.index]),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                bottom: 20.0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RawMaterialButton(
                    padding: EdgeInsets.all(20.0),
                    elevation: 12.0,
                    onPressed: () => print('Play Video'),
                    shape: CircleBorder(),
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.favorite,
                      size: 40.0,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            // transform: Matrix4.translationValues(0.0, -30.0, 0.0),
            child: Column(
              children: <Widget>[
                Text(widget.nameDestination[widget.index],
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 32,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                      ),
                    )),
                SizedBox(
                  height: 40.0,
                ),
                VariousSubDestination(
                  images: subDestination,
                  nameSubDestination: nameSubDestination,
                  title: "Gallery",
                  imageHeight: 200.0,
                  imageWidth: 300.0,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Comment",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.add_comment,
                          color: Colors.black,
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
