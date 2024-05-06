class Places {
  Places({
      String? id,
      num? idr,
      String? name, 
      String? description, 
      String? location, 
      num? latitude, 
      num? longitude, 
      num? rating, 
      List<dynamic>? reviews, 
      num? v, 
      String? image,}){
    _id = id;
    _idr = idr;
    _name = name;
    _description = description;
    _location = location;
    _latitude = latitude;
    _longitude = longitude;
    _rating = rating;
    // _reviews = reviews;
    _v = v;
    _image = image;
}

  Places.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _idr = json['id'];
    _description = json['description'];
    _location = json['location'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _rating = json['rating'];
   /* if (json['reviews'] != null) {
      _reviews = [];
      json['reviews'].forEach((v) {
        _reviews?.add(Dynamic.fromJson(v));
      });
    }*/
    _v = json['__v'];
    _image = json['image'] ?? 'https://static.vecteezy.com/system/resources/previews/004/141/669/original/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg';
  }
  String? _id;
  String? _name;
  num? _idr;
  String? _description;
  String? _location;
  num? _latitude;
  num? _longitude;
  num? _rating;
  // List<dynamic>? _reviews;
  num? _v;
  String? _image;

  String? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get location => _location;
  num? get idr => _idr ;
  num? get latitude => _latitude;
  num? get longitude => _longitude;
  num? get rating => _rating;
  // List<dynamic>? get reviews => _reviews;
  num? get v => _v;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['location'] = _location;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['id'] = _idr;
    map['rating'] = _rating;
  /*  if (_reviews != null) {
      map['reviews'] = _reviews?.map((v) => v.toJson()).toList();
    }*/
    map['__v'] = _v;
    map['image'] = _image;
    return map;
  }

}