class ProvinceModel{
  final int id;
  final int zone_id;
  final String name_province;
  final String photo;
  final Zone zone;

  ProvinceModel({this.id, this.zone_id, this.name_province, this.photo, this.zone,});
  
  factory ProvinceModel.fromJson(Map<String,dynamic> json){
      return new ProvinceModel(
        id:json['id'],
        zone_id:json['zone_id'],
        name_province:json['name_province'],
        photo: json['photo'],
        zone: Zone.fromJson(json['zone'])
      );
  }
}

class Zone{
  final int id;
  final int zone_id;
  final String name_province;
  final String photo;

  Zone({this.id, this.zone_id, this.name_province, this.photo});

  factory Zone.fromJson(Map <String,dynamic> json){
      return new Zone(
        id:json['id'],
        zone_id:json['zone_id'],
        name_province:json['name_province'],
        photo: json['photo']
      );
  }

}