import 'dart:convert';
import 'dart:math';

import 'package:backpacking_indonesia/data/dump_data.dart';
import 'package:backpacking_indonesia/model/destination_comment_model.dart';
import 'package:backpacking_indonesia/model/destination_model.dart';
import 'package:backpacking_indonesia/page/destination_specific/add_comment_destination.dart';
import 'package:backpacking_indonesia/page/first_open.dart';
import 'package:backpacking_indonesia/page/various_subdestination.dart';
import 'package:backpacking_indonesia/page/widget/circullar_clipper.dart';
import 'package:backpacking_indonesia/page/widget/randomString.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DetailDestination extends StatefulWidget {
  final String imgHeaderDetail, nameDestination, descDestination;
  final int destinationId, statusResp, cityId;

  DetailDestination(
      {Key key,
      this.imgHeaderDetail,
      this.nameDestination,
      this.descDestination,
      this.destinationId,
      this.statusResp,
      this.cityId})
      : super(key: key);

  @override
  _DetailDestinationState createState() => _DetailDestinationState();
}

class _DetailDestinationState extends State<DetailDestination> {
  TextEditingController commentCon = new TextEditingController();
Future<Null> addComment() async {
    if (commentCon.text == "") {
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          msg: "comment can't null");
    } else {
      final response = await http.post(
          "http://192.168.1.7:8000/api/v1/comment/destination/add",
          body: {
            "city_id": widget.cityId.toString(),
            "user_id": 1.toString(),
            "comment": commentCon.text,
            "destination_id": widget.destinationId.toString()
          });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        DestinationCommentModel addComment =
            new DestinationCommentModel.fromJson(data);
        if (addComment.status == true) {
          // Get.off(DetailDestination(
          //   nameDestination: widget.nameDestination,
          //               descDestination: widget.descDestination,
          //               imgHeaderDetail: widget.imgHeaderDetail,
          //               destinationId: widget.destinationId,
          //               cityId: widget.cityId,
          //               statusResp: widget.statusResp
          // ));
          // Get.off(DetailDestination());
          setState(() {
            getComment();
            Navigator.pop(context,true);
          });
          
          print(addComment.message);
        }
      } else {
        print("RESPONS GAGA;");
      }
    }
  }

void modalAddComment() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)), //this right here
            child: Container(
              height: 500,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: commentCon,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'add your comment'),
                    ),
                    SizedBox(
                      width: 320.0,
                      child: RaisedButton(
                        onPressed: () {
                          setState(() {
                            addComment();  
                          });
                          
                        },
                        child: Text(
                          "Add comment",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.red[600],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }


  var loading = false;
  _checkInData() {
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
  bool isNullDataComment = false;
  Future<Null> getComment() async {
    final response = await http.get(
        "http://192.168.1.7:8000/api/v1/comment/destination/get/?city_id=${widget.cityId}&destination_id=${widget.destinationId}");


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
        if (_list[0].message == "comment is empty") {
          isNullDataComment = true;
        }
      });
      print(data);
    } else {
      print("RESPONS GAGA;");
    }
  }

  var idUser = 0;
   _getIdUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      idUser = (prefs.getInt("idUser"));
    });
  }



  @override
  void initState() {
    super.initState();
    _getIdUser();
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
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView(
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
                  key: Key(randomString(20)),
                  // transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                  child: Column(children: <Widget>[
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
                            onTap: () {
                            //  Get.to(AddCommentDestination(
                            //     nameDestination: widget.nameDestination,
                            //     descDestination: widget.descDestination,
                            //     imgHeaderDetail: widget.imgHeaderDetail,
                            //     destinationId: widget.destinationId,
                            //     cityId: widget.cityId,
                            //     statusResp: widget.statusResp,
                            //     idUser: idUser,
                            //  ));
                            modalAddComment();
                            },
                            child: Icon(
                              Icons.add_comment,
                              color: Colors.black,
                              size: 30.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    loading
                        ? Center(child: CircularProgressIndicator())
                        : _list.length == 0
                            ? Text("Comment is empty")
                            : _list[0].message == "comment is empty"
                                ? Text("Comment is empty")
                                :
                                // Text("Comment is empty2")
                                ListView.builder(
                                    shrinkWrap: true,
                                    key: UniqueKey(),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        _list[0].message == "comment is empty"
                                            ? 0
                                            : _list[0].data.length >= 1 &&  _list[0].data.length <= 5 ? _list[0].data.length : 5,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      // final getDataDestinationList =
                                      //     _list[0].data[index];
                                      print(_list[0].data.length);
                                       return CommentList(index: index,key: UniqueKey(),list: _list,);
                                    }),
                    isNullDataComment == true
                        ? Visibility(child: Text("Hidden"), visible: false)
                        : Center(
                            child: InkWell(
                            child: Text("See all comments",
                                style: TextStyle(
                                    color: Colors.red, fontSize: 15.0)),
                            onTap: () {},
                          )),
                    SizedBox(
                      height: 20.0,
                    )
                  ]),
                )
              ],
            ),
    );
  }
}

class CommentList extends StatefulWidget {
  final List list;
  int index;
  CommentList({
    Key key, this.list, this.index, 
  }) :  super(key: key);

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.key,
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("assets/images/hanzo.jpg"),
                        fit: BoxFit.fill)),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Farhan Fitrahtur",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ],
          ),
          SizedBox(height: 10.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(widget.list[0].data[widget.index].commentDate),
          ),
          SizedBox(height: 20.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(widget.list[0].data[widget.index].comment,
                maxLines: 4, overflow: TextOverflow.ellipsis),
          )
        ],
      ),
    );
  }
}
