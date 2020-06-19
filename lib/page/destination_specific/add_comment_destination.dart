import 'dart:convert';

import 'package:backpacking_indonesia/model/destination_comment_model.dart';
import 'package:backpacking_indonesia/page/detail_destination.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
class AddCommentDestination extends StatefulWidget {
  final String imgHeaderDetail, nameDestination, descDestination;
  final int destinationId, statusResp, cityId, idUser;
  
  AddCommentDestination(
      {this.imgHeaderDetail,
      this.nameDestination,
      this.descDestination,
      this.destinationId,
      this.statusResp,
      this.cityId,
      this.idUser});
  @override
  _AddCommentDestinationState createState() => _AddCommentDestinationState();
}

class _AddCommentDestinationState extends State<AddCommentDestination> {
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
            "user_id": widget.idUser.toString(),
            "comment": commentCon.text,
            "destination_id": widget.destinationId.toString()
          });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        DestinationCommentModel addComment =
            new DestinationCommentModel.fromJson(data);
        if (addComment.status == true) {
          // Get.to(DetailDestination(
          //   nameDestination: widget.nameDestination,
          //               descDestination: widget.descDestination,
          //               imgHeaderDetail: widget.imgHeaderDetail,
          //               destinationId: widget.destinationId,
          //               cityId: widget.cityId,
          //               statusResp: widget.statusResp
          // ));
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          //   return DetailDestination(nameDestination: widget.nameDestination,
          //               descDestination: widget.descDestination,
          //               imgHeaderDetail: widget.imgHeaderDetail,
          //               destinationId: widget.destinationId,
          //               cityId: widget.cityId,
          //               statusResp: widget.statusResp);
          // }));
          Navigator.pop(context,(){
            setState(() {});
          });
          print(addComment.message);
        }
      } else {
        print("RESPONS GAGA;");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: new IconThemeData(color: Colors.black),
      ),
          body: Container(
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
                    border: InputBorder.none, hintText: 'add your comment'),
              ),
              SizedBox(
                width: 320.0,
                child: RaisedButton(
                  onPressed: () {
                    addComment();
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
  }
}
