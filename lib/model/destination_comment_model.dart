// To parse this JSON data, do
//
//     final destinationCommentModel = destinationCommentModelFromJson(jsonString);

import 'dart:convert';

List<DestinationCommentModel> destinationCommentModelFromJson(String str) =>
    List<DestinationCommentModel>.from(
        json.decode(str).map((x) => DestinationCommentModel.fromJson(x)));

String destinationCommentModelToJson(List<DestinationCommentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DestinationCommentModel {
  DestinationCommentModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory DestinationCommentModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] == false) {
      return DestinationCommentModel(
          status: json["status"], message: json["message"]);
    }
    else if (json["message"] == "comment is empty") {
      return DestinationCommentModel(
          status: json["status"], message: json["message"]);
    }
    else if (json["message"] == "Success to add comment") {
      return DestinationCommentModel(
          status: json["status"], message: json["message"]);
    }
    return DestinationCommentModel(
      status: json["status"],
      message: json["message"],
      data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.cityId,
    this.destinationId,
    this.userId,
    this.comment,
    this.commentDate,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int cityId;
  int destinationId;
  int userId;
  String comment;
  String commentDate;
  dynamic createdAt;
  dynamic updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        cityId: json["city_id"],
        destinationId: json["destination_id"],
        userId: json["user_id"],
        comment: json["comment"],
        commentDate: json["comment_date"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city_id": cityId,
        "destination_id": destinationId,
        "user_id": userId,
        "comment": comment,
        "comment_date": commentDate,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
