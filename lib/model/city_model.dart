import 'package:backpacking_indonesia/page/destination_specific/list_city.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class CityModel extends StatefulWidget {
final int index;
CityModel({this.index});

  @override
  _CityModelState createState() => _CityModelState();
}

class _CityModelState extends State<CityModel> {

  Future<List> getDataCity() async {
    // print("CEKKK FUTURE CITY MODEL ${widget.index}");
    final response = await http.get(
        "http://192.168.1.5:8000/api/v1/city/get/city/province/?province_id=${widget.index}");
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["data"];
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: getDataCity(),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        print(snapshot.data);
        return snapshot.hasData
            ? ListItemCity(listCity: snapshot.data,)
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}