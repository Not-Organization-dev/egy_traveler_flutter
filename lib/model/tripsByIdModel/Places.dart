class Places {
  Places({
      String? name, 
      String? description,
      String? image,
      String? startAt, 
      String? endAt,
      dynamic longitude
      ,dynamic latitude,
      String? id,}){
    _name = name;
    _image = image;
    _description = description;
    _longitude = longitude;
    _latitude = latitude;
    _startAt = startAt;
    _endAt = endAt;
    _id = id;
}

  Places.fromJson(dynamic json) {
    _name = json['name'];
    _description = json['description'];
    _image = json['image'] ?? 'https://static.vecteezy.com/system/resources/previews/004/141/669/original/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg';
    _longitude = json['longitude'];
    _latitude = json['latitude'];
    _startAt = json['startAt'];
    _endAt = json['endAt'];
    _id = json['_id'];
  }
  String? _name;
  String? _image;
  String? _description;
  dynamic _longitude;
  dynamic _latitude;
  String? _startAt;
  String? _endAt;
  String? _id;

  String? get name => _name;

  String? get image => _image;
  String? get description => _description;
  dynamic get longitude => _longitude;
  dynamic get latitude => _latitude;
  String? get startAt => _startAt;
  String? get endAt => _endAt;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['description'] = _description;
    map['image'] = _image;
    map['longitude'] = _longitude;
    map['latitude'] = _latitude;
    map['startAt'] = _startAt;
    map['endAt'] = _endAt;
    map['_id'] = _id;
    return map;
  }

}