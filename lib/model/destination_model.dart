// class DestinationModel{
//   final bool status;
//   final String message;
//   final Data data;
//   final City city;

//   DestinationModel({this.status, this.message, this.data, this.city});

//   factory DestinationModel.fromJson(Map <String,dynamic> json){
//     return new DestinationModel(
//       status: json['status'],
//       message: json['message'],
//       data: Data.fromJson(json['data']),
//       city: City.fromJson(json['city'])
//     );
//   }
// }

class DestinationModel{
  final int id;
  final int city_id;
  final String name_destination;
  final String desc_destination;
  final String photo;
  final City city;

  DestinationModel({this.id, this.city_id, this.name_destination, this.desc_destination, this.photo, this.city});
  
  factory DestinationModel.fromJson(Map <String,dynamic> json){
      return new DestinationModel(
        id:json['id'],
        city_id:json['city_id'],
        name_destination:json['name_destination'],
        desc_destination: json['desc_destination'],
        photo: json['photo'],
        city: City.fromJson(json['city'])
      );
  }
}

class City{
  final int id;
  final int province_id;
  final String name_city;
  final String photo;

  City({this.id, this.province_id, this.name_city, this.photo});

  factory City.fromJson(Map <String,dynamic> json){
      return new City(
        id:json['id'],
        province_id:json['province_id'],
        name_city:json['name_city'],
        photo: json['photo']
      );
  }

}