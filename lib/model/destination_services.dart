// import 'package:backpacking_indonesia/model/destination_model.dart';
// import 'package:backpacking_indonesia/model/province_model.dart';
// import 'package:backpacking_indonesia/page/destination_specific/list_destination.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'dart:convert';

// class DestinationServices extends StatefulWidget {
//   final int index;
//   DestinationServices({this.index});
//   @override
//   _DestinationServicesState createState() => _DestinationServicesState();
// }

// class _DestinationServicesState extends State<DestinationServices> {

//   List<DestinationModel> list = [];
//   var loading = false;
//   Future<Null> getDataCity() async {
//     // print("CEKKK FUTURE CITY MODEL ${widget.index}");
//     final response = await http.get(
//         "http://192.168.1.5:8000/api/v1/city/get/destination/city/?city_id=1");
//     // Map<String, dynamic> map = json.decode(response.body);
//     // List<dynamic> data = map["data"];
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);  
//       for (Map i in data) {
//         list.add(DestinationModel.fromJson(i));
//       }
//       print("TESSSSS 3 ${list[0]}");
//       print(data);
//     }
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getDataCity();
//   }

//   @override
//   Widget build(BuildContext context) {
    
//     return ListDestinationItem(dataDestination: list );
//   }
// }
