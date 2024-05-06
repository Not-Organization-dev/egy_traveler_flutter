import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));
String categoryToJson(Category data) => json.encode(data.toJson());
class Category {
  Category({
      this.id, 
      this.name, 
      this.v,});

  Category.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    v = json['__v'];
  }
  String? id;
  String? name;
  num? v;
Category copyWith({  String? id,
  String? name,
  num? v,
}) => Category(  id: id ?? this.id,
  name: name ?? this.name,
  v: v ?? this.v,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['__v'] = v;
    return map;
  }

}