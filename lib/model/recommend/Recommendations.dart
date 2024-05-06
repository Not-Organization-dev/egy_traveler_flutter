import 'Category.dart';
import 'dart:convert';

Recommendations recommendationsFromJson(String str) => Recommendations.fromJson(json.decode(str));
String recommendationsToJson(Recommendations data) => json.encode(data.toJson());
class Recommendations {
  Recommendations({
      this.id, 
      this.name, 
      this.description, 
      this.image, 
      this.location, 
      this.latitude, 
      this.category, 
      this.longitude, 
      this.rating,
      this.idRe,
      this.v,});

  Recommendations.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    description = json['description'];
    image = json['image'] ?? 'https://static.vecteezy.com/system/resources/previews/004/141/669/original/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg';
    location = json['location'];
    latitude = json['latitude'];
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
    longitude = json['longitude'];
    rating = json['rating'];
    idRe = json['id'];
    v = json['__v'];
  }
  String? id;
  String? name;
  String? description;
  String? image;
  String? location;
  num? latitude;
  Category? category;
  num? longitude;
  num? rating;
  num? idRe;
  num? v;
Recommendations copyWith({
  String? id,
  String? name,
  String? description,
  String? image,
  String? location,
  num? latitude,
  Category? category,
  num? longitude,
  num? rating,
  List<dynamic>? highlights,
  List<dynamic>? reviews,
  num? idRe,
  num? v,
}) => Recommendations(  id: id ?? this.id,
  name: name ?? this.name,
  description: description ?? this.description,
  image: image ?? this.image,
  location: location ?? this.location,
  latitude: latitude ?? this.latitude,
  category: category ?? this.category,
  longitude: longitude ?? this.longitude,
  rating: rating ?? this.rating,
  idRe: idRe ?? this.idRe,
  v: v ?? this.v,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['image'] = image;
    map['location'] = location;
    map['latitude'] = latitude;
    if (category != null) {
      map['category'] = category?.toJson();
    }
    map['longitude'] = longitude;
    map['rating'] = rating;
    map['id'] = idRe;
    map['__v'] = v;
    return map;
  }

}