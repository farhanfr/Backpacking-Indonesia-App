import 'package:backpacking_indonesia/page/first_open.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => FirstOpen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/images/backpack.png",
            width: 150.0,
          ),
          SizedBox(height: 20.0),
          Text(
            "Backpacking Indonesia",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 32.0,
                height: 1.5,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins"),
          ),
          SizedBox(
            height: 20.0,
          ),
          if (isLoading)
            SizedBox(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red[600]),
              ),
            )
          else
            Text("1")
        ],
      ),
    );
  }
}
