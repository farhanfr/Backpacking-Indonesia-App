import 'package:flutter/material.dart';

class SearchEngineDestination extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: new IconThemeData(color: Colors.black),
        title: Text(
          "Search Your Destination",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 25.0,horizontal: 15.0),
        child: Column(
          children: <Widget>[
            SearchEngine(),
            Align(
              alignment: Alignment.topLeft,
              child: Text("Results",style: TextStyle(
                fontSize: 25,
                fontFamily: "Poppins"
              ),)  ,
            ),
          ],
        ),
      ),
    );
  }
}

class SearchEngine extends StatefulWidget {
  @override
  _SearchEngineState createState() => _SearchEngineState();
}

class _SearchEngineState extends State<SearchEngine> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: SizedBox(
        height: 100,
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
              textInputAction: TextInputAction.send,
              decoration: InputDecoration(
                 border: InputBorder.none,
                hintText: "Insert the destination ..."
              ),
            ),
          ),            
          ],
        ),
      ),
    );
  }
}
