class Place {
  Place({
      String? id, 
      String? name, 
      String? description, 
      String? location, 
      num? latitude, 
      num? longitude, 
      num? rating, 
      num? v,
      bool? isFavorite,
      bool? isTrip,
      String? image,}){
    _id = id;
    _name = name;
    _description = description;
    _isFavorite = isFavorite;
    _isTrip = isTrip;
    _location = location;
    _latitude = latitude;
    _longitude = longitude;
    _rating = rating;
    _v = v;
    _image = image;
}

  Place.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _description = json['description'];
    _location = json['location'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _isFavorite = json['isFavorite'];
    _isTrip = json['isTrip'];
    _rating = json['rating'];
    _v = json['__v'];
    _image = json['image'] ?? 'https://static.vecteezy.com/system/resources/previews/004/141/669/original/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg';
  }
  String? _id;
  String? _name;
  bool? _isFavorite ;
  bool? _isTrip ;
  String? _description;
  String? _location;
  num? _latitude;
  num? _longitude;
  num? _rating;
  num? _v;
  String? _image;

  String? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get location => _location;
  num? get latitude => _latitude;
  num? get longitude => _longitude;
  num? get rating => _rating;
  bool? get isFavorite => _isFavorite;
  bool? get isTrip => _isTrip;
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
    map['rating'] = _rating;
    map['__v'] = _v;
    map['isFavorite'] = _isFavorite;
    map['isTrip'] = _isTrip;
    map['image'] = _image;
    return map;
  }

}