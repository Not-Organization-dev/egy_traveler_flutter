class Event {
  Event({
      String? id, 
      String? name, 
      String? description, 
      num? latitude, 
      num? longitude, 
      String? location, 
      String? startAt, 
      String? endAt, 
      num? v, 
      List<String>? images,}){
    _id = id;
    _name = name;
    _description = description;
    _latitude = latitude;
    _longitude = longitude;
    _location = location;
    _startAt = startAt;
    _endAt = endAt;
    _v = v;
    _images = images;
}

  Event.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _description = json['description'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _location = json['location'];
    _startAt = json['startAt'];
    _endAt = json['endAt'];
    _v = json['__v'];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
  }
  String? _id;
  String? _name;
  String? _description;
  num? _latitude;
  num? _longitude;
  String? _location;
  String? _startAt;
  String? _endAt;
  num? _v;
  List<String>? _images;

  String? get id => _id;
  String? get name => _name;
  String? get description => _description;
  num? get latitude => _latitude;
  num? get longitude => _longitude;
  String? get location => _location;
  String? get startAt => _startAt;
  String? get endAt => _endAt;
  num? get v => _v;
  List<String>? get images => _images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['location'] = _location;
    map['startAt'] = _startAt;
    map['endAt'] = _endAt;
    map['__v'] = _v;
    map['images'] = _images;
    return map;
  }

}