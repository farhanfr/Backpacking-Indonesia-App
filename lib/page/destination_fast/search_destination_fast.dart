import 'package:backpacking_indonesia/component/constant.dart';
import 'package:backpacking_indonesia/page/destination_fast/search_quick_result_destination.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchDestinationFast extends StatefulWidget {
  @override
  _SearchDestinationFastState createState() => _SearchDestinationFastState();
}

class _SearchDestinationFastState extends State<SearchDestinationFast> {
  int id;

  @override
  void initState() {
    super.initState();
    _getZoneId();
  }

  _getZoneId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = (prefs.getInt("IndexChooseZone"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(children: <Widget>[
            Text("How to Get Quick Destination",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 28.0)),
            HowToSearch(
              img: "assets/images/caugh.png",
              titleText: "1. Use keyword destination",
              descText:
                  "Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks",
            ),
            HowToSearch(
              img: "assets/images/caugh.png",
              titleText: "2. Wait the process",
              descText:
                  "Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks",
            ),
            HowToSearch(
              img: "assets/images/caugh.png",
              titleText: "3.Get Destination",
              descText:
                  "Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks",
            ),
            SizedBox(
              height: 20.0,
            ),
            Divider(
              height: 10,
              color: Colors.grey,
            ),
            SizedBox(
              height: 20.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text("Search Destination Here",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0)),
            ),
            SizedBox(height: 20.0),
            SearchEngine(idZone: id),
            SizedBox(height: 20.0)
          ]),
        ),
      ),
    );
  }
}

class HowToSearch extends StatelessWidget {
  final String titleText;
  final String descText;
  final String img;

  const HowToSearch({this.titleText, this.descText, this.img});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 156,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Container(
              height: 136,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 8),
                        blurRadius: 24,
                        color: kShadowColor)
                  ]),
            ),
            Container(
              padding: EdgeInsets.all(30.0),
              child: Image.asset(img),
            ),
            Positioned(
              left: 130,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                height: 136,
                width: MediaQuery.of(context).size.width - 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(titleText,
                        style: kTitleTextstyle.copyWith(
                          fontSize: 16,
                        )),
                    SizedBox(height: 10.0),
                    Text(descText,
                        style: TextStyle(
                          fontSize: 12,
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SearchEngine extends StatefulWidget {
  final int idZone;
  SearchEngine({this.idZone});
  @override
  _SearchEngineState createState() => _SearchEngineState();
}

class _SearchEngineState extends State<SearchEngine> {
  var nameDestination = "";
  TextEditingController quickSearchCon = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 70,
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
                          color: Colors.grey.withOpacity(0.4))
                    ]),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: quickSearchCon,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "ex Borobudur Temple"),
                ),
              ),
            ],
          ),
        ),
        ButtonTheme(
            minWidth: MediaQuery.of(context).size.width,
            height: 50.0,
            child: RaisedButton.icon(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              label: Text("Search Now", style: TextStyle(color: Colors.white)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              color: Colors.red[600],
              onPressed: () {
                if (quickSearchCon.text.isNotEmpty) {
                  setState(() {
                    nameDestination =  quickSearchCon.text;
                    quickSearchCon.text = "";
                    print(nameDestination);
                  });
                  Get.to(SearchQuickResultDestination(nameDestination: nameDestination,idZone: widget.idZone));
                }
                else{
                  Fluttertoast.showToast(
                        toastLength: Toast.LENGTH_SHORT,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        msg: "Sorry, your search is empty");
                  print("empty");
                }
              }
              // Get.to(SearchEngineDestination()
              ,
            )),
      ],
    );
  }
}
