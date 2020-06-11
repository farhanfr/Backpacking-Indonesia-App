import 'dart:convert';

import 'package:backpacking_indonesia/model/destination_model.dart';
import 'package:backpacking_indonesia/page/detail_destination.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VariousDestination extends StatefulWidget {
  // final List<String> images;
  // final List<String> nameDestination;
  final List dataDestination;
  final String title;
  final double imageHeight;
  final double imageWidth;
  final int cityId,getStatusResp;
  VariousDestination(
      {this.title,
      this.imageHeight,
      this.imageWidth,
      this.dataDestination, this.cityId, this.getStatusResp,
      });

  @override
  _VariousDestinationState createState() => _VariousDestinationState();
}

class _VariousDestinationState extends State<VariousDestination> {
  
  List<DestinationModel> _list = [];
  var loading = false;
  Future<Null> getDataCity() async {
    // print("CEKKK FUTURE CITY MODEL ${widget.index}");
    final response = await http.get(
        "http://192.168.1.5:8000/api/v1/destination/get/destination/city/?city_id=${widget.cityId}");
    // Map<String, dynamic> map = json.decode(response.body);
    // List<dynamic> data = map["data"];
    setState(() {
      loading = true;
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      for (Map i in data) {
        _list.add(DestinationModel.fromJson(i));
      }
      setState(() {
      loading = false;
    });
      print(data);
    }
    else{
      print("GAGAL");
    }
  }

  @override
  void initState() {
    super.initState();
    getDataCity();
    print("VARIOUS DESTNATION 2 ${widget.getStatusResp}");
  }

  @override
  Widget build(BuildContext context) {
    return 
    // loading ? Center(child: CircularProgressIndicator()) :
    Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20.0, bottom: 15.0),
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
        loading ? Center(child: CircularProgressIndicator()) :
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            // scrollDirection: Ax,
            itemCount: _list.length,
            itemBuilder: (BuildContext context, int index) {
              final x = _list[index];
              return Container(
                height: widget.imageHeight,
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                      onTap: () => Get.to(DetailDestination(
                        nameDestination: x.name_destination,
                        descDestination: x.desc_destination,
                        imgHeaderDetail: x.photo,
                        destinationId: x.id,
                        statusResp: widget.getStatusResp
                      )),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            "http://192.168.1.5:8000/img/${x.photo}",
                              fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 20.0),
                        child: Text(x.name_destination,
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
            }),
      ],
    );
  }
}
