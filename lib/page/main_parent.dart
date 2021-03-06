import 'dart:convert';

import 'package:backpacking_indonesia/model/user_model.dart';
import 'package:backpacking_indonesia/page/auth/login.dart';
import 'package:backpacking_indonesia/page/choose_zone.dart';
import 'package:backpacking_indonesia/page/destination_fast/search_destination_fast.dart';
import 'package:backpacking_indonesia/page/destination_specific/search_destination_spesific.dart';
import 'package:backpacking_indonesia/storing/shared_pref.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MainParent extends StatefulWidget {
  @override
  _MainParentState createState() => _MainParentState();
}

class _MainParentState extends State<MainParent> {
  static int index = 0, statusMenu = 0;
  List<Widget> list = [SearchDestinationSpesific(), SearchDestinationFast()];

  var loading = true;
  var nameUserPref = "";
  var tokenUser = "";
  var isLogin = false;
  _getNameUserWithToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nameUserPref = (prefs.getString("nameUser"));
      tokenUser = (prefs.getString("token"));
      isLogin = (prefs.getBool("isLogin"));
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getNameUserWithToken();
  }

  @override
  // print(tokenUser);
  Widget build(BuildContext context) {
    print(tokenUser);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: loading
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0.0,
                iconTheme: new IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                title: Text("Navigation Drawer2"),
              ),
              body: list[index],
              drawer: MyDrawer(
                  selected: statusMenu,
                  nameUserPref: nameUserPref,
                  isLogin: isLogin,
                  onTap: (ctx, i) {
                    setState(() {
                      index = i;
                      statusMenu = i;
                      Navigator.pop(ctx);
                    });
                  }),
            ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  final Function onTap;
  final int selected;
  final String nameUserPref;
  final bool isLogin;

  Future<Null> logout() async {
    final response = await http
        .put("http://192.168.1.7:8000/api/v1/user/logout", body: {"id": "1"});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      UserModel userModel = new UserModel.fromJson(data);
      if (userModel.status == true) {
        print(userModel.message);
        SharedPref().removeValues("idUser");
        SharedPref().removeValues("nameUser");
        SharedPref().removeValues("token");
        SharedPref().removeValues("isLogin");
        Get.to(Login());
      } else {
        print("gagal login");
      }
    } else {
      print("RESPONS GAGA;");
    }
  }

  MyDrawer({this.selected, this.onTap, this.nameUserPref, this.isLogin});

  @override
  Widget build(BuildContext context) {
    debugPrint(selected.toString());
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.red[600]),
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      child: CircleAvatar(
                        backgroundImage: AssetImage("assets/images/hanzo.jpg"),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      isLogin == null ? "Guest" : nameUserPref,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "Traveller",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(15),
                child: Text("Main Menu",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                        fontWeight: FontWeight.bold))),
            Container(
              color: selected == 0 ? Colors.red[100] : Colors.transparent,
              child: ListTile(
                  leading: Icon(Icons.search),
                  title: Text("Search Destination Spesific"),
                  onTap: () => onTap(context, 0)),
            ),
            Container(
              color: selected == 1 ? Colors.red[100] : Colors.transparent,
              child: ListTile(
                  leading: Icon(Icons.flash_on),
                  title: Text("Search Destination Quick"),
                  onTap: () => onTap(context, 1)),
            ),
            ListTile(
                leading: Icon(Icons.arrow_back),
                title: Text("Back to choose zone"),
                onTap: () => Get.to(ChooseZone())),
            Divider(height: 1),
            Padding(
                padding: EdgeInsets.all(15),
                child: Text("Other's Menu",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                        fontWeight: FontWeight.bold))),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              // onTap: (){
              //   SharedPref().removeValues("idUser");
              //   SharedPref().removeValues("nameUser");
              //   SharedPref().removeValues("token");
              //   SharedPref().removeValues("isLogin");
              //   Get.to(Login());
              // }
            ),
            isLogin == null
                ? ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text("Login"),
                    onTap: () {
                      Get.to(Login());
                    })
                : ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text("Logout"),
                    onTap: () {
                      logout();
                    }),
          ],
        ),
      ),
    );
  }
}
