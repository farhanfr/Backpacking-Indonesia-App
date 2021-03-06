import 'package:backpacking_indonesia/page/destination_specific/list_city.dart';
import 'package:backpacking_indonesia/page/destination_specific/search_result_province.dart';
import 'package:backpacking_indonesia/page/destination_specific/top_province.dart';
import 'package:backpacking_indonesia/page/destination_specific/various_province.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListProvince extends StatefulWidget {
  @override
  _ListProvinceState createState() => _ListProvinceState();
}

class _ListProvinceState extends State<ListProvince> {
  int id;
  var loading = true;
  @override
  void initState() {
    super.initState();
    _getZoneId2();
  }

  _getZoneId2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = (prefs.getInt("IndexChooseZone"));
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
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
                      padding:
                          EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Find Your Province Destination",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SearchEngineProvince(idZone: id),
                    TopProvince(
                      // dataTopProvince: list2,
                      zoneId: id,
                      title: "Top 5 Province",
                      imageHeight: 200.0,
                      imageWidth: 300.0,
                    ),
                    SizedBox(height: 20.0),
                    VariousProvince(
                        zoneId: id,
                        title: "List of Province",
                        imageHeight: 150.0)
                  ],
                ),
              ),
            ));
  }
}

class SearchEngineProvince extends StatefulWidget {
  final int idZone;
  SearchEngineProvince({this.idZone});
  @override
  _SearchEngineProvinceState createState() => _SearchEngineProvinceState();
}

class _SearchEngineProvinceState extends State<SearchEngineProvince> {
  var nameProvince = "";
  TextEditingController searchProvController = new TextEditingController();

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
                controller: searchProvController,
                textInputAction: TextInputAction.search,
                onSubmitted: (String nameProvinceParams) {
                  setState(() {
                    nameProvince = nameProvinceParams;
                    print(nameProvinceParams);
                  });
                  if (searchProvController.text.isNotEmpty) {
                    Get.to(SearchResultProvince(nameProvince: nameProvince,idZone: widget.idZone,));
                    searchProvController.text = "";
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
                    hintText: "Search the province ..."),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
