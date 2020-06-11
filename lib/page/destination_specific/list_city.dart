import 'package:backpacking_indonesia/page/destination_specific/search_result_city.dart';
import 'package:backpacking_indonesia/page/destination_specific/top_city.dart';
import 'package:backpacking_indonesia/page/destination_specific/various_city.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ListCity extends StatefulWidget {
  final int provinceId;
  ListCity({this.provinceId});
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
              SearchEngineCity(provinceId: widget.provinceId),
              TopCity(
                // images: topCity,
                // nameCity: nameCity,
                title: "Top 5 City",
                imageHeight: 200.0,
                imageWidth: 300.0,
                province_id: widget.provinceId
              ),
              SizedBox(height: 20.0),
              VariousCity(
                title: "List of City",
                imageHeight: 150.0,
                provinceId: widget.provinceId,
              )
            ],
          ),
        ),
      )
    );
  }
}

class SearchEngineCity extends StatefulWidget {
  final int provinceId;
  SearchEngineCity({this.provinceId});
  @override
  _SearchEngineCityState createState() => _SearchEngineCityState();
}

class _SearchEngineCityState extends State<SearchEngineCity> {
  var nameCity = "";
  TextEditingController searchCityController = new TextEditingController();
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
                controller: searchCityController,
                textInputAction: TextInputAction.search,
                onSubmitted: (String nameCityParams) {
                  setState(() {
                    nameCity = nameCityParams;
                    print(nameCityParams);
                  });
                  if (searchCityController.text.isNotEmpty) {
                    Get.to(SearchResultCity(nameCity: nameCity,provinceId: widget.provinceId,));
                    searchCityController.text = "";
                  } else {
                    Fluttertoast.showToast(
                        toastLength: Toast.LENGTH_SHORT,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        msg: "Sorry, your search is empty");
                  }
                },
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