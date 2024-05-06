import 'Trip.dart';

class Data {
  Data({
      Trip? trip,}){
    _trip = trip;
}

  Data.fromJson(dynamic json) {
    _trip = json['trip'] != null ? Trip.fromJson(json['trip']) : null;
  }
  Trip? _trip;

  Trip? get trip => _trip;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_trip != null) {
      map['trip'] = _trip?.toJson();
    }
    return map;
  }

}