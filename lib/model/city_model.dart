class CityModel{
  final int id;
  final int province_id;
  final String name_city;
  final String photo;
  final Province province;

  CityModel({this.id, this.province_id, this.name_city, this.photo,this.province});

  factory CityModel.fromJson(Map <String,dynamic> json){
      return new CityModel(
        id:json['id'],
        province_id:json['province_id'],
        name_city:json['name_city'],
        photo: json['photo'],
        province: Province.fromJson(json['province'])
      );
  }
}

class Province{
  final int id;
  final int province_id;
  final String name_city;
  final String photo;


  Province({this.id, this.province_id, this.name_city, this.photo,});
  
  factory Province.fromJson(Map<String,dynamic> json){
      return new Province(
        id:json['id'],
        province_id:json['province_id'],
        name_city:json['name_city'],
        photo: json['photo'],
      );
  }
}

