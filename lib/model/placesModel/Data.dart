import 'Places.dart';

class Data {
  Data({
      List<Places>? places,}){
    _places = places;
}

  Data.fromJson(dynamic json) {
    if (json['places'] != null) {
      _places = [];
      json['places'].forEach((v) {
        _places?.add(Places.fromJson(v));
      });
    }
  }
  List<Places>? _places;

  List<Places>? get places => _places;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_places != null) {
      map['places'] = _places?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}