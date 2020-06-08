import 'package:backpacking_indonesia/data/dump_data.dart';
import 'package:backpacking_indonesia/page/destination_specific/top_city.dart';
import 'package:backpacking_indonesia/page/destination_specific/various_city.dart';
import 'package:flutter/material.dart';

class ListCity extends StatefulWidget {

  @override
  _ListCityState createState() => _ListCityState();
}

class _ListCityState extends State<ListCity> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
              child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Find Your City Destination",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SearchEngineCity(),
              TopCity(
                images: topCity,
                nameCity: nameCity,
                title: "Top 5 City",
                imageHeight: 200.0,
                imageWidth: 300.0,
              ),
              SizedBox(height: 20.0),
              VariousCity(
                images: topCity,
                title: "List of City",
                imageHeight: 150.0,
                nameCity: nameCity,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SearchEngineCity extends StatefulWidget {
  @override
  _SearchEngineCityState createState() => _SearchEngineCityState();
}

class _SearchEngineCityState extends State<SearchEngineCity> {
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
                    hintText: "Search the city ..."),
              ),
            ),
          ],
        ),
      ),
    );
  }
}