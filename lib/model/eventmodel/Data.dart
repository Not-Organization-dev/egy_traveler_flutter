import 'Events.dart';

class Data {
  Data({
      List<Events>? events,}){
    _events = events;
}

  Data.fromJson(dynamic json) {
    if (json['events'] != null) {
      _events = [];
      json['events'].forEach((v) {
        _events?.add(Events.fromJson(v));
      });
    }
  }
  List<Events>? _events;

  List<Events>? get events => _events;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_events != null) {
      map['events'] = _events?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}