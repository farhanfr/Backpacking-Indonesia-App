import 'package:backpacking_indonesia/page/choose_zone.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class FirstOpen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset("assets/images/firstopen.jpg",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Get best place in Indonesia",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.0,
                          height: 1.5,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins"),
                    ),
                    Text(
                      "Many wonderful place, you can find at Indonesia",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          height: 1.5,
                          fontWeight: FontWeight.normal,
                          fontFamily: "Poppins"),
                    ),
                    SizedBox(height:50.0),
                    ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width,
                      height: 50.0,
                      child: RaisedButton(
                          color: Colors.red[600],
                          child: Text(
                            "Explore Now",
                            style: TextStyle(color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          onPressed: ()=>Get.to(ChooseZone())
                          ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
