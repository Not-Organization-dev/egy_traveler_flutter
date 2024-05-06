import 'Event.dart';

class Data {
  Data({
      Event? event,}){
    _event = event;
}

  Data.fromJson(dynamic json) {
    _event = json['event'] != null ? Event.fromJson(json['event']) : null;
  }
  Event? _event;

  Event? get event => _event;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_event != null) {
      map['event'] = _event?.toJson();
    }
    return map;
  }

}