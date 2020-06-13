import 'dart:convert';

import 'package:backpacking_indonesia/model/user_model.dart';
import 'package:backpacking_indonesia/page/first_open.dart';
import 'package:backpacking_indonesia/storing/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameInp = new TextEditingController();
  TextEditingController passwordInp = new TextEditingController();

  Future<Null> login() async {
    if (usernameInp.text == "" || passwordInp.text == "") {
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          msg: "Username and password can't be empty");
    } else {
      final response = await http.post(
          "http://192.168.1.7:8000/api/v1/user/login",
          body: {"username": usernameInp.text, "password": passwordInp.text});
      

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        UserModel userModel = new UserModel.fromJson(data);
        if (userModel.status == true) {
          SharedPref().addIntToSF("idUser", userModel.data.user.id);
          SharedPref().addStringToSF("nameUser", userModel.data.user.name_user);
          SharedPref().addStringToSF("token", userModel.data.user.token);
          SharedPref().addBoolToSF("isLogin", true);
          Fluttertoast.showToast(
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              msg: "Success Login");
          Future.delayed(Duration(seconds: 3), () {
            Get.off(FirstOpen());
          });

          print("BERHASIL LOGIN TOKEN : ${userModel.data.user.token}");
        } else {
          Fluttertoast.showToast(
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              msg: "Sorry, username or password is wrong");
          print("gagal login");
        }
      }
      else{
        print("RESPONS GAGA;");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(color: Colors.black)),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
          child: Column(
            children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    "assets/images/backpack.png",
                    width: 100.0,
                  )),
              SizedBox(
                height: 30.0,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Get feature app with",
                    style: TextStyle(fontFamily: "Poppins", fontSize: 20.0)),
              ),
              SizedBox(
                height: 5.0,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Login",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 30.0),
              TextField(
                controller: usernameInp,
                decoration: InputDecoration(
                    hintText: "Input username",
                    labelText: "Username",
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    suffixIcon: Icon(
                      Icons.person,
                      color: Colors.black,
                    )
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(radius)
                    // )
                    ),
              ),
              SizedBox(
                height: 40.0,
              ),
              TextField(
                controller: passwordInp,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Input password",
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    suffixIcon: Icon(
                      Icons.lock,
                      color: Colors.black,
                    )
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(radius)
                    // )
                    ),
              ),
              SizedBox(height: 60.0),
              ButtonTheme(
                minWidth: MediaQuery.of(context).size.width,
                height: 50.0,
                child: RaisedButton(
                    color: Colors.red[600],
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    onPressed: () {
                      login();
                    }),
              ),
              SizedBox(
                height: 30.0,
              ),
              Center(
                  child: InkWell(
                child: Text("Not have account ?"),
                onTap: () {},
              ))
            ],
          ),
        ),
      ),
    );
  }
}
