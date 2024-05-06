import 'Places.dart';

class Trips {
  Trips({
      String? id, 
      String? name, 
      String? description, 
      String? image, 
      String? location, 
      List<Places>? places, 
      num? rating, 
      num? v,}){
    _id = id;
    _name = name;
    _description = description;
    _image = image;
    _location = location;
    _places = places;
    _rating = rating;
    _v = v;
}

  Trips.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _description = json['description'];
    _image = json['image'] ?? 'https://static.vecteezy.com/system/resources/previews/004/141/669/original/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg';
    _location = json['location'];
    if (json['places'] != null) {
      _places = [];
      json['places'].forEach((v) {
        _places?.add(Places.fromJson(v));
      });
    }
    _rating = json['rating'];
    _v = json['__v'];
  }
  String? _id;
  String? _name;
  String? _description;
  String? _image;
  String? _location;
  List<Places>? _places;
  num? _rating;
  num? _v;

  String? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get image => _image;
  String? get location => _location;
  List<Places>? get places => _places;
  num? get rating => _rating;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['image'] = _image;
    map['location'] = _location;
    if (_places != null) {
      map['places'] = _places?.map((v) => v.toJson()).toList();
    }
    map['rating'] = _rating;
    map['__v'] = _v;
    return map;
  }

}