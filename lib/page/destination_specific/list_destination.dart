import 'package:backpacking_indonesia/data/dump_data.dart';
import 'package:backpacking_indonesia/page/destination_specific/top_destination.dart';
import 'package:backpacking_indonesia/page/destination_specific/various_destination.dart';
import 'package:backpacking_indonesia/page/detail_destination.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListDestination extends StatefulWidget {
  @override
  _ListDestinationState createState() => _ListDestinationState();
}

class _ListDestinationState extends State<ListDestination> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8);
  }

  _destinationSelector(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 270.0,
            width: Curves.easeInOut.transform(value) * 400.0,
            child: widget,
          ),
        );
      },
      child: GestureDetector(
        onTap: () =>Get.to(DetailDestination(nameDestination: nameDestination,newDestination: newDestination,index: index,)),
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Center(
                  child: Hero(
                      tag: newDestination[index],
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image(
                          image: AssetImage(newDestination[index]),
                          height: 220.0,
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
              ),
            ),
            Positioned(
                left: 30.0,
                bottom: 40.0,
                child: Container(
                  width: 250.0,
                  child: Text(
                    nameNewDestination[index].toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Colors.black),
        ),
        body: ListView(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Find & Get Your Destination",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Poppins",
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SearchEngineDestination(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text("New Destination",
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            height: 280.0,
            width: double.infinity,
            child: PageView.builder(
              controller: _pageController,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return _destinationSelector(index);
              },
            ),
          ),
          SizedBox(height: 20.0),
          TopDestination(
            images: topDestination,
            nameDestination: nameDestination,
            title: "Top 5 Destination",
            imageHeight: 200.0,
            imageWidth: 300.0,
          ),
          SizedBox(height: 20.0),
          VariousDestination(
            images: topCity,
            title: "List of City",
            imageHeight: 150.0,
            nameDestination: nameDestination,
          )
        ]));
  }
}

class SearchEngineDestination extends StatefulWidget {
  @override
  _SearchEngineDestinationState createState() =>
      _SearchEngineDestinationState();
}

class _SearchEngineDestinationState extends State<SearchEngineDestination> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
      child: SizedBox(
        height: 100,
        child: Stack(
          children: <Widget>[
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 8),
                        blurRadius: 20,
                        color: Colors.grey.withOpacity(0.2))
                  ]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                textInputAction: TextInputAction.send,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search the province ..."),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
