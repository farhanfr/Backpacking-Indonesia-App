import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';

class BackButtonIntercept extends StatefulWidget {
  @override
  _BackButtonInterceptState createState() => _BackButtonInterceptState();
}

class _BackButtonInterceptState extends State<BackButtonIntercept> {

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    myInterceptor(true);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
    stopDefaultButtonEvent = false;
    if (stopDefaultButtonEvent) {
      print("coba1");
      return false;
    } else {
      print("coba2");
      return true;
    }
    // SharedPref().removeValues("IndexChooseZone");
    // Get.to(ChooseZone());
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
