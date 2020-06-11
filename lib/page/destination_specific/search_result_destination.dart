import 'dart:convert';

import 'package:backpacking_indonesia/model/destination_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchResultDestination extends StatefulWidget {
  final String nameDestination;
  final int cityId;
  SearchResultDestination({this.nameDestination, this.cityId});
  @override
  _SearchResultDestinationState createState() => _SearchResultDestinationState();
}

class _SearchResultDestinationState extends State<SearchResultDestination> {
  List<DestinationModel> _list = [];
  var loading = false;
  var getStatusResp = 0;
  var getNullText = false;
  Future<Null> getDataDestination() async {
    // print("CEKKK FUTURE CITY MODEL ${widget.index}");
    final response = await http.get(
        "http://192.168.1.5:8000/api/v1/destination/search/?name_destination=${widget.nameDestination}&city_id=${widget.cityId}");
    // Map<String, dynamic> map = json.decode(response.body);
    // List<dynamic> data = map["data"];
    setState(() {
      loading = true;
    });
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        final data = jsonDecode(response.body);
        for (Map i in data) {
          _list.add(DestinationModel.fromJson(i));
        }
      } else {
        setState(() {
          getNullText = true;
        });
      }

      setState(() {
        loading = false;
        getStatusResp = response.statusCode;
      });
    } else {
      print("GAGAL");
    }
  }

  @override
  void initState() {
    super.initState();
    getDataDestination();
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
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Search Destination Result ....",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              loading
                  ? Center(child: CircularProgressIndicator())
                  : getNullText
                      ? Center(child: Text("Search Not Found"))
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _list.length,
                          itemBuilder: (BuildContext context, int index) {
                            final getDataDestinationList = _list[index];
                            return Container(
                              height: 200.0,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
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
                                  GestureDetector(
                                    onTap: (){},
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Image.network(
                                            "http://192.168.1.5:8000/img/${getDataDestinationList.photo}",
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30.0, vertical: 20.0),
                                      child: Text(getDataDestinationList.name_destination,
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
                          })
            ],
          ),
        ),
      ),
    );
  }
}