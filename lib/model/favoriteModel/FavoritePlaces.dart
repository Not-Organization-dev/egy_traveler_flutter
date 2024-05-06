class FavoritePlaces {
  FavoritePlaces({
      String? id, 
      String? name, 
      String? description, 
      String? location, 
      num? latitude, 
      num? longitude, 
      num? rating, 
      List<String>? reviews, 
      num? v, 
      String? image,
      num? idr,
      String? category, 
      List<String>? highlights,}){
    _id = id;
    _name = name;
    _description = description;
    _location = location;
    _latitude = latitude;
    _longitude = longitude;
    _idr = idr;
    _rating = rating;
    _reviews = reviews;
    _v = v;
    _image = image;
    _category = category;
    _highlights = highlights;
}

  FavoritePlaces.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _description = json['description'];
    _location = json['location'];
    _latitude = json['latitude'];
    _idr = json['id'];
    _longitude = json['longitude'];
    _rating = json['rating'];
    _reviews = json['reviews'] != null ? json['reviews'].cast<String>() : [];
    _v = json['__v'];
    _image = json['image'] ?? 'https://static.vecteezy.com/system/resources/previews/004/141/669/original/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg';
    _category = json['category'];
    _highlights = json['highlights'] != null ? json['highlights'].cast<String>() : [];
  }
  String? _id;
  String? _name;
  String? _description;
  String? _location;
  num? _idr;
  num? _latitude;
  num? _longitude;
  num? _rating;
  List<String>? _reviews;
  num? _v;
  String? _image;
  String? _category;
  List<String>? _highlights;

  String? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get location => _location;
  num? get latitude => _latitude;

  num? get idr => _idr;
  num? get longitude => _longitude;
  num? get rating => _rating;
  List<String>? get reviews => _reviews;
  num? get v => _v;
  String? get image => _image;
  String? get category => _category;
  List<String>? get highlights => _highlights;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['location'] = _location;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['rating'] = _rating;
    map['reviews'] = _reviews;
    map['__v'] = _v;
    map['idr'] = _idr;
    map['image'] = _image;
    map['category'] = _category;
    map['highlights'] = _highlights;
    return map;
  }

}