import 'dart:convert';

import 'package:backpacking_indonesia/model/city_model.dart';
import 'package:backpacking_indonesia/page/destination_specific/list_destination.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TopCity extends StatefulWidget {
//  final List<String> images;
//   final List<String> nameCity;
  final String title;
  final int province_id;
  final double imageHeight;
  final double imageWidth;
  TopCity({this.title, this.imageHeight, this.imageWidth, this.province_id});

  @override
  _TopCityState createState() => _TopCityState();
}

class _TopCityState extends State<TopCity> {

  List<CityModel> _list = [];
  var loading = false;
  var getStatusResp = 0;
  Future<Null> getDataCity() async {
    // print("CEKKK FUTURE CITY MODEL ${widget.index}");
    final response = await http.get(
        "http://192.168.1.5:8000/api/v1/city/get/city/province/?province_id=${widget.province_id}");
    // Map<String, dynamic> map = json.decode(response.body);
    // List<dynamic> data = map["data"];
    setState(() {
      loading = true;
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      for (Map i in data) {
        _list.add(CityModel.fromJson(i));
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
    getDataCity();
  }
  
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
                widget.title,
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
          height: widget.imageHeight,
          child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              scrollDirection: Axis.horizontal,
              itemCount: _list.length,
              itemBuilder: (BuildContext context, int index) {
                final getDataTopCity = _list[index];
                return Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      width: widget.imageWidth,
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
                        onTap: () => Get.to(ListDestination(cityId: getDataTopCity.id)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            "http://192.168.1.5:8000/img/${getDataTopCity.photo}",
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
                        child: Text(getDataTopCity.name_city,
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
