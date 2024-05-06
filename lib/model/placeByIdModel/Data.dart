import 'Place.dart';

class Data {
  Data({
      Place? place,}){
    _place = place;
}

  Data.fromJson(dynamic json) {
    _place = json['place'] != null ? Place.fromJson(json['place']) : null;
  }
  Place? _place;

  Place? get place => _place;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_place != null) {
      map['place'] = _place?.toJson();
    }
    return map;
  }

}