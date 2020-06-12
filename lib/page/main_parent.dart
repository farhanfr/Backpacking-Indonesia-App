import 'package:backpacking_indonesia/page/auth/login.dart';
import 'package:backpacking_indonesia/page/choose_zone.dart';
import 'package:backpacking_indonesia/page/destination_fast/search_destination_fast.dart';
import 'package:backpacking_indonesia/page/destination_specific/search_destination_spesific.dart';
import 'package:backpacking_indonesia/storing/shared_pref.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainParent extends StatefulWidget {
  @override
  _MainParentState createState() => _MainParentState();
}

class _MainParentState extends State<MainParent> {

  static int index = 0,statusMenu=0;
  List<Widget> list = [SearchDestinationSpesific(), SearchDestinationFast()];

  var loading = true;
  var nameUserPref="";
  var tokenUser ="";
  var isLogin = false;
  _getNameUserWithToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nameUserPref = (prefs.getString("nameUser"));
      tokenUser = (prefs.getString("token"));
      loading = false;
    });
  }

  _checkTokenUser(){
    if (tokenUser == " ") {
      setState(() {
        isLogin = false;
      });
      print("KOSONG");
    }else{
      setState(() {
        isLogin = true;
      });
      print("GK KSONG");
    }
  }

@override
  void initState() {
    super.initState();
    _getNameUserWithToken();
    _checkTokenUser();
    // print(tokenUser);
    // print(isLogin);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
      loading ? Center(child: CircularProgressIndicator()) :
       Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text("Navigation Drawer2"),
        ),
        body: list[index],
        drawer: MyDrawer(selected: statusMenu,nameUserPref:nameUserPref,isLogin:isLogin ,onTap: (ctx, i) {
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

  MyDrawer({this.selected,this.onTap,this.nameUserPref, this.isLogin});
  

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
                     nameUserPref
                      ,
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
            Padding(padding: EdgeInsets.all(15),
            child: Text("Main Menu",style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
              fontWeight: FontWeight.bold
            ))),
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
                title: Text("Search Destination Faster"),
                onTap: () => onTap(context, 1)),
            ),
            Divider(height: 1),
            Padding(padding: EdgeInsets.all(15),
            child: Text("Other's Menu",style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
              fontWeight: FontWeight.bold
            ))),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Logout Sementara"),
              onTap: (){
                SharedPref().removeValues("idUser");
                SharedPref().removeValues("nameUser");
                SharedPref().removeValues("token");
                Get.to(Login());
              }
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Back to choose zone"),
              onTap: ()=>Get.to(ChooseZone())
            ),
          ],
        ),
      ),
    );
  }
}
