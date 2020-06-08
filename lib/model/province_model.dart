import 'package:backpacking_indonesia/page/destination_specific/list_province.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ProvinceModel extends StatefulWidget {
  @override
  _ProvinceModelState createState() => _ProvinceModelState();
}

class _ProvinceModelState extends State<ProvinceModel> {
  int id = -1;

  @override
  void initState() {
    super.initState();
    getZoneId();
  }

  getZoneId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = (prefs.getInt("IndexChooseZone"));
    });
  }

  Future<List> getDataProvince() async {
    final response = await http.get(
        "http://192.168.1.5:8000/api/v1/province/get/province/zone/?zone_id=$id");
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["data"];
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: getDataProvince(),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        print(snapshot.data);
        return snapshot.hasData
            ? ListItemProvince(list: snapshot.data)
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
