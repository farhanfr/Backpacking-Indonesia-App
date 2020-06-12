import 'dart:convert';

class UserModel {
  bool status;
  List<dynamic> message;
  Data data;

  UserModel({this.status, this.message, this.data});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    if (json['status'] == false) {
      return UserModel(
        status: json['status'],
        message: json['message'],
      );
    } else {
      var msgSucArr = [];
      msgSucArr.add(json['message']);
      return UserModel(
          status: json['status'],
          message: msgSucArr,
          data: Data.fromJson(json['data']));
    }
  }
}

class Data {
  String secret;
  User user;

  Data({this.secret, this.user});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(secret: json['secret'], user: User.fromJson(json['user']));
  }
}

class User {
  int id;
  String name_user;
  String no_hp;
  String email_user;
  String username;
  String token;

  User({this.id, this.name_user, this.no_hp, this.email_user, this.username,this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name_user: json['name_user'],
        no_hp: json['no_hp'],
        email_user: json['email_user'],
        username: json['username'],
        token: json['token']
        );
  }
}
