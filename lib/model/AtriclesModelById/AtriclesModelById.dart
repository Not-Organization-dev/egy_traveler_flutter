import 'Data.dart';

class AtriclesModelById {
  AtriclesModelById({
      String? status, 
      Data? data,}){
    _status = status;
    _data = data;
}

  AtriclesModelById.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _status;
  Data? _data;

  String? get status => _status;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}