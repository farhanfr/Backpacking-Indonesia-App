import 'dart:convert';

import 'package:backpacking_indonesia/data/dump_data.dart';
import 'package:backpacking_indonesia/model/destination_comment_model.dart';
import 'package:backpacking_indonesia/model/destination_model.dart';
import 'package:backpacking_indonesia/page/various_subdestination.dart';
import 'package:backpacking_indonesia/page/widget/circullar_clipper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailDestination extends StatefulWidget {
  final String imgHeaderDetail,nameDestination,descDestination;  
  final int destinationId,statusResp;

  DetailDestination(
      {Key key, this.imgHeaderDetail, this.nameDestination, this.descDestination, this.destinationId, this.statusResp})
      : super(key: key);

  @override
  _DetailDestinationState createState() => _DetailDestinationState();
}

class _DetailDestinationState extends State<DetailDestination> {

  var loading = false;
  _checkInData(){
    setState(() {
      loading = true;
    });
    if (widget.statusResp == 200) {
      setState(() {
      loading = false;
    });
    }
  }

  List<DestinationCommentModel> _list = [];
  Future<Null> getComment() async {
      final response = await http.get(
          "http://192.168.1.7:8000/api/v1/comment/destination/get/?city_id=3&destination_id=1");
    
      setState(() {
      loading = true;
    });

      if (response.statusCode == 200) {
        final data = [jsonDecode(response.body)];
        for (Map data in data) {
          _list.add(DestinationCommentModel.fromJson(data));
        }
        setState(() {
      loading = false;
    });
        print(data);
      }
      else{
        print("RESPONS GAGA;");
      }
  }
  
  @override
  void initState() {
    super.initState();
    getComment();
    _checkInData();
    print("VARIOUS DESTNATION 3 ${widget.statusResp}");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      // ),
      body: 
      loading ? Center(child: CircularProgressIndicator())  :
      ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                child: Hero(
                  tag: "new_destination",
                  child: ClipShadowPath(
                    clipper: CircularClipper(),
                    shadow: Shadow(blurRadius: 20.0),
                    child: Image.network(
                       "http://192.168.1.7:8000/img/${widget.imgHeaderDetail}",
                      height: 400.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
              ),
              Positioned.fill(
                bottom: 20.0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RawMaterialButton(
                    padding: EdgeInsets.all(20.0),
                    elevation: 12.0,
                    onPressed: () => print('Play Video'),
                    shape: CircleBorder(),
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.favorite,
                      size: 40.0,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            // transform: Matrix4.translationValues(0.0, -30.0, 0.0),
            child: Column(
              children: <Widget>[
                Text(widget.nameDestination,
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 32,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      widget.descDestination,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                      ),
                    )),
                SizedBox(
                  height: 40.0,
                ),
                VariousSubDestination(
                  images: subDestination,
                  nameSubDestination: nameSubDestination,
                  title: "Gallery",
                  imageHeight: 200.0,
                  imageWidth: 300.0,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Comment",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.add_comment,
                          color: Colors.black,
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                ),
                loading ? Center(child: CircularProgressIndicator()) :
                ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _list.length,
                          itemBuilder: (BuildContext context, int index) {
                            final getDataDestinationList = _list[index];
                            return Container(
                              child: Text(getDataDestinationList.data[index].comment),
                            );
                          })
              ],
            ),
          )
        ],
      ),
    );
  }
}
