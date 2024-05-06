import 'Trips.dart';

class Data {
  Data({
      List<Trips>? trips,}){
    _trips = trips;
}

  Data.fromJson(dynamic json) {
    if (json['trips'] != null) {
      _trips = [];
      json['trips'].forEach((v) {
        _trips?.add(Trips.fromJson(v));
      });
    }
  }
  List<Trips>? _trips;

  List<Trips>? get trips => _trips;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_trips != null) {
      map['trips'] = _trips?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}