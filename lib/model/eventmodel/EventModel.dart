import 'Data.dart';

class EventModel {
  EventModel({
      String? status, 
      num? results, 
      Data? data,}){
    _status = status;
    _results = results;
    _data = data;
}

  EventModel.fromJson(dynamic json) {
    _status = json['status'];
    _results = json['results'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _status;
  num? _results;
  Data? _data;

  String? get status => _status;
  num? get results => _results;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['results'] = _results;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}